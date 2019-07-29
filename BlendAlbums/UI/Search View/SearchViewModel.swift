//
//  SearchViewModel.swift
//  BlendAlbums
//
//  Created by Mark Davies on 7/27/19.
//  Copyright © 2019 Mark Davies. All rights reserved.
//

import Foundation

enum ViewMode {
    case AlbumSearch
    case AlbumImages(albumID:String)
}

class SearchViewModel {
    
    var images:[Image] = []
    let imgurAPI:ImgurAPI = ImgurAPI()
    
    var albumsCount:Int {
        get {
            return images.count
        }
    }
    
    func getImage(at index:Int) -> Image?  {
        return index < images.count  ? images[index] : nil
    }
    
    func fetchAlbums(withQuery query:String, onCompletion:@escaping ()->Void, onError:@escaping (Error)->Void) {
        
        self.imgurAPI.getAlbums( withSearchText: query, onCompletion: { [weak self] images in
            
            if let images = images {
                DispatchQueue.main.async {
                    self?.images = images
                    onCompletion()
                }
            }
        }) { error in
            onError(error)
        }
    }
    
    func fetchImages(forAlbumID albumID:String, onCompletion:@escaping ()->Void, onError:@escaping (Error)->Void) {
        
        self.imgurAPI.getAlbumImages(forAlbumID: albumID, onCompletion: { [weak self] images in
            
            if let images = images {
                DispatchQueue.main.async {
                    self?.images = images
                    onCompletion()
                }
            }
            
        }) { error in
            onError(error)
        }
        
    }
    
}
