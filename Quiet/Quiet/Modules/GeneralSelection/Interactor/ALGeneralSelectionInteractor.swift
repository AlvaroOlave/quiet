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
            guard let response = $0 else { completion(self.fakeResponse()); return }
            completion(ALSectionElem.sectionElemsFrom(dict: response, of: self.section))
        }
    }
    
    func fakeResponse() -> [ALSectionElem] {
        return [ALSectionElem(title: "New Resuorce", imgURL: "", resourceURL: "", isPremium: true, kindOfResource: self.section),
                ALSectionElem(title: "New Resuorce2", imgURL: "", resourceURL: "", isPremium: false, kindOfResource: self.section),
                ALSectionElem(title: "New Resuorce3", imgURL: "", resourceURL: "", isPremium: true, kindOfResource: self.section),
                ALSectionElem(title: "New Resuorce4", imgURL: "", resourceURL: "", isPremium: false, kindOfResource: self.section)]
    }
}
