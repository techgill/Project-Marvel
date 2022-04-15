//
//  CharctersResultDataModel.swift
//  Kolo
//
//  Created by Hardeep on 15/04/22.
//

import Foundation
import SwiftyJSON

struct CharctersResultDataModel {
    var id = 0
    var name = ""
    var description = ""
    var thumbnail = ThumbnailDataModel()
    var urls = [UrlsDataModel]()
    
    init() {}
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.thumbnail = ThumbnailDataModel(json: json["thumbnail"])
        for item in json["urls"].arrayValue {
            self.urls.append(UrlsDataModel(json: item))
        }
    }
}
