//
//  ImageHelper.swift
//  Oxygen
//
//  Created by Meiliang Dong on 2018/11/17.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//

import UIKit

open class ImageHelper {

    public static func scaledImage(_ image: UIImage, factor: CGFloat) -> UIImage {
        guard let cgImage = image.cgImage else { return UIImage() }
        
        var imageRect = CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height)
        
        imageRect.size.width *= factor
        imageRect.size.height *= factor
        
        UIGraphicsBeginImageContext(imageRect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()

            return UIImage()
        }
        
        context.saveGState()
        
        context.draw(cgImage, in: imageRect)
        
        context.restoreGState()
        
        guard let resultImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            
            return UIImage()
        }
        
        UIGraphicsEndImageContext()
        
        return resultImage
    }
}
