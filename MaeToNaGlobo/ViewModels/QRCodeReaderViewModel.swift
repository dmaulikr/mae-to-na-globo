//
//  QRCodeReaderViewModel.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import Foundation
//TODO: Remove UIKit after removing mock
import UIKit

enum Result<T> {
    case success(T)
    case failure(Error)
}

class QRCodeReaderViewModel {

    var code: String = "" {
        didSet {
            let logo: UIImage = #imageLiteral(resourceName: "logoEncontro")
            if let logoData = UIImagePNGRepresentation(logo) {
                didReturnFromApi?(.success(logoData))
            }

        }
    }

    var didReturnFromApi: ((Result<Data>) -> Void)?


}
