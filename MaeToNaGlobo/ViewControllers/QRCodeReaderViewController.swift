//
//  QRCodeReaderViewController.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit

class QRCodeReaderViewController: UIViewController {

    @IBOutlet weak var qrCodeGuide: UIView!
    @IBOutlet weak var qrCodeFrame: UIView!


    override func viewDidLoad() {
        setupUI()
    }

    private func setupUI() {
        makeQrCodeGuideBordersRounded()
        makeQrCodeFrameBordersRounded()
    }


    private func makeQrCodeGuideBordersRounded() {
        qrCodeGuide.layer.cornerRadius = 4
        qrCodeGuide.layer.masksToBounds = true
    }

    private func makeQrCodeFrameBordersRounded() {
        qrCodeFrame.layer.cornerRadius = 4
        qrCodeGuide.layer.masksToBounds = false
    }



}
