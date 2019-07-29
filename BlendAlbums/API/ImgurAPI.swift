//
//  ImgurAPI.swift
//  BlendAlbums
//
//  Created by Mark Davies on 7/28/19.
//  Copyright © 2019 Mark Davies. All rights reserved.
//

import Foundation

class ImgurAPI {
    
    
    func getAlbums(withSearchText searchText:String, onCompletion:@escaping (([Image]?)->Void), onError:@escaping (Error)->Void) {
        
        let query = "https://api.imgur.com/3/gallery/search?q=\(searchText)"
        imageAPIQuery(query, onCompletion, onError)};
    
    
    func getAlbumImages(forAlbumID albumHash:String, onCompletion:@escaping (([Image]?)->Void), onError:@escaping (Error)->Void) {
        
        let query = "https://api.imgur.com/3/album/\(albumHash)/images"
        imageAPIQuery(query, onCompletion, onError)
        
    }
    
    
    fileprivate func imageAPIQuery(_ query: String, _ onCompletion: @escaping (([Image]?) -> Void), _ onError: @escaping (Error) -> Void) {
        
        DataFetcher.init().getData(withQuery: query, andHeaders: [("Client-ID 6685dd82a89f8ec","Authorization")], onCompletion: { data in
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let responseData = try decoder.decode(ImgURResponse.self, from: data)
                onCompletion(responseData.data)
            }  catch let error {
                print (error)
                onError(error)
            }
        }, onError: { error in
            onError(error)
        }
            
        )
    }
    
}
