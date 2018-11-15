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

    private let image: UIImage
    private let scale: CGFloat
    
    open override class var layerClass: AnyClass {
        return CATiledLayer.self
    }
    
    public init(frame: CGRect, image: UIImage, scale: CGFloat) {
        self.image = image
        self.scale = scale
        
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func encode(with aCoder: NSCoder) {
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
