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
        makeNavigationBarTransparent()
        changeNavigationBarTintColor()
        hideTabBar()
    }

    private func makeQrCodeIconContainerCircle() {
        qrCodeIconContainer.layer.cornerRadius = 112
    }

    private func makeOkButtonBordersRounded() {
        okButton.layer.cornerRadius = 4
    }

    private func makeNavigationBarTransparent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.backgroundColor = UIColor.clear
    }

    private func changeNavigationBarTintColor() {
        navigationController?.navigationBar.tintColor = .white
    }

    private func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
}
