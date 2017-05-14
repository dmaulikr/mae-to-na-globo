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

    let apiClient: ApiClient = OpenShiftApiClient()

    var code: String = "" {
        didSet {
            findLogo(byId: code)

        }
    }

    var didReturnFromApi: ((Result<Data>) -> Void)?


    private func findLogo(byId id: String) {
        apiClient.findLogo(forId: id) { [unowned self] (result) in
            switch result {
            case .success(let data):
                self.didReturnFromApi?(.success(data))

            case .failure(let error):
                self.didReturnFromApi?(.failure(error))
            }
        }
    }

}
