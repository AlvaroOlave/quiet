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
    let resourceURL: Any?
    let isPremium: Bool
    let kindOfResource: Section
    
    static func sectionElemsFrom(dict: [Any], of section: Section) -> [ALSectionElem] {
        return dict.compactMap {
            guard let elem = $0 as? [AnyHashable: Any] else { return nil }
            
            var resource: Any? = nil
            
            switch section {
            case .SleepCast:
                resource = (elem["resourceURL"] as? String ?? "", elem["secondaryResourceURL"] as? String ?? "")
            case .Landscapes:
                resource = elem["resourceURLs"] as? [String] ?? []
            default:
                resource = elem["resourceURL"] as? String ?? ""
            }
            
            return ALSectionElem(title: elem["title"] as? String ?? "",
                                 imgURL: elem["imgURL"] as? String ?? "",
                                 resourceURL: resource,
                                 isPremium: elem["isPremium"] as? Bool ?? false,
                                 kindOfResource: section)
        }
    }
}
