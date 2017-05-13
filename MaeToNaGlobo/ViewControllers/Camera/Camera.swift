//
//  Camera.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit

protocol SelfCamera {

    var videoPreview: CALayer {get}

    func start()
    func stop()
    func takePhoto() -> UIImage

}
