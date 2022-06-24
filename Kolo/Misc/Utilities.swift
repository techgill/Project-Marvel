//
//  Utilities.swift
//  Kolo
//
//  Created by Hardeep on 15/04/22.
//

import Foundation
import UIKit

class Utilities {
    
    static let defaults = UserDefaults.standard
    static var history = Utilities.getHistory()
    
    class func getHistory() -> [String] {
        return Utilities.defaults.stringArray(forKey: AAConstants.historyArray) ?? [String]()
    }
    
    class func saveHistory() {
        Utilities.defaults.set(Utilities.history, forKey: AAConstants.historyArray)
    }
    
    class func getNoDataLabel(text: String) -> UILabel{
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100))
        label.text = text
        label.textAlignment = .center
        
        return label
    }
    
    class func saveApiRes(data: Data) {
        Utilities.defaults.setValue(data, forKey: AAConstants.apiData)
    }
    
    class func getApiRes() -> Data? {
        Utilities.defaults.object(forKey: AAConstants.apiData) as? Data
    }
    
    class func saveString(string: String, forKey: String) {
        Utilities.defaults.set(string, forKey: forKey)
    }
    
    class func getString(forKey: String) -> String {
        Utilities.defaults.string(forKey: forKey) ?? ""
    }
    
    static let indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.color = .black
      view.startAnimating()
      return view
    }()
    
}
