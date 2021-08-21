//
//  UIImageView+Promise.swift
//  Octocat
//
//  Created by Thijs Verboon on 21/08/2021.
//

import UIKit
import PromiseKit
import AlamofireImage

extension UIImageView {
    func loadImageFrom(url: URL?) -> Promise<UIImage> {
        return Promise { seal in
            guard let url = url else {
                seal.reject(NSError(domain: "ImageLoader", code: 0))
                return
            }

            ImageDownloader().download(URLRequest(url: url), completion:  { response in
                if case .success(let image) = response.result {
                    seal.fulfill(image)
                    return
                }

                seal.reject(NSError(domain: "ImageLoader", code: 1))

            })
        }
    }
}
