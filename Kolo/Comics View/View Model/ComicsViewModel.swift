//
//  ComicsViewModel.swift
//  Kolo
//
//  Created by Hardeep on 13/04/22.
//

import Foundation
import UIKit
import SwiftyJSON
import SVProgressHUD

class ComicsViewModel {
    
    var comicsData = ComicsDataModel()
    var observer = Observable("")
    
    var paginationID = 0
    var selectedFilter: String? {
        didSet {
            paginationID = 0
            callNetComics(offset: 0)
        }
    }
    
    init() {
    }
    
    func getCellSize() -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: (UIScreen.main.bounds.width/2) - 15, height: 200)
        }
        else {
            return CGSize(width: 120, height: 200)
        }
    }
    
    func getCellCount() -> Int {
        return comicsData.results.count
    }
    
    func getImage(index: Int) -> String {
        guard comicsData.results.count > index else {return ""}
        let item = comicsData.results[index].thumbnail
        
        let path = item.path
        let ext = item.pathExtension
        let size = AAConstants.standard_fantastic
        
        return path + "/" + size + "." + ext
    }
    
    func getTitle(index: Int) -> String {
        guard comicsData.results.count > index else {return ""}
        return comicsData.results[index].title == "" ? AAConstants.marvel:comicsData.results[index].title
    }
    
    func getDescription(index: Int) -> String {
        guard comicsData.results.count > index else {return ""}
        return comicsData.results[index].description == "" ? AAConstants.readMore:comicsData.results[index].description
    }
    
    func getUrl(index: Int) -> String {
        guard comicsData.results.count > index, comicsData.results[index].urls.count > 0 else {return ""}
        return comicsData.results[index].urls[0].url
    }
    
    func callPagination(index: Int) {
        guard comicsData.results.count > index else {return}
        
        if comicsData.results[index].id != paginationID {
            paginationID = comicsData.results[index].id
            
            callNetComics(offset: comicsData.limit + comicsData.offset)
        }
    }
    
    func callNetComics(offset: Int) {
        
        var params: NSDictionary = ["limit":20, "offset": offset]
        
        if let filter = selectedFilter, filter != "" {
            params = ["limit":20, "offset": offset, "dateDescriptor": filter]
        }
        
        SVProgressHUD.show()
        Networking.shared.request(urlStr: URLExt.comics, param: params) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let json):
                if json["code"].stringValue == "200" {
                    self.handleResponse(json: json)
                }
                else {
                    print(json["code"].stringValue)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func handleResponse(json: JSON) {
        var temp = comicsData
        
        if paginationID == 0 {
            temp = ComicsDataModel(json: json["data"])
        }
        else {
            temp.limit = json["data"]["limit"].intValue
            temp.offset = json["data"]["offset"].intValue
            for item in json["data"]["results"].arrayValue {
                temp.results.append(ComicsResultsDataModel(json: item))
            }
        }
        
        comicsData = temp
        observer.value = ""
    }
}
