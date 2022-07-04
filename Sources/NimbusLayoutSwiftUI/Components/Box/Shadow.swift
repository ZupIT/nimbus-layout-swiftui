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

struct Shadow {
  var x: Double = 0
  var y: Double = 0
  var blur: Double = 0
  var color: Color = .black
}

extension Shadow: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.x = try getMapPropertyDefault(map: map, name: "x", default: 0)
    self.y = try getMapPropertyDefault(map: map, name: "y", default: 0)
    self.blur = try getMapPropertyDefault(map: map, name: "blur", default: 0)
    self.color = try getMapColorDefault(map: map, name: "color", default: .black)
  }
}

struct ShadowModifier: ViewModifier {
  var shadows: [Shadow]
    
  func body(content: Content) -> some View {
    shadows.reduce(AnyView(content)) { partialResult, shadow in
      AnyView(partialResult
        .shadow(
          color: shadow.color,
          radius: shadow.blur,
          x: shadow.x,
          y: shadow.y
        )
      )
    }
  }
}
