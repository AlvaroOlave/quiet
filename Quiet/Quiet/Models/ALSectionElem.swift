//
//  ALSectionElem.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//
struct ALSectionElem {
    let title: String
    let imgURL: String
    let resourceURL: String
    let isPremium: Bool
    let kindOfResource: Section
    
    static func sectionElemsFrom(dict: [Any], of section: Section) -> [ALSectionElem] {
        return dict.compactMap {
            guard let elem = $0 as? [AnyHashable: Any] else { return nil }
            return ALSectionElem(title: elem["title"] as? String ?? "",
                                 imgURL: elem["imgURL"] as? String ?? "",
                                 resourceURL: elem["resourceURL"] as? String ?? "",
                                 isPremium: elem["isPremium"] as? Bool ?? false,
                                 kindOfResource: section)
        }
    }
}
