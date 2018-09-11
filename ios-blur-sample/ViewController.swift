//
//  ViewController.swift
//  ios-blur-sample
//
//  Created by ro on 2018/09/10.
//  Copyright © 2018年 michi. All rights reserved.
//

import UIKit
import GPUImage

typealias Pair = (String, UIImage)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var ary: [Pair] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")

        // normal
        ary.append(("normal", lenaImage))

        // gpuimage
        ary.append(("gpuimage", useGPUImage()))

        // cifilter
        if let img = useCIFilter_BoxBlur() {
            ary.append(("cifilter, box blur", img))
        }
        if let img = useCIFilter_DiscBlur() {
            ary.append(("cifilter, disc blur", img))
        }
        if let img = useCIFilter_GaussianBlur() {
            ary.append(("cifilter, gaussian blur", img))
        }
    }

    let lenaImage = UIImage(named: "lena")!

    func useGPUImage() -> UIImage {
        let blur = GPUImageiOSBlurFilter()
        blur.blurRadiusInPixels = 0.5
        return blur.image(byFilteringImage: lenaImage)
    }

    func useCIFilter_BoxBlur() -> UIImage? {
        if let filter = CIFilter(name: "CIBoxBlur"), let cgimg = lenaImage.cgImage {
            filter.setDefaults()
            filter.setValue(CIImage(cgImage: cgimg), forKey: kCIInputImageKey)
            if let outimg = filter.outputImage {
                return UIImage(ciImage: outimg)
            }
        }
        return nil
    }
    func useCIFilter_DiscBlur() -> UIImage? {
        if let filter = CIFilter(name: "CIDiscBlur"), let cgimg = lenaImage.cgImage {
            filter.setDefaults()
            filter.setValue(CIImage(cgImage: cgimg), forKey: kCIInputImageKey)
            if let outimg = filter.outputImage {
                return UIImage(ciImage: outimg)
            }
        }
        return nil
    }
    func useCIFilter_GaussianBlur() -> UIImage? {
        if let filter = CIFilter(name: "CIGaussianBlur"), let cgimg = lenaImage.cgImage {
            filter.setDefaults()
            filter.setValue(CIImage(cgImage: cgimg), forKey: kCIInputImageKey)
            if let outimg = filter.outputImage {
                return UIImage(ciImage: outimg)
            }
        }
        return nil
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let pair = ary[indexPath.row]
        cell.textLabel?.text = pair.0
        cell.imageView?.image = pair.1

        return cell
    }
}
