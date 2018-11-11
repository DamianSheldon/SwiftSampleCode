//
//  LargeImageDownSizingOperation.swift
//  Oxygen
//
//  Created by Meiliang Dong on 2018/10/21.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//

import UIKit

open class LargeImageDownsizingOperation: Operation {

    public enum LargeImageDownsizingError: Error {
        case imageNotFound
        case failCreateOutputBitmapContext
        case failCroppingSourceTile
        case failMakeDestCGImage
        case failGenerateImage
    }
    
    open weak var delegate: LargeImageDownsizingDelegate?
    
    private var configuration: LargeImageDownsizingConfiguration
    private let filename: String
    
    public init(configuration: LargeImageDownsizingConfiguration, filename: String) {
        self.configuration = configuration
        self.filename = filename
        
        super.init()
    }
    
    open override func main() {
        downsizeImageAtPath(filename)
    }
    
    open func downsizeImageAtPath(_ path: String) {
        
        guard let sourceImage = UIImage(named: filename, in: Bundle.main, compatibleWith: nil)?.cgImage else {
            delegate?.largeImageDownsizingOperation(self, failedWithError:type(of: self).imageNotFoundError())
            return
        }
        
        let sourceTotalPixels = Double(sourceImage.width * sourceImage.height)
        let imageScale = configuration.destTotalPixels / sourceTotalPixels
        
        let destResolutionWidth = Int(Double(sourceImage.width) * imageScale)
        let destResolutionHeight = Int(Double(sourceImage.height) * imageScale)
        
        let destBitmapData = UnsafeMutableRawPointer.allocate(byteCount: destResolutionWidth * destResolutionHeight * Int(LargeImageDownsizingConfiguration.bytesPerPixel), alignment: 1)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let destContext = CGContext(data: destBitmapData, width: destResolutionWidth, height: destResolutionHeight, bitsPerComponent: 8, bytesPerRow: 4 * destResolutionWidth, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
            else {
                delegate?.largeImageDownsizingOperation(self, failedWithError:type(of: self).failCreateOutputBitmapContextError())
                return
        }
        
        // flip the output graphics context so that it aligns with the
        // cocoa style orientation of the input document. this is needed
        // because we used cocoa's UIImage -imageNamed to open the input file.
        destContext.translateBy(x: 0, y: CGFloat(destResolutionHeight))
        destContext.scaleBy(x: 1, y: -1)
        
        // now define the size of the rectangle to be used for the
        // incremental blits from the input image to the output image.
        // we use a source tile width equal to the width of the source
        // image due to the way that iOS retrieves image data from disk.
        // iOS must decode an image from disk in full width 'bands', even
        // if current graphics context is clipped to a subrect within that
        // band. Therefore we fully utilize all of the pixel data that results
        // from a decoding opertion by achnoring our tile size to the full
        // width of the input image.
        var sourceTile = CGRect(x: 0, y: 0, width: sourceImage.width, height: Int(configuration.tileTotalPixels) / sourceImage.width)
        
        // calculate the number of read/write opertions required to assemble the
        // output image.
        var iterations = sourceImage.height / Int(sourceTile.size.height)
        
        // if tile height doesn't divide the image height evenly, add another iteration
        // to account for the remaining pixels.
        let remainder = sourceImage.height % Int(sourceTile.size.height)
        if remainder > 0 {
            iterations += 1
        }
        
        // the source seem overlap is proportionate to the destination seem overlap.
        // this is the amount of pixels to overlap each tile as we assemble the ouput image.
        let sourceSeemOverlap = Int(LargeImageDownsizingConfiguration.destSeemOverlap / Double(destResolutionHeight) * Double(sourceImage.height))
        
        // add seem overlaps to the tiles, but save the original tile height for y coordinate calculations.
        let sourceTileHeightMinusOverlap = Int(sourceTile.size.height)
        
        var destTile = CGRect(x: 0, y: 0, width: destResolutionWidth, height: Int(Double(sourceTile.height) * imageScale))
        
        sourceTile.size.height += CGFloat(sourceSeemOverlap)
        destTile.size.height += CGFloat(LargeImageDownsizingConfiguration.destSeemOverlap)
        
        for y in 0..<iterations {
            sourceTile.origin.y = CGFloat(y * sourceTileHeightMinusOverlap + sourceSeemOverlap)
            
            destTile.origin.y = CGFloat(Double(destResolutionHeight) - (Double((y + 1) * sourceTileHeightMinusOverlap) * imageScale + LargeImageDownsizingConfiguration.destSeemOverlap))
            
            // create a reference to the source image with its context clipped to the argument rect.
            guard let sourceTileImage = sourceImage.cropping(to: sourceTile)
                else {
                    delegate?.largeImageDownsizingOperation(self, failedWithError:type(of: self).failCroppingSourceTileError())
                    return
            }
            
            // if this is the last tile, it's size may be smaller than the source tile height.
            // adjust the dest tile size to account for that difference.
            if y == iterations - 1 && remainder > 0 {
                var dify = destTile.size.height
                destTile.size.height = CGFloat(Double(sourceTileImage.height) * imageScale)
                dify -= destTile.size.height
                destTile.origin.y += dify
            }
            
            // read and write a tile sized portion of pixels from the input image to the output image.
            destContext.draw(sourceTileImage, in: destTile)
            
            if y < iterations - 1 {
                guard let destImage = destContext.makeImage()
                    else {
                        delegate?.largeImageDownsizingOperation(self, failedWithError:type(of: self).failMakeDestCGImageError())
                        return
                }
                let image = UIImage(cgImage: destImage, scale: 1.0, orientation: UIImage.Orientation.downMirrored)
                
                delegate?.largeImageDownsizingOperation(self, didUpdateGeneratedImage: image)
            }
        }
        
        guard let destImage = destContext.makeImage()
            else {
                delegate?.largeImageDownsizingOperation(self, failedWithError:type(of: self).failMakeDestCGImageError())
                return
        }
        let image = UIImage(cgImage: destImage, scale: 1.0, orientation: UIImage.Orientation.downMirrored)
        
        delegate?.largeImageDownsizingOperationDidFinish(self, generatedImage: image)
        
        destBitmapData.deallocate()
    }
}

fileprivate extension LargeImageDownsizingOperation {
    
    enum DownsizingErrorDescription: String {
        case imageNotFound = "image not found"
        case failCreateOutputBitmapContext = "fail to create output bitmap context"
        case failCroppingSourceTile = "fail to cropping source tile"
        case failMakeDestCGImage = "fail to make dest CGImage"
        case failGenerateImage = "fail to generate image"
    }
    
    enum DownsizingErrorCode: Int {
        case imageNotFound
        case failCreateOutputBitmapContext
        case failCroppingSourceTile
        case failMakeDestCGImage
        case failGenerateImage
    }
    
    static func errorWithCode(_ code: Int, description: String) -> NSError {
        return NSError(domain: "com.tenneshop.error", code: code, userInfo: [NSLocalizedDescriptionKey : description])
    }
    
    static func imageNotFoundError() -> NSError {
        return errorWithCode(DownsizingErrorCode.imageNotFound.rawValue, description: DownsizingErrorDescription.imageNotFound.rawValue)
    }
    
    static func failCreateOutputBitmapContextError() -> NSError {
        return errorWithCode(DownsizingErrorCode.failCreateOutputBitmapContext.rawValue, description: DownsizingErrorDescription.failCreateOutputBitmapContext.rawValue)
    }
    
    static func failCroppingSourceTileError() -> NSError {
        return errorWithCode(DownsizingErrorCode.failCroppingSourceTile.rawValue, description: DownsizingErrorDescription.failCroppingSourceTile.rawValue)
    }
    
    static func failMakeDestCGImageError() -> NSError {
        return errorWithCode(DownsizingErrorCode.failMakeDestCGImage.rawValue, description: DownsizingErrorDescription.failMakeDestCGImage.rawValue)
    }
    
    static func failGenerateImageError() -> NSError {
        return errorWithCode(DownsizingErrorCode.failGenerateImage.rawValue, description: DownsizingErrorDescription.failGenerateImage.rawValue)
    }
}
