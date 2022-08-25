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

import SwiftUI

enum ImageScale: String {
  case fillHeight // CENTER_CROP
  case fillWidth // FIT_CENTER
  case fillBounds // FIT_XY
  case center // CENTER
}

protocol BaseImage: HasAccessibility {
  var scale: ImageScale { get }
  var size: Size { get }
}

struct BaseImageView: View, BaseImage {
  @ObservedObject var model: BaseImageViewModel = BaseImageViewModel()
  var mode: BaseImageViewModel.Mode
  
  @Environment(\.imageProvider) var provider: ImageProvider
  
  var scale: ImageScale
  var size: Size
  var accessibility: Accessibility
  
  var body: some View {
    switch model.state {
    case let .image(image):
      Image(uiImage: image)
        .scale(scale)
        .modifier(SizeModifier(size: size, alignment: .center)).clipped()
        .modifier(AccessibilityModifier(accessibility: accessibility))
    case .none:
      Color.clear
        .modifier(SizeModifier(size: size))
        .onAppear {
          model.load(mode, with: provider)
        }
    }
  }
}

class BaseImageViewModel: ObservableObject {
  
  @Published var state: State = .none
  
  enum State {
    case image(UIImage)
    case none
  }
  
  enum Mode {
    case local(String)
    case remote(String, placeholder: String?)
  }
  
  func load(_ mode: Mode, with provider: ImageProvider) {
    switch mode {
    case let .remote(url, placeholder: placeholder):
      if let placeholder = placeholder {
        setState(for: provider.image(named: placeholder))
      }
      provider.fetch(url: url) { [weak self] image in
        self?.setState(for: image)
      }
    case let .local(id):
      setState(for: provider.image(named: id))
    }
  }
  
  private func setState(for image: UIImage?) {
    if let image = image {
      state = .image(image)
    } else {
      state = .none
    }
  }
}

// MARK: - Extensions

private extension Image {
  @ViewBuilder
  func scale(_ scale: ImageScale) -> some View {
    switch scale {
    case .fillHeight:
      resizable()
        .aspectRatio(contentMode: .fill)
    case .fillWidth:
      resizable()
        .aspectRatio(contentMode: .fit)
    case .fillBounds:
      resizable()
    case .center:
      self
    }
  }
}
