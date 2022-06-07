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

//interface Border {
//    borderWidth?: double, // default: 0
//    borderDashLength?: double, // default: 1
//    borderDashSpacing?: double, // default: 0
//    cornerRadius?: double, // default: 0
//
//    // Os próximos quatro itens são extras
//    /*topLeftRadius?: double,
//    topRightRadius?: double,
//    bottomLeftRadius?: double,
//    bottomRightRadius?: double*/
//}

struct Border {
  var borderColor: Color = .clear
  
  var borderWidth: Double? // default: 0
  var borderDashLength: Double? // default: 1
  var borderDashSpacing: Double? // default: 0
  var cornerRadius: Double? // default: 0
}

extension Border: Deserializable {
  init(from map: [String : Any]) throws {
    let color: String? = getMapProperty(map: map, name: "borderColor")
    self.borderColor = color.color ?? .clear
    
    self.borderWidth = getMapProperty(map: map, name: "borderWidth")
    self.borderDashLength = getMapProperty(map: map, name: "borderDashLength")
    self.borderDashSpacing = getMapProperty(map: map, name: "borderDashSpacing")
    self.cornerRadius = getMapProperty(map: map, name: "cornerRadius")
  }
}

struct BorderModifier: ViewModifier {
  var border: Border
    
  func body(content: Content) -> some View {
    content
    .overlay(
      RoundedRectangle(cornerRadius: border.cornerRadius ?? 0)
        .stroke(border.borderColor, style: StrokeStyle(
          lineWidth: border.borderWidth ?? 0,
          dash: [
            border.borderDashLength ?? 10,
            border.borderDashSpacing ?? 0
          ]
        )
      )
    )
  }
}
