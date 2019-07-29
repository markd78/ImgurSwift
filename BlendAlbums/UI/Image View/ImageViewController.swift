//
//  ImageViewController.swift
//  BlendAlbums
//
//  Created by Mark Davies on 7/28/19.
//  Copyright © 2019 Mark Davies. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image:Image?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.delegate = self
        
        if let image = image {
            imageView.imageFromServerURL(urlString: image.imageURL)
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    

}
