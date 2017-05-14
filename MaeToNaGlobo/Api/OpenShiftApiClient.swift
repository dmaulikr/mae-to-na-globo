//
//  OpenShiftApiClient.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import Foundation

class OpenShiftApiClient: ApiClient {

    let baseUrl = URL(string: "http://testing-teste.cloudapps.hackaton.solutionarchitectsredhat.com.br/")!

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

}

extension NSError {
    static var dumb: Error {
        return NSError(domain: "foo", code: -11, userInfo: [:])
    }
}
