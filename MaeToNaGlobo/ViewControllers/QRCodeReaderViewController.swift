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

    private var readingLayer: CALayer?

    var qrCodeReader: CodeReader = AVCodeReader()
    var viewModel = QRCodeReaderViewModel()

    //MARK: ViewModel

    private func bindInputToViewModel(_ code: String) {
        viewModel.code = code
    }

    //MARK: life cycle
    override func viewDidLoad() {
        setupUI()
        setupReadingLayer()
        startReading()
    }

    override func viewDidLayoutSubviews() {
        readingLayer?.frame = qrCodeFrame.bounds
    }

    override func viewWillDisappear(_ animated: Bool) {
        qrCodeReader.stopReading()
    }


    //MARK: --

    private func startReading() {
        qrCodeReader.startReading { [unowned self] (code) in
            self.bindInputToViewModel(code)
        }
    }

    private func setupReadingLayer() {
        readingLayer = qrCodeReader.videoPreview

        if let readingLayer = readingLayer {
            qrCodeFrame.layer.addSublayer(readingLayer)
        }
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
