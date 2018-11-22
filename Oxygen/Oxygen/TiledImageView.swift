//
//  TiledImageView.swift
//  Oxygen
//
//  Created by Meiliang Dong on 2018/11/15.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//

import UIKit
import QuartzCore

open class TiledImageView: UIView {

    private static let imageKey = "imageKey"
    private static let scaleKey = "scaleKey"
    private static let rectKey = "rectKey"
    
    private let image: UIImage
    private let scale: CGFloat
    
    private let imageRect: CGRect
    
    open override class var layerClass: AnyClass {
        return CATiledLayer.self
    }
    
    public init(frame: CGRect, image: UIImage, scale: CGFloat) {
        self.image = image
        self.scale = scale
        
        imageRect = CGRect(x: 0, y: 0, width: image.cgImage?.width ?? 0, height: image.cgImage?.height ?? 0)
        
        super.init(frame: frame)
        
        configureLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        guard let rawImage = aDecoder.decodeObject(forKey: TiledImageView.imageKey) else { return nil }
        
        guard let typedImage = rawImage as? UIImage else { return nil }
        self.image = typedImage
        
        scale = CGFloat(aDecoder.decodeDouble(forKey: TiledImageView.scaleKey))
        
        imageRect = aDecoder.decodeCGRect(forKey: TiledImageView.rectKey)
        
        super.init(coder: aDecoder)
        
        configureLayer()
    }
    
    open override func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: TiledImageView.imageKey)
        aCoder.encode(Double(scale), forKey: TiledImageView.scaleKey)
        aCoder.encode(imageRect, forKey: TiledImageView.rectKey)
    }
    
    private func configureLayer() {
        guard let tiledLayer = self.layer as? CATiledLayer else { return }
        
        // levelsOfDetail and levelsOfDetailBias determine how
        // the layer is rendered at different zoom levels.  This
        // only matters while the view is zooming, since once the
        // the view is done zooming a new TiledImageView is created
        // at the correct size and scale.
        tiledLayer.levelsOfDetail = 4
        tiledLayer.levelsOfDetailBias = 4
        tiledLayer.tileSize = CGSize(width: 512.0, height: 512.0)
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override open func draw(_ rect: CGRect) {
        
        guard let cgImage = image.cgImage else { return }
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Drawing code
        context.saveGState()
        // Scale the context so that the image is rendered
        // at the correct size for the zoom level.
        
        guard let tileCGImage = cgImage.cropping(to: rect) else {
            context.restoreGState()
            return
        }
        
        let tileImage = UIImage(cgImage: tileCGImage, scale: image.scale, orientation: image.imageOrientation)
        tileImage.draw(in: rect)

        context.restoreGState()
    }
    

}
