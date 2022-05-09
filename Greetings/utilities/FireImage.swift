//
//  FireImage.swift
//  Greetings
//
//  Created by Yu on 2022/05/09.
//

import Foundation
import UIKit

class FireImage {
    
    static func toSquare(from: UIImage) -> UIImage {
        
        var image = from
        
        var oneSide: CGFloat = 0
        if image.size.width < image.size.height {
            oneSide = image.size.width
        } else {
            oneSide = image.size.height
        }
        
        var origin: CGPoint = CGPoint()
        if image.size.width < image.size.height {
            origin = CGPoint(x: 0.0, y: (image.size.width - image.size.height) * 0.5)
        } else {
            origin = CGPoint(x: (image.size.height - image.size.width) * 0.5, y: 0.0)
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: oneSide, height: oneSide), false, 0.0)
        image.draw(in: CGRect(origin: origin, size: CGSize(width: image.size.width, height: image.size.height)))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
