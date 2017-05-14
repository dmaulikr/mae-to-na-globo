//
//  PhotoTakenDisplayViewController.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit

class PhotoTakenDisplayViewController: UIViewController {


    @IBOutlet weak var photoImageView: UIImageView!
    var participationModel: ParticipationModel?

    private var activityView: UIView!

    override func viewDidLoad() {
        guard participationModel?.firstPhoto != nil || participationModel?.secondPhoto != nil else {
            fatalError("Can not show display photo if participationModel on PhotoTakenDisplayViewController has no photo")
        }

        if let secondPhoto = participationModel?.secondPhoto {
            photoImageView.image = secondPhoto
        } else if let firstPhoto = participationModel?.firstPhoto {
            photoImageView.image = firstPhoto
        }

    }

    @IBAction func acceptPhoto() {
        guard participationModel?.secondPhoto == nil else {
            sendImages()
            return
        }
        performSegue(withIdentifier: "askNextSelf", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "askNextSelf", let takeSelfVC = segue.destination as? TakeSelfViewController {
            takeSelfVC.alternativeInstructions = "Tire uma self olhando para um lado"
            takeSelfVC.participationModel = participationModel
            takeSelfVC.eachPhoto = .second
        }

        if segue.identifier == "showDone" {
            segue.destination.navigationItem.hidesBackButton = true
        }
    }

    private func sendImages() {
        guard let id = participationModel?.qrCode, let firstPhoto = participationModel?.firstPhoto, let secondPhoto = participationModel?.secondPhoto,
        let firstPhotoData = UIImageJPEGRepresentation(firstPhoto, 1), let secondData = UIImageJPEGRepresentation(secondPhoto, 1) else {
            return
        }

        let model = ParticipationViewModel.Model(id: id, imagesDatas: [firstPhotoData, secondData])
        startLoading()
        _ = ParticipationViewModel(model: model) { (result) in
            DispatchQueue.main.async {

                self.endLoading()

                switch result {
                case .success:

                    self.performSegue(withIdentifier: "showDone", sender: nil)
                case .failure(let error):
                    //TODO Handler error
                    print(error)
                }

            }
        }
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
