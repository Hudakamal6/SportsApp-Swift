//
//  extension.swift
//  SportsApp
//
//  Created by Huda kamal  on 04/05/2023.
//

import Foundation
import UIKit

//extension UIImageView{
//
//    var circleImage:  UIImageView {
//
//        self.layoutIfNeeded()
//        self.layer.borderWidth = 0.5
//        self.layer.cornerRadius = self.frame.width/2
//        self.layer.borderColor = UIColor.clear.cgColor
//        return self
//        }
//}

extension UIView{
    
    var circleView:  UIView {
        
        self.layoutIfNeeded()
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderColor = UIColor.clear.cgColor
        return self
        }
}
