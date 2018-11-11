//
//  LargeImageDownSizingDelegate.swift
//  Oxygen
//
//  Created by Meiliang Dong on 2018/10/21.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//

public protocol LargeImageDownsizingDelegate: AnyObject {
    func largeImageDownsizingOperation(_ op: LargeImageDownsizingOperation, didUpdateGeneratedImage generatedImage: UIImage) -> Void;
    
    func largeImageDownsizingOperationDidFinish(_ op: LargeImageDownsizingOperation, generatedImage: UIImage) -> Void;
    
    func largeImageDownsizingOperation(_ op: LargeImageDownsizingOperation, failedWithError error: NSError) -> Void;
}
