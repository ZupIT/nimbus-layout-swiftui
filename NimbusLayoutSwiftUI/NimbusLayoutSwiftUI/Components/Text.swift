/*
 * Copyright 2023 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
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
import NimbusSwiftUI

struct NimbusText: View, Decodable {
  var text: String?
  
  @Default<DoubleTwelve>
  var size: Double
  
  @Default<WeightNormal>
  var weight: Weight
  
  enum Weight: String, Decodable {
    case thin
    case extraLight
    case light
    case normal
    case medium
    case semiBold
    case bold
    case extraBold
    case black
  }
  
  enum Alignment: String, Decodable {
    case start
    case center
    case end
    
    func textAlignment() -> TextAlignment {
      switch self {
      case .start: return .leading
      case .center: return .center
      case .end: return .trailing
      }
    }
  }
  
  @Default<ColorBlack>
  var color: Color = .black
  
  @Default<False>
  var iosAdaptiveSize: Bool
  
  @Default<AlignmentStart>
  var alignment: Alignment
  
  @ViewBuilder
  func applyAdaptiveSize(content: Text) -> some View {
    if iosAdaptiveSize {
      content.adaptiveSize()
    } else {
      content
    }
  }
  
  var body: some View {
    applyAdaptiveSize(content: Text(text ?? ""))
      .font(.system(size: size, weight: weight.swiftUI))
      .foregroundColor(color)
      .multilineTextAlignment(alignment.textAlignment())
  }
}

extension NimbusText.Weight {
  var swiftUI: Font.Weight {
    switch self {
    case .thin: return .thin
    case .extraLight: return .ultraLight
    case .light: return .light
    case .normal: return .regular
    case .medium: return .medium
    case .semiBold: return .semibold
    case .bold: return .bold
    case .extraBold: return .heavy
    case .black: return .black
    }
  }
}

struct DoubleTwelve: DefaultProtocol {
  static var defaultValue: Double = 12
}

struct WeightNormal: DefaultProtocol {
  static var defaultValue: NimbusText.Weight = .normal
}

struct AlignmentStart: DefaultProtocol {
  static var defaultValue: NimbusText.Alignment = .start
}
