//
//  LocalizeManager.swift
//  orderAround
//
//  Created by CSS on 22/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation


enum Language : String, Codable, CaseIterable {
    case english = "en"
//    case arabic = "ar"
  //  case japanese = "ja"
    case french = "fr"
    
    var code : String {
        switch self {
        case .english:
            return "en"
        case .french:
            return "fr"
//        case .arabic:
//            return "ar"
//        case .japanese:
//            return "ja"
        }
    }
    
    var title : String {
        switch self {
        case .english:
            return APPLocalize.localizestring.English
        case .french:
            return APPLocalize.localizestring.French
//        case .arabic:
//            return APPLocalize.localizestring.Arabic
//        case .japanese:
//            return APPLocalize.localizestring.Japanese
        }
    }
    
    static var count: Int{ return 2 }
}


class LocalizeManager {
    
    static func changeLocalization(language:Language) {
        let defaults = UserDefaults.standard
        defaults.set(language.rawValue, forKey: "Language")
        UserDefaults.standard.synchronize()
    }
    
    static func currentlocalization() -> String {
        if let savedLocale = UserDefaults.standard.object(forKey: "Language") as? String {
            return savedLocale
        }
        return Language.french.rawValue
    }
    
    static func currentLanguage() -> String{
        
        switch LocalizeManager.currentlocalization() {
        case Language.english.rawValue:
            return Constants.string.English.localize()
            case Language.french.rawValue:
            return Constants.string.french.localize()
        
//        case Language.arabic.rawValue:
//            return Constants.string.Arabic.localize()
//        case Language.japanese.rawValue:
//            return Constants.string.Japanese.localize()
            
        default:
            return ""
        }
    }
}
