//
//  MyFilter.swift
//  ios-blur-sample
//
//  Created by ro on 2018/09/12.
//  Copyright © 2018年 michi. All rights reserved.
//

import Foundation
import GPUImage

class GPUImageWrapper {
    class func apply(_ source: UIImage) -> UIImage {
        let blur = GPUImageiOSBlurFilter()
        blur.blurRadiusInPixels = 0.5
        return blur.image(byFilteringImage: source)
    }
}

class CIFilterWrapper {
    class func applyBoxBlur(_ source: UIImage) -> UIImage? {
        if let filter = CIFilter(name: "CIBoxBlur"), let cgimg = source.cgImage {
            filter.setDefaults()
            filter.setValue(CIImage(cgImage: cgimg), forKey: kCIInputImageKey)
            if let outimg = filter.outputImage {
                return UIImage(ciImage: outimg)
            }
        }
        return nil
    }

    class func applyDiscBlur(_ source: UIImage) -> UIImage? {
        if let filter = CIFilter(name: "CIDiscBlur"), let cgimg = source.cgImage {
            filter.setDefaults()
            filter.setValue(CIImage(cgImage: cgimg), forKey: kCIInputImageKey)
            if let outimg = filter.outputImage {
                return UIImage(ciImage: outimg)
            }
        }
        return nil
    }

    class func applyGaussianBlur(_ source: UIImage) -> UIImage? {
        if let filter = CIFilter(name: "CIGaussianBlur"), let cgimg = source.cgImage {
            filter.setDefaults()
            filter.setValue(CIImage(cgImage: cgimg), forKey: kCIInputImageKey)
            if let outimg = filter.outputImage {
                return UIImage(ciImage: outimg)
            }
        }
        return nil
    }
}
