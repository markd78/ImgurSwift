//
//  SearchTextField.swift
//  BlendAlbums
//
//  Created by Mark Davies on 7/29/19.
//  Copyright © 2019 Mark Davies. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {

    @IBInspectable var rightImage : UIImage?{
        didSet{
            
            let icon = UIImageView(image: rightImage);
            let iconHW = self.frame.size.height - 4;
            icon.frame = CGRect(x: 0, y: 0, width: iconHW + 10.0, height: iconHW)
            icon.contentMode = .scaleAspectFit
            
            self.rightView = icon
            self.rightViewMode = .always
        }
    }
}
