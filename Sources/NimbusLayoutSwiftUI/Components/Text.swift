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
import NimbusSwiftUI

struct NimbusText: View {
  var text: String
  var size: Double = 12
  
  var weight: Weight = .normal
  enum Weight: String {
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
  
  var color: Color = .black
  
  var body: some View {
    Text(text)
      .font(.system(size: size, weight: weight.swiftUI))
      .foregroundColor(color)
  }
}

extension NimbusText: Deserializable {
  init(from map: [String : Any]) throws {
    self.text = getMapProperty(map: map, name: "text")
    
    let weight: String? = getMapProperty(map: map, name: "weight")
    self.weight = Weight(rawValue: weight ?? "normal") ?? .normal
    
    let color: String? = getMapProperty(map: map, name: "color")
    self.color = color.color ?? .black
    
    let size: Double? = getMapProperty(map: map, name: "size")
    self.size = size ?? 12
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
