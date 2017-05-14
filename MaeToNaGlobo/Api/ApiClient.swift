//
//  ApiClient.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import Foundation

enum ApiResult<T> {
    case success(T)
    case failure(Error)
}

protocol ApiClient {
    func findLogo(forId: String,
                  completion: @escaping (ApiResult<Data>) -> Void)

    func send(images: [Data], forId: String,
              completion: @escaping (ApiResult<Void>) -> Void)
}
