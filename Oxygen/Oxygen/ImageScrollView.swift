//
//  ImageScrollView.swift
//  Oxygen
//
//  Created by Meiliang Dong on 2018/11/17.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//

import UIKit

open class ImageScrollView: UIScrollView {
    
    private let image: UIImage
    
    private var hasSettedUpTiledImageView = false
    
    private var minmumScale: CGFloat = 1.0
    private var imageScale: CGFloat = 1.0
    private var frontTiledImageView: TiledImageView!
    
    public init(frame: CGRect, image: UIImage) {
        self.image = image
        
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if !hasSettedUpTiledImageView {
            hasSettedUpTiledImageView = true
            
            var imageRect = CGRect(x: 0, y: 0, width: image.cgImage?.width ?? 1, height: image.cgImage?.height ?? 1)
            
            imageScale = frame.width / imageRect.size.width
            minimumZoomScale = 0.75 * imageScale
            
            imageRect.size = CGSize(width: imageRect.size.width * imageScale, height: imageRect.size.height * imageScale)
            
            let scaledImage = ImageHelper.scaledImage(image, factor: imageScale)
            frontTiledImageView = TiledImageView(frame: imageRect, image: scaledImage, scale: imageScale)
        }
    }
}
