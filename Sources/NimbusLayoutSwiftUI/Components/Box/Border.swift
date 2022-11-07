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

struct Border: Decodable {
  @Default<ColorBlack>
  var borderColor: Color
  
  @Default<DoubleZero>
  var borderWidth: Double
  
  @Default<DoubleOne>
  var borderDashLength: Double
  
  @Default<DoubleZero>
  var borderDashSpacing: Double
  
  @Default<DoubleZero>
  var cornerRadius: Double
}

struct BorderModifier: ViewModifier {
  var border: Border
    
  func body(content: Content) -> some View {
    content.applyIf(border.borderWidth > 0) {
      $0.overlay(
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
}
