//
//  DataFetch.swift
//  BlendAlbums
//
//  Created by Mark Davies on 7/28/19.
//  Copyright © 2019 Mark Davies. All rights reserved.
//

import Foundation

class DataFetcher {
    
    func getData(withQuery queryStr:String, andHeaders headers:[(String,String)], onCompletion:@escaping (Data)->Void, onError:@escaping (Error)->Void) {
        
        if let url = URL(string: queryStr) {
            var request = URLRequest(url: url)
            for header in headers {
                request.addValue(header.0, forHTTPHeaderField: header.1)
            }
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err)  in
                
                if let error = err {
                    onError(error)
                } else {
                
                    guard let data = data else {
                        return
                    }
                    
                    return onCompletion(data)
                }
            }).resume()
        }
    }
}
