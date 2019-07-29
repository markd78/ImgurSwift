//
//  ViewController.swift
//  BlendAlbums
//
//  Created by Mark Davies on 7/27/19.
//  Copyright © 2019 Mark Davies. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var model = SearchViewModel()
    
    let reuseIdentifier = "AlbumCell"
    
    var viewMode = ViewMode.AlbumSearch
    
    private var shouldPresentTextSearch:Bool = true
    
    @IBOutlet weak var searchInputView: UIStackView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxt.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        switch (self.viewMode) {
        case .AlbumImages(let albumID):
            
            // hide the search, not relevent for this screen
            self.searchInputView.isHidden = true
            
            // load the images now
            model.fetchImages(forAlbumID: albumID,  onCompletion: {[weak self] in
                
                self?.collectionView.reloadData()
                
                }, onError: { error in
                    print("Error fetching images")
            })
        case .AlbumSearch:
            self.searchInputView.isHidden = false
            
            // if we're coming from home screen, present the search immediately
            if (shouldPresentTextSearch) {
                self.searchTxt.becomeFirstResponder()
                shouldPresentTextSearch = false
            }
            
            break
        }
    }
}

extension SearchViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}


extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // get the image
        if let image = model.getImage(at: indexPath.row) {
            
            if let isAlbum = image.isAlbum, isAlbum {
                // if its an album, show the album gallery
                if let albumVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController,
                    let albumID = image.id
                {
                    albumVC.viewMode = .AlbumImages(albumID: albumID)
                    self.navigationController?.pushViewController(albumVC, animated: true)
                    
                }
            } else {
                // else display the image full screen
                if let imageVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController
                {
                    imageVC.image = image
                    self.navigationController?.pushViewController(imageVC, animated: true)
                    
                }
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.albumsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! AlbumCollectionViewCell
        
        if let image = model.getImage(at: indexPath.row) {
            cell.albumImageView.imageFromServerURL(urlString: image.imageURL)
        }
        
        return cell
        
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchQuery = textField.text {
            model.fetchAlbums(withQuery:searchQuery, onCompletion: {[weak self] in
                
                self?.collectionView.reloadData()
                
                }, onError: { error in
                    print("Error fetching albums")
            })
        }
        
    }
    
}

