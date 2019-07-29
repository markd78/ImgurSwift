//
//  Album.swift
//  BlendAlbums
//
//  Created by Mark Davies on 7/27/19.
//  Copyright © 2019 Mark Davies. All rights reserved.
//

import Foundation
import UIKit

struct ImgURResponse : Codable {
    let data:[Image]?
}

struct Image : Codable {
    
    let id:String?
    let link:String?
    let title:String?
    let cover:String?
    let isAlbum:Bool?
    
    var imageURL:String {
        get {
            if let isAlbum = isAlbum, isAlbum, let cover = cover {
                return "http://i.imgur.com/\(cover).png"
            } else if let id = id {
                return "http://i.imgur.com/\(id).png"
            } else {
                return "http://www.stleos.uq.edu.au/wp-content/uploads/2016/08/image-placeholder-350x350.png"
            }
        }
    }
    
}
