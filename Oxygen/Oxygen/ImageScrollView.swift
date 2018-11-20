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
            
            addSubview(frontTiledImageView)
        }
        
        // center the image as it becomes smaller than the size of the screen
        let boundsSize = bounds.size
        var frameToCenter = frontTiledImageView.frame
        
        // center horizontally
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2.0
        }
        else {
            frameToCenter.origin.x = 0
        }
        
        // center vertically
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2.0
        }
        else {
            frameToCenter.origin.y = 0
        }
        
        frontTiledImageView.frame = frameToCenter
        
        // to handle the interaction between CATiledLayer and high resolution screens, we need to manually set the
        // tiling view's contentScaleFactor to 1.0. (If we omitted this, it would be 2.0 on high resolution screens,
        // which would cause the CATiledLayer to ask us for tiles of the wrong scales.)
        frontTiledImageView.contentScaleFactor = 1.0;
    }
}
