//
//  ALPurchaseManager.swift
//  Quiet
//
//  Created by Alvaro on 12/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import StoreKit

protocol ALStoreManagerDelegate {
    func getAvailableProductsInProcess()
    func getAvailableProductsCompleted()
    func getAvailableProductsFailed()
    func purchaising()
    func endPurchase(_ purchased: Bool)
    func showMessage(_ title: String, description: String)
}

protocol ALSubscriptionManagerDelegate: ALStoreManagerDelegate {
    func setYearlySubscriptionPrice(_ price: NSDecimalNumber, units: String)
    func setMonthlySubscriptionPrice(_ price: NSDecimalNumber, units: String)
}

struct ALProduct {
    
    let product: SKProduct
    
    init(withProduct product: SKProduct) { self.product = product }
}

class ALPurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = ALPurchaseManager()
    
    var delegate: ALStoreManagerDelegate?
    
    fileprivate var availableOptions = [ALProduct]()
    
    fileprivate override init() {
        super.init()
        
        SKPaymentQueue.default().add(self)
    }
    
    func loadAvailableSubscriptions() {
        delegate?.getAvailableProductsInProcess()
        startRequest([".subscriptions.monthly", ".subscriptions.yearly"])
    }
    
    private func startRequest(_ ids:[String]) {
        
        let request = SKProductsRequest(productIdentifiers: Set(ids.map { Bundle.main.bundleIdentifier! + $0 }))
        
        request.delegate = self
        request.start()
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    public func purchaseMonthlySubscription() -> Bool {
        return purchaseProduct(".subscriptions.monthly")
    }
    
    public func purchaseYearlySubscription() -> Bool {
        return purchaseProduct(".subscriptions.yearly")
    }
    
    fileprivate func purchaseProduct(_ productId: String) -> Bool {
        delegate?.purchaising()
        
        if let prod = productToPurchase(withId: productId) {
            purchase(product: prod)
            return true
        }
        delegate?.endPurchase(false); return false
    }
    
    fileprivate func productToPurchase(withId id: String) -> ALProduct? {
        return (availableOptions.filter { $0.product.productIdentifier == Bundle.main.bundleIdentifier! + id }).first ?? nil
    }
    
    fileprivate func purchase(product: ALProduct) {
        let payment = SKPayment(product: product.product)
        SKPaymentQueue.default().add(payment)
    }
    
    //MARK:- SKProductsRequestDelegate methods
    
    internal func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        availableOptions = response.products.map { [weak self] product -> ALProduct in
            if product.productIdentifier == Bundle.main.bundleIdentifier! + ".subscriptions.monthly" {
                (self?.delegate as? ALSubscriptionManagerDelegate)?.setMonthlySubscriptionPrice(product.price, units: product.priceLocale.currencySymbol ?? product.priceLocale.currencyCode ?? "")
            }
            else if product.productIdentifier == Bundle.main.bundleIdentifier! + ".subscriptions.yearly" {
                (self?.delegate as? ALSubscriptionManagerDelegate)?.setYearlySubscriptionPrice(product.price, units: product.priceLocale.currencySymbol ?? product.priceLocale.currencyCode ?? "")
            }
            
            return ALProduct(withProduct: product)
        }
        productRequestCompleted(true)
    }
    
    internal func request(_ request: SKRequest, didFailWithError error: Error) {
        delegate?.showMessage("Purchasing error", description: error.localizedDescription)
        productRequestCompleted(false)
    }
    
    fileprivate func productRequestCompleted(_ successfully: Bool) {
        successfully ? delegate?.getAvailableProductsCompleted() : delegate?.getAvailableProductsFailed()
    }
    
    //MARK:- SKPaymentTransactionObserver methods
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) { }
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) { }
    func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) { }
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) { }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                handlePurchasingState(for: transaction, in: queue)
            case .purchased:
                handlePurchasedState(for: transaction, in: queue)
            case .restored:
                handleRestoredState(for: transaction, in: queue)
            case .failed:
                handleFailedState(for: transaction, in: queue)
            case .deferred:
                handleDeferredState(for: transaction, in: queue)
            }
        }
    }
    
    //MARK:- HandlePurchase methods
    
    fileprivate func handlePurchasingState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        //        print("User is attempting to purchase product id: \(transaction.payment.productIdentifier)")
    }
    
    fileprivate func handlePurchasedState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        queue.finishTransaction(transaction)
        
        guard let receiptData = loadReceipt(), let transactionDate = transaction.transactionDate,
            let subscriptionTime = subscriptionTime(from: transaction.payment.productIdentifier) else { return }

        if let expireDate = Calendar.current.date(byAdding: ((subscriptionTime == "1") ? .month : .year), value: 1, to: transactionDate) {
            let newToken = ALUserToken(with: expireDate, data: receiptData)
            ALUserTokenManager.shared.setUserToken(newToken)
        }

        
//        let token = receiptData.base64EncodedString() + "@IOS@" + DateFormatter(withDateFormat: .FIREBASE).string(from: expireDate!) + "@" + subscriptionTime
    }
    
    fileprivate func handleRestoredState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        queue.finishTransaction(transaction)
        delegate?.endPurchase(true)
    }
    
    fileprivate func handleFailedState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        delegate?.showMessage("Purchase failed for product id: \(transaction.payment.productIdentifier)", description: transaction.error?.localizedDescription ?? "UNKNOWN_ERROR")
        queue.finishTransaction(transaction)
        delegate?.endPurchase(false)
    }
    
    fileprivate func handleDeferredState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        delegate?.endPurchase(false)
    }
    
    //MARK:- Receipt methods
    
    private func loadReceipt() -> Data? {
        guard let url = Bundle.main.appStoreReceiptURL else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
    
    private func subscriptionTime(from productIdentifier: String) -> String? {
        return productIdentifier == Bundle.main.bundleIdentifier! + ".subscriptions.monthly" ? "1" :
            (productIdentifier == Bundle.main.bundleIdentifier! + ".subscriptions.yearly") ? "12" : nil
    }
}
