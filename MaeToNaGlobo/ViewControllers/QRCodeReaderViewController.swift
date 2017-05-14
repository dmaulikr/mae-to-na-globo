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

    private func bindOutputFromViewModel() {
        viewModel.didReturnFromApi = { [unowned self] result in

            switch result {
            case .success(let imageData):
                guard !self.viewModel.code.isEmpty else { fatalError("Returned from didReturnFromApi, but viewModel.code is empty ") }
                guard let logoFound = UIImage(data: imageData) else { fatalError("Could not use data from didReturnFromApi to create UIImage") }

                let model = ProgramFoundViewController.Model(logo: logoFound, qrCode: self.viewModel.code)
                self.performSegue(withIdentifier: "showProgramFound", sender: model)
            case .failure(let error):
                //TODO: Handle error
                print(error)
                break
            }
            

        }
    }

    //MARK: life cycle
    override func viewDidLoad() {
        setupUI()
        setupReadingLayer()
        bindOutputFromViewModel()
    }

    override func viewDidLayoutSubviews() {
        readingLayer?.frame = qrCodeFrame.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        startReading()
    }

    override func viewWillDisappear(_ animated: Bool) {
        stopReading()
    }

    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProgramFound",
            let model = sender as? ProgramFoundViewController.Model,
            let programFoundVC = segue.destination as? ProgramFoundViewController {
            programFoundVC.model = model
        }
    }


    //MARK: --

    private func startReading() {
        qrCodeReader.startReading { [unowned self] (code) in
            self.bindInputToViewModel(code)
        }
    }

    private func stopReading() {
        qrCodeReader.stopReading()
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
