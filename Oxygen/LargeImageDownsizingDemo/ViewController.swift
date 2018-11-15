//
//  ViewController.swift
//  LargeImageDownsizingDemo
//
//  Created by Meiliang Dong on 2018/11/3.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//

import UIKit
import Oxygen

class ViewController: UIViewController {

    let operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(progressView)
        configureConstraintsForProgressView()
        
        operationQueue.addOperation(largeImageDownsizingOp)
    }
    
    // MARK: Private Method
    func configureConstraintsForProgressView() -> Void {
        if #available(iOS 11.0, *) {
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            progressView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
            progressView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 1.0).isActive = true
        } else {
            view.addConstraint(NSLayoutConstraint(item: progressView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: progressView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: progressView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: progressView, attribute: .bottom, relatedBy: .equal, toItem: bottomLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0))
        }
    }

    // MARK: View
    lazy var progressView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = UIColor.red
        
        return imageView
    }()
    
    lazy var largeImageDownsizingOp: LargeImageDownsizingOperation = {
        let op = LargeImageDownsizingOperation(configuration: LargeImageDownsizingConfiguration.iPad1OriPhone3GS, filename: "large_leaves_70mp")
        op.delegate = self
        
        return op
    }()
}

extension ViewController: LargeImageDownsizingDelegate {
    func largeImageDownsizingOperation(_ op: LargeImageDownsizingOperation, didUpdateGeneratedImage generatedImage: UIImage) -> Void {
        DispatchQueue.main.async {
            self.progressView.image = generatedImage
        }
    }
    
    func largeImageDownsizingOperationDidFinish(_ op: LargeImageDownsizingOperation, generatedImage: UIImage) -> Void {
        print("largeImageDownsizingOperationDidFinish\n")
    }
    
    func largeImageDownsizingOperation(_ op: LargeImageDownsizingOperation, failedWithError error: NSError) -> Void {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}