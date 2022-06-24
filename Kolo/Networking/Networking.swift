//
//  Networking.swift
//  Kolo
//
//  Created by Hardeep on 14/04/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CryptoKit

class Networking {
    
    static let shared = Networking()
    
    enum RequestType: String{
        case GET = "GET"
    }
    
    enum NetworkError: String, Error {
        case INVALIDURL = "Invalid Url"
        case PARSINGERROR = "JSON Parsing Error"
        case INVALIDDATA = "Invalid Data, Please try again"
        case ERROR = "Something went wrong"
        case invalidCredentials = "InvalidCredentials"
    }
    
    let baseURL = "https://gateway.marvel.com:443/v1/public/"
    
    func request(urlStr: String, param: NSDictionary?, completion: @escaping (Result<JSON, NetworkError>) -> Void) {
        
        let urlString = baseURL + urlStr
        
        let url = getUrlWithParams(urlString: urlString, param: param)
        
        guard let checkedUrl = url, checkedUrl.absoluteString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) != nil else {
            return completion(.failure(NetworkError.INVALIDURL))
        }
        
        var request = URLRequest(url: checkedUrl)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = RequestType.GET.rawValue
        
        request.addValue(Utilities.getString(forKey: AAConstants.eTag), forHTTPHeaderField: "If-None-Match")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let task = URLSession.shared.dataTask(with: request) { data, res, error in
            if let _error = error {
                print("error------\(_error.localizedDescription)")
                completion(.failure(NetworkError.ERROR))
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                if httpResponse.statusCode == 304 {
                    if let data = Utilities.getApiRes() {
                        do {
                            let json = try JSON(data: data)
                            print("json-------\(json)")
                            completion(.success(json))
                        }
                        catch {
                            completion(.failure(NetworkError.PARSINGERROR))
                        }
                    }
                    return
                }
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.INVALIDDATA))
            }
            Utilities.saveApiRes(data: data)
            do {
                let json = try JSON(data: data)
                print("json-------\(json)")
                completion(.success(json))
            }
            catch {
                completion(.failure(NetworkError.PARSINGERROR))
            }
            
        }
        
        task.resume()
        
    }
    
    private func getUrlWithParams(urlString: String, param: NSDictionary?) -> URL? {
        
        guard var urlComp = URLComponents(string: urlString) else {return nil}
        
        var queryItems: [URLQueryItem] = urlComp.queryItems ??  []
        
        if let _param = param {
            for (key, value) in _param {
                queryItems.append(URLQueryItem(name: String(describing: key), value: String(describing: value)))
            }
        }
        
        let time = URLQueryItem(name: "ts", value: "1")
        let apiKey = URLQueryItem(name: "apikey", value: AAConstants.publicKey)
        
        queryItems.append(time)
        queryItems.append(apiKey)
        
        let ts = "1"
        let hash = MD5(string:"\(ts)\(AAConstants.privateKey)\(AAConstants.publicKey)")
        
        let hashKey = URLQueryItem(name: "hash", value: "\(hash)")
        
        queryItems.append(hashKey)
        
        urlComp.queryItems = queryItems
        
        print(String(describing: urlComp.url))
        return urlComp.url
    }
    
    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}


