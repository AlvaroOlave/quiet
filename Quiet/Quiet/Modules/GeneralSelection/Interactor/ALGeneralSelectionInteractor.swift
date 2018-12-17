//
//  ALGeneralSelectionInteractor.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

class ALGeneralSelectionInteractor: ALGeneralSelectionInteractorProtocol {
    var dataManager: ALGeneralSelectionDataManagerProtocol!
    var section: Section!
 
    func getResourcesList(completion: @escaping ([ALSectionElem]) -> Void) {
        dataManager.getResourcesListOf(section) {
            guard let response = $0 else { completion([]); return }
            completion(ALSectionElem.sectionElemsFrom(dict: response, of: self.section))
        }
    }
    func dismiss() { dataManager.dismiss() }
}
