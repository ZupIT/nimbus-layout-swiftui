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

struct Border {
  var borderColor: Color = .black
  var borderWidth: Double = 0
  var borderDashLength: Double = 1
  var borderDashSpacing: Double = 0
  var cornerRadius: Double = 0
}

extension Border: Deserializable {
  init(from map: [String : Any]?) throws {
    self.borderColor = try getMapColorDefault(map: map, name: "borderColor", default: .black)
    self.borderWidth = try getMapPropertyDefault(map: map, name: "borderWidth", default: 0)
    self.borderDashLength = try getMapPropertyDefault(map: map, name: "borderDashLength", default: 1)
    self.borderDashSpacing = try getMapPropertyDefault(map: map, name: "borderDashSpacing", default: 0)
    self.cornerRadius = try getMapPropertyDefault(map: map, name: "cornerRadius", default: 0)
  }
}

struct BorderModifier: ViewModifier {
  var border: Border
    
  func body(content: Content) -> some View {
    content
    .overlay(
      RoundedRectangle(cornerRadius: border.cornerRadius)
        .stroke(
          border.borderColor,
          style: StrokeStyle(
            lineWidth: border.borderWidth * 2,
            dash: [
              border.borderDashLength,
              border.borderDashSpacing
            ]
          )
        )
    )
    .clipShape(RoundedRectangle(cornerRadius: border.cornerRadius))
  }
}
