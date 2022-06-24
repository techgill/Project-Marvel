//
//  CharactersViewModel.swift
//  Kolo
//
//  Created by Hardeep on 14/04/22.
//

import Foundation
import UIKit
import SwiftyJSON

class CharactersViewModel {
    
    var characterData = CharctersDataModel()
    var observer: Observable<String>
    
    var isLoaded = false
    
    var paginationID = 0
    var searchText: String? {
        didSet {
            isLoaded = false
            paginationID = 0
            characterData = CharctersDataModel()
            callNetCharcters(offset: 0)
        }
    }
    
    init() {
        observer = Observable("")
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
        self.characterData.results.count
    }
    
    func getImage(index: Int) -> String {
        guard characterData.results.count > index else {return ""}
        let item = characterData.results[index].thumbnail
        
        let path = item.path
        let ext = item.pathExtension
        let size = AAConstants.standard_fantastic
        
        return path + "/" + size + "." + ext
    }
    
    func getName(index: Int) -> String {
        guard characterData.results.count > index else {return ""}
        return characterData.results[index].name == "" ? AAConstants.marvel:characterData.results[index].name
    }
    
    func getDescription(index: Int) -> String {
        guard characterData.results.count > index else {return ""}
        return characterData.results[index].description == "" ? AAConstants.readMore:characterData.results[index].description
    }
    
    func getUrl(index: Int) -> String {
        guard characterData.results.count > index, characterData.results[index].urls.count > 0 else {return ""}
        return characterData.results[index].urls[0].url
    }
    
    func callPagination(index: Int) {
        guard characterData.results.count > index else {return}
        
        if characterData.results[index].id != paginationID {
            paginationID = characterData.results[index].id
            isLoaded = false
            
            callNetCharcters(offset: characterData.limit + characterData.offset)
        }
        else {
            isLoaded = true
            observer.value = ""
        }
    }
    
    func callNetCharcters(offset: Int) {
        
        var params: NSDictionary = ["limit":20, "offset": offset]
        
        if let text = searchText, searchText != "" {
            params = ["limit":20, "offset": offset, "nameStartsWith": text]
        }
        
        Networking.shared.request(urlStr: URLExt.characters, param: params) { result in
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
        Utilities.saveString(string: json["etag"].stringValue, forKey: AAConstants.eTag)
        var temp = characterData
        
        if paginationID == 0 {
            temp = CharctersDataModel(json: json["data"])
        }
        else {
            temp.limit = json["data"]["limit"].intValue
            temp.offset = json["data"]["offset"].intValue
            for item in json["data"]["results"].arrayValue {
                temp.results.append(CharctersResultDataModel(json: item))
            }
        }
        
        characterData = temp
        observer.value = ""
    }
}
