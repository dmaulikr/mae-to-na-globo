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
    private var activityView: UIView!

    var qrCodeReader: CodeReader = AVCodeReader()
    var viewModel = QRCodeReaderViewModel()



    //MARK: ViewModel

    private func bindInputToViewModel(_ code: String) {
        viewModel.code = code
        startLoading()
    }

    private func bindOutputFromViewModel() {
        viewModel.didReturnFromApi = { [unowned self] result in
            DispatchQueue.main.async {
                self.handle(result: result)
            }

        }
    }

    private func handle(result: Result<Data>) {
        self.endLoading()
        switch result {
        case .success(let imageData):
            guard !self.viewModel.code.isEmpty else { fatalError("Returned from didReturnFromApi, but viewModel.code is empty ") }
            guard let logoFound = UIImage(data: imageData) else {
                //TODO: Handle error
                print("Could not use data from didReturnFromApi to create UIImage")
                return
            }

            let model = ProgramFoundViewController.Model(logo: logoFound, qrCode: self.viewModel.code)
            self.performSegue(withIdentifier: "showProgramFound", sender: model)
        case .failure(let error):
            //TODO: Handle error
            print(error)
            break
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

    private func startLoading() {
        navigationItem.hidesBackButton = true
        activityView = UIView(frame: view.frame)
        activityView.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.startAnimating()
        activityView.addSubview(activityIndicator)
        activityIndicator.center = activityView.center

        view.addSubview(activityView)
    }

    private func endLoading() {
        navigationItem.hidesBackButton = false
        activityView.removeFromSuperview()
    }



}
