//
//  ProgramFoundViewController.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit

class ProgramFoundViewController: UIViewController {

    @IBOutlet weak var logoView: UIImageView!

    struct Model {
        var logo: UIImage
        var qrCode: String
    }

    var model: Model?

    override func viewDidLoad() {
        guard model != nil else {
            fatalError("Can not continue if model on ProgramFoundViewController is nil")
        }
        logoView.image = model?.logo
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "askSelves", let takeSelfVC = segue.destination as? TakeSelfViewController, let qrCode = model?.qrCode {
            takeSelfVC.participationModel = ParticipationModel(qrCode: qrCode, firstPhoto: nil, secondPhoto: nil)
        }
    }


}
