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

    let sourceImage = UIImage(named: "lena")!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")

        execute()
    }

    func execute() {
        ary.append(("normal", sourceImage))
        ary.append(("gpuimage", GPUImageWrapper.apply(sourceImage)))

        if let img = CIFilterWrapper.applyBoxBlur(sourceImage) {
            ary.append(("cifilter, box blur", img))
        }
        if let img = CIFilterWrapper.applyDiscBlur(sourceImage) {
            ary.append(("cifilter, disc blur", img))
        }
        if let img = CIFilterWrapper.applyGaussianBlur(sourceImage) {
            ary.append(("cifilter, gaussian blur", img))
        }
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
