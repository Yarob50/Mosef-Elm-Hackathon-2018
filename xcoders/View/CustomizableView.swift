//
//  CustomizableView.swift
//  تطبيق كرام
//
//  Created by يعرب المصطفى on 8/11/16.
//  Copyright © 2016 يعرب المصطفى. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableView: UIView {
    
    @IBInspectable var cornerRad:CGFloat = 0
        {
        didSet{
            self.layer.cornerRadius = cornerRad
        }
    }
    
    
    
    
    @IBInspectable var yShadow:CGFloat = 0
        {
        didSet{
            layer.shadowOffset = CGSize(width: -1, height: yShadow)
        }
    }
    
    @IBInspectable var shadowOpacity:Float = 0
        {
        didSet{
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    
    @IBInspectable var shadowRadius:CGFloat = 0
        {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0
        {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.black
        {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    
    
    
}
