//
//  ParticipationViewModel.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/14/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import Foundation

class ParticipationViewModel {

    let completion: ((Result<Void>) -> Void)
    let model: Model
    let apiClient: ApiClient = OpenShiftApiClient()

    struct Model {
        var id: String
        var imagesDatas: [Data]
    }

    init(model: Model, completion: @escaping (Result<Void>) -> Void) {
        self.completion = completion
        self.model = model
        sendImages()
    }

    func sendImages() {
        apiClient.send(images: model.imagesDatas, forId: model.id) { (result) in
            switch result {
            case .success:
                self.completion(.success())
            case .failure(let error):
                self.completion(.failure(error))
            }
        }
    }

    


}
