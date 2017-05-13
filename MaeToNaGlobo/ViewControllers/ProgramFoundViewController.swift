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
    var logo: UIImage?

    override func viewDidLoad() {
        logoView.image = logo
    }


}
