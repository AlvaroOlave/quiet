//
//  ALSectionElem.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//
import Foundation

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

class ALBaseElem {
    var baseSection: ALSectionElem!
    init(baseSection: ALSectionElem!) {
        self.baseSection = baseSection
    }
}

class ALGeneralElem: ALBaseElem {
    var resource: Data?
    init(baseSection: ALSectionElem!, resource: Data?) {
        super.init(baseSection: baseSection)
        self.resource = resource
    }
}

class ALSleepCastElem: ALBaseElem {
    var primarySound: Data?
    var secondarySound: Data?
    
    init(baseSection: ALSectionElem!, primarySound: Data?, secondarySound: Data?) {
        super.init(baseSection: baseSection)
        self.primarySound = primarySound
        self.secondarySound = secondarySound
    }
}

class ALLandscapeElem: ALBaseElem {
    var images: [Data]?
    
    init(baseSection: ALSectionElem!, images: [Data]?) {
        super.init(baseSection: baseSection)
        self.images = images
    }
}
