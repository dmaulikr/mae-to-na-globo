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
            //TODO sendo to viewModel
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
    }

}
