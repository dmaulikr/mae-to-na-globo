//
//  QRCodeReadingInstructions.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit

class QRCodeReadingInstructions: UIViewController {


    @IBOutlet weak var qrCodeIconContainer: UIView!
    @IBOutlet weak var okButton: UIButton!

    override func viewDidLoad() {
        setupUI()
    }

    private func setupUI() {
        makeQrCodeIconContainerCircle()
        makeOkButtonBordersRounded()
        hideNavigationBar()
    }

    private func makeQrCodeIconContainerCircle() {
        qrCodeIconContainer.layer.cornerRadius = 112
    }

    private func makeOkButtonBordersRounded() {
        okButton.layer.cornerRadius = 4
    }

    private func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
}
