//
//  ALPurchaseManager.swift
//  Quiet
//
//  Created by Alvaro on 12/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import StoreKit

let WEEKLY = "com.quiet.subscription.weekly"
let MONTHLY = "com.quiet.subscription.monthly"
let YEARLY = "com.quiet.subscription.yearly"

let WEEKLY_OFFER = "com.quiet.subscription.offer.weekly"
let MONTHLY_OFFER = "com.quiet.subscription.offer.monthly"
let YEARLY_OFFER = "com.quiet.subscription.offer.yearly"

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
    func setWeeklySubscriptionPrice(_ price: NSDecimalNumber, units: String)
}

struct ALProduct {
    
    let product: SKProduct
    
    init(withProduct product: SKProduct) { self.product = product }
}

class ALPurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = ALPurchaseManager()
    
    var delegate: ALStoreManagerDelegate?
    
    fileprivate var availableOptions = [ALProduct]()
    
    func start() { SKPaymentQueue.default().add(self); receiptValidation() }
    
    func loadSubscriptions() {
        delegate?.getAvailableProductsInProcess()
        startRequest([WEEKLY, MONTHLY, YEARLY])
    }
    
    func loadOfferedSubscriptions() {
        delegate?.getAvailableProductsInProcess()
        startRequest([WEEKLY_OFFER, MONTHLY_OFFER, YEARLY_OFFER])
    }
    
    private func startRequest(_ ids:[String]) {
        let request = SKProductsRequest(productIdentifiers: Set(ids))
        
        request.delegate = self
        request.start()
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    public func purchaseWeeklySubscription() -> Bool {
        return purchaseProduct(WEEKLY)
    }
    
    public func purchaseMonthlySubscription() -> Bool {
        return purchaseProduct(MONTHLY)
    }
    
    public func purchaseYearlySubscription() -> Bool {
        return purchaseProduct(YEARLY)
    }
    
    public func purchaseOfferedWeeklySubscription() -> Bool {
        return purchaseProduct(WEEKLY_OFFER)
    }
    
    public func purchaseOfferedMonthlySubscription() -> Bool {
        return purchaseProduct(MONTHLY_OFFER)
    }
    
    public func purchaseOfferedYearlySubscription() -> Bool {
        return purchaseProduct(YEARLY_OFFER)
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
        return (availableOptions.filter { $0.product.productIdentifier == id }).first
    }
    
    fileprivate func purchase(product: ALProduct) {
        let payment = SKPayment(product: product.product)
        SKPaymentQueue.default().add(payment)
    }
    
    //MARK:- SKProductsRequestDelegate methods
    
    internal func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        availableOptions = response.products.map { [weak self] product -> ALProduct in
            if product.productIdentifier == WEEKLY {
                (self?.delegate as? ALSubscriptionManagerDelegate)?.setWeeklySubscriptionPrice(product.price, units: product.priceLocale.currencySymbol ?? product.priceLocale.currencyCode ?? "")
            }
            else if product.productIdentifier == MONTHLY {
                (self?.delegate as? ALSubscriptionManagerDelegate)?.setMonthlySubscriptionPrice(product.price, units: product.priceLocale.currencySymbol ?? product.priceLocale.currencyCode ?? "")
            }
            else if product.productIdentifier == YEARLY {
                (self?.delegate as? ALSubscriptionManagerDelegate)?.setYearlySubscriptionPrice(product.price, units: product.priceLocale.currencySymbol ?? product.priceLocale.currencyCode ?? "")
            } else if product.productIdentifier == WEEKLY_OFFER {
                (self?.delegate as? ALSubscriptionManagerDelegate)?.setWeeklySubscriptionPrice(product.price, units: product.priceLocale.currencySymbol ?? product.priceLocale.currencyCode ?? "")
            }
            else if product.productIdentifier == MONTHLY_OFFER {
                (self?.delegate as? ALSubscriptionManagerDelegate)?.setMonthlySubscriptionPrice(product.price, units: product.priceLocale.currencySymbol ?? product.priceLocale.currencyCode ?? "")
            }
            else if product.productIdentifier == YEARLY_OFFER {
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
        
        guard let transactionDate = transaction.transactionDate,
            let subscriptionTime = subscriptionTime(from: transaction.payment.productIdentifier) else { return }

        if let expireDate = Calendar.current.date(byAdding: subscriptionTime.0, value: subscriptionTime.1, to: transactionDate) {
            ALUserTokenManager.shared.setExpireDate(expireDate.timeIntervalSince1970 * 1000)
        }
        delegate?.endPurchase(true)
        receiptValidation()
    }
    
    fileprivate func handleRestoredState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        queue.finishTransaction(transaction)
        delegate?.endPurchase(true)
        receiptValidation()
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
    
    private func subscriptionTime(from productIdentifier: String) -> (Calendar.Component, Int)? {
        return productIdentifier == WEEKLY ? (.day, 7) :
            productIdentifier == MONTHLY ? (.month, 1) :
            productIdentifier == YEARLY ? (.year, 1) : nil
    }
    
    func receiptValidation() {
        DispatchQueue.global(qos: .userInitiated).async {
            let SUBSCRIPTION_SECRET = "049ea300898d44fd94dc98761349093a"
            let receiptPath = Bundle.main.appStoreReceiptURL?.path
            if FileManager.default.fileExists(atPath: receiptPath!){
                var receiptData:NSData?
                do{
                    receiptData = try NSData(contentsOf: Bundle.main.appStoreReceiptURL!, options: NSData.ReadingOptions.alwaysMapped)
                }
                catch{
                    print("ERROR: " + error.localizedDescription)
                }
                let base64encodedReceipt = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithCarriageReturn)
                
                let requestDictionary = ["receipt-data":base64encodedReceipt!,"password":SUBSCRIPTION_SECRET]
                
                guard JSONSerialization.isValidJSONObject(requestDictionary) else {  print("requestDictionary is not valid JSON");  return }
                do {
                    let requestData = try JSONSerialization.data(withJSONObject: requestDictionary)
                    let validationURLString = "https://sandbox.itunes.apple.com/verifyReceipt"  // this works but as noted above it's best to use your own trusted server
                    guard let validationURL = URL(string: validationURLString) else { print("the validation url could not be created, unlikely error"); return }
                    let session = URLSession(configuration: URLSessionConfiguration.default)
                    var request = URLRequest(url: validationURL)
                    request.httpMethod = "POST"
                    request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
                    let task = session.uploadTask(with: request, from: requestData) { [weak self] (data, response, error) in
                        if let data = data , error == nil {
                            do {
                                let appReceiptJSON = try JSONSerialization.jsonObject(with: data)
                                if let receipt = appReceiptJSON as? [AnyHashable: Any] {
                                    self?.parseReceiptJSON(receipt)
                                }
                            } catch let error as NSError {
                                print("json serialization failed with error: \(error)")
                            }
                        } else {
                            print("the upload task returned an error: \(String(describing: error))")
                        }
                    }
                    task.resume()
                } catch let error as NSError {
                    print("json serialization failed with error: \(error)")
                }
            }
        }
    }
    
    private func parseReceiptJSON(_ json: [AnyHashable: Any]) {
        var expiresDate: Double? = nil
        let currentDateMs = Date().timeIntervalSince1970 * 1000
        if let lastesReceipt = json["latest_receipt_info"] as? [[AnyHashable: Any]] {
            lastesReceipt.forEach { register in
                if let expireMs = register["expires_date_ms"] as? String, let expireMsDouble = Double(expireMs), expireMsDouble > currentDateMs {
                    expiresDate = (expireMsDouble > (expiresDate ?? 0.0)) ? expireMsDouble : expiresDate
                }
            }
        }
        if let expiresDate = expiresDate {
            ALUserTokenManager.shared.setExpireDate(expiresDate)
        }
    }
}
