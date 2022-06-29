/*
 * Copyright 2022 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import SwiftUI

// MARK: - ImageProvider

protocol ImageProvider {
  func fetch(url: String, completion: @escaping (UIImage?) -> Void)
  func image(named: String) -> UIImage?
}

struct ImageProviderKey: EnvironmentKey {
  static var defaultValue: ImageProvider = DefaultImageProvider()
}

extension EnvironmentValues {
  var imageProvider: ImageProvider {
    get { self[ImageProviderKey.self] }
    set { self[ImageProviderKey.self] = newValue }
  }
}

extension View {
  func imageProvider(_ imageProvider: ImageProvider) -> some View {
    environment(\.imageProvider, imageProvider)
  }
}

// MARK: - DefaultImageProvider

class DefaultImageProvider: ImageProvider {
  // TODO: Use core httpClient instance
  var networkClient: URLSession
  
  init(
    networkClient: URLSession = URLSession.shared
  ) {
    self.networkClient = networkClient
  }
  
  func fetch(url: String, completion: @escaping (UIImage?) -> Void) {    
    guard let url = URL(string: url) else { return }
    networkClient.dataTask(with: url) { data, response, error in
      DispatchQueue.main.async {
        guard let data = data, let image = UIImage(data: data) else {
          completion(nil)
          return
        }
        completion(image)
      }
    }.resume()
  }
  
  func image(named: String) -> UIImage? {
    UIImage(named: named, in: Bundle(for: DefaultImageProvider.self), with: nil)
  }
}
