//
//  ComicsDataModel.swift
//  Kolo
//
//  Created by Hardeep on 15/04/22.
//

import Foundation
import SwiftyJSON

struct ComicsDataModel {
    var offset = 0
    var limit = 0
    var results = [ComicsResultsDataModel]()
    
    init() {}
    
    init(json: JSON) {
        self.offset = json["offset"].intValue
        self.limit = json["limit"].intValue
        for item in json["results"].arrayValue {
            self.results.append(ComicsResultsDataModel(json: item))
        }
    }
}
