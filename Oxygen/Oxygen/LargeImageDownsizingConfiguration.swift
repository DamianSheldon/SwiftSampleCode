//
//  LargeImageDownsizingConfiguration.swift
//  Oxygen
//
//  Created by Meiliang Dong on 2018/10/23.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//

import UIKit

open class LargeImageDownsizingConfiguration: NSObject {
    
    // MARK: Type properties
    /* Image Constants: for images, we define the resulting image
     size and tile size in megabytes. This translates to an amount
     of pixels. Keep in mind this is almost always significantly different
     from the size of a file on disk for compressed formats such as png, or jpeg.
     
     For an image to be displayed in iOS, it must first be uncompressed (decoded) from
     disk. The approximate region of pixel data that is decoded from disk is defined by both,
     the clipping rect set onto the current graphics context, and the content/image
     offset relative to the current context.
     
     To get the uncompressed file size of an image, use: Width x Height / pixelsPerMB, where
     pixelsPerMB = 262144 pixels in a 32bit colospace (which iOS is optimized for).
     
     Supported formats are: PNG, TIFF, JPEG. Unsupported formats: GIF, BMP, interlaced images.
     
     The arguments to the downsizing routine are the resulting image size, and
     "tile" size. And they are defined in terms of megabytes to simplify the correlation
     between images and memory footprint available to your application.
     
     The "tile" is the maximum amount of pixel data to load from the input image into
     memory at one time. The size of the tile defines the number of iterations
     required to piece together the resulting image.
     
     Choose a resulting size for your image given both: the hardware profile of your
     target devices, and the amount of memory taken by the rest of your application.
     
     Maximizing the source image tile size will minimize the time required to complete
     the downsize routine. Thus, performance must be balanced with resulting image quality.
     
     Choosing appropriate resulting image size and tile size can be done, but is left as
     an exercise to the developer. Note that the device type/version string
     (e.g. "iPhone2,1" can be determined at runtime through use of the sysctlbyname function:
     
     size_t size;
     sysctlbyname("hw.machine", NULL, &size, NULL, 0);
     char *machine = malloc(size);
     sysctlbyname("hw.machine", machine, &size, NULL, 0);
     NSString* _platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
     free(machine);
     */
    public static let bytesPerMB = 1048576.0
    public static let bytesPerPixel = 4.0
    public static let pixelsPerMB = LargeImageDownsizingConfiguration.bytesPerMB / LargeImageDownsizingConfiguration.bytesPerPixel
    public static let destSeemOverlap = 2.0 // the numbers of pixels to overlap the seems where tiles meet.
    
    // MARK: Type methods
    /* These constants are suggested initial values for iPhone3G, iPod2 and earlier devices */
    public static let iPhone3GOriPod2AndEarlier = LargeImageDownsizingConfiguration(destImageSizeMB: 30, sourceImageTileSizeMB: 10)
    
    /* These constants are suggested initial values for iPad1, and iPhone 3GS */
    public static let iPad1OriPhone3GS = LargeImageDownsizingConfiguration(destImageSizeMB: 60.0, sourceImageTileSizeMB: 20.0)
    
    /* These constants are suggested initial values for iPad2, and iPhone 4 */
    public static let iPad2OriPhone4 = LargeImageDownsizingConfiguration(destImageSizeMB: 120.0, sourceImageTileSizeMB: 40.0)
    
    // MARK: Instance properties
    open var destImageSizeMB: Double
    open var sourceImageTileSizeMB: Double
    
    open var destTotalPixels: Double {
        return destImageSizeMB * LargeImageDownsizingConfiguration.pixelsPerMB
    }
    
    open var tileTotalPixels: Double {
        return sourceImageTileSizeMB * LargeImageDownsizingConfiguration.pixelsPerMB
    }
    
    // MARK: Instance methods
    public init(destImageSizeMB: Double, sourceImageTileSizeMB: Double) {
        self.destImageSizeMB = destImageSizeMB
        self.sourceImageTileSizeMB = sourceImageTileSizeMB
        
        super.init()
    }
}
