//
//  ViewController.swift
//  ios-blur-sample
//
//  Created by ro on 2018/09/10.
//  Copyright © 2018年 michi. All rights reserved.
//

import UIKit

import GPUImage

class ViewController: UIViewController {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        useGPUImage()
        useCIFilter()
    }

    func lena() -> UIImage {
        let img = UIImage(named: "lena.jpg")!
        return img
    }
    
    func useGPUImage() {
        let blur = GPUImageiOSBlurFilter()
        blur.blurRadiusInPixels = 0.5
        image2.image = blur.image(byFilteringImage: lena())
    }
    
    func useCIFilter() {
        let old = CIImage(cgImage: lena().cgImage!)
        guard let blur = CIFilter(name: "CIGaussianBlur") else {
            print("cannot create filter")
            return
        }
        blur.setDefaults()
        blur.setValue(4.0, forKey: kCIInputRadiusKey)
        blur.setValue(old, forKey: kCIInputImageKey)
        image3.image = UIImage(ciImage: blur.outputImage!)
    }
}

