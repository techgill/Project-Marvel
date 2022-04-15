//
//  ThumbnailDataModel.swift
//  Kolo
//
//  Created by Hardeep on 15/04/22.
//

import Foundation
import SwiftyJSON

struct ThumbnailDataModel {
    var path = ""
    var pathExtension = ""
    
    init() {}
    
    init(json: JSON) {
        self.path = json["path"].stringValue
        self.pathExtension = json["extension"].stringValue
    }
}
