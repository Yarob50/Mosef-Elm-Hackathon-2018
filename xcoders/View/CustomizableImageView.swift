//
//  CustomizableImageView.swift
//   
//
//  Created by يعرب المصطفى on 8/10/16.
//  Copyright © 2016 يعرب المصطفى. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableImageView: UIImageView {

    @IBInspectable var cornerRad:CGFloat = 0
        {
            didSet
            {
                self.layer.cornerRadius = cornerRad
        }
    }
    
//    @IBInspectable var circled:Bool = false
//        {
//        didSet{
//            self.layer.cornerRadius = self.bounds.width/2
//        }
//    }
    
    @IBInspectable var borderWidth:CGFloat = 0
        {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

}
