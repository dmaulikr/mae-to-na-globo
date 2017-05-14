//
//  OpenShiftApiClient.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import Foundation
import Alamofire

class OpenShiftApiClient: ApiClient {

    private let baseUrl = URL(string: "http://testing-teste.cloudapps.hackaton.solutionarchitectsredhat.com.br/")!

    func findLogo(forId programId: String,
                  completion: @escaping (ApiResult<Data>) -> Void) {

        let findLogoUrl =  baseUrl.appendingPathComponent("/images/hackathon_globo/")

        let session = URLSession.shared
        let task = session.dataTask(with: findLogoUrl) { (data, response, error) in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError.dumb))
                return
            }

            completion(.success(data))
        }

        task.resume()



    }

    //TODO: Remove library whenever possilbe
    func send(images: [Data], forId: String,
              completion: @escaping (ApiResult<Void>) -> Void) {

        let sendImagesUrl = baseUrl.appendingPathComponent("/images/hackathon_globo/upload")

        Alamofire.upload(
            multipartFormData: { (multipartFormData) in
                for (index, imageDate) in images.enumerated() {
                    multipartFormData.append(imageDate, withName: "file", fileName: "photo\(index).jpeg", mimeType: "image/jpeg")
                }
        },
        to: sendImagesUrl.absoluteURL,
        encodingCompletion: { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.validate().responseString { response in
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        completion(.success())
                    case .failure(let error):
                        completion(.failure(error))
                    }

                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        })

    }

}

extension Data {
    mutating func appendString(_ str: String) {
        self.append(Data(str.utf8))
    }
}

extension NSError {
    static var dumb: Error {
        return NSError(domain: "foo", code: -11, userInfo: [:])
    }
}
