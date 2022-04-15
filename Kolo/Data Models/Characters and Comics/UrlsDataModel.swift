//
//  UrlsDataModel.swift
//  Kolo
//
//  Created by Hardeep on 15/04/22.
//

import Foundation
import SwiftyJSON

struct UrlsDataModel {
    var type = ""
    var url = ""
    
    init() {}
    
    init(json: JSON) {
        self.type = json["type"].stringValue
        self.url = json["url"].stringValue
    }
}
