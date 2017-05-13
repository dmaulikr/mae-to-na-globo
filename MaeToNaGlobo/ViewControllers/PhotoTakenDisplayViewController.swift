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
    var photo: UIImage?

    override func viewDidLoad() {
        photoImageView.image = photo
    }

}
