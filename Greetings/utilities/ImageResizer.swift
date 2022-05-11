//
//  ImageEditor.swift
//  Greetings
//
//  Created by Yu on 2022/05/10.
//

import UIKit
import Foundation

class ImageResizer {
    
    static func resizeToSquare(image: UIImage) -> UIImage {
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
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        print("Image resized to square. width: \(resizedImage.size.width), height: \(resizedImage.size.height)")
        return resizedImage
    }
    
    static func resize(image: UIImage, oneSide: CGFloat) -> UIImage {
        let size = CGSize(width: oneSide, height: oneSide)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        print("Image resized. width: \(resizedImage.size.width), height: \(resizedImage.size.height)")
        return resizedImage
    }
}
