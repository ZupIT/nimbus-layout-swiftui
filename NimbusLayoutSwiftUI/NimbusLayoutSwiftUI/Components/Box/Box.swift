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

struct Box: Decodable {
  var backgroundColor: Color?
  var shadow: [Shadow]?
  
  @Root var margin: Margin
  @Root var padding: Padding
  @Root var size: Size
  @Root var border: Border
}

struct BoxModifier: ViewModifier {
  var box: Box
  var alignment: Alignment?
  
  func body(content: Content) -> some View {
    content
      .modifier(InsetsModifier(insets: box.padding))
      .modifier(SizeModifier(size: box.size, alignment: alignment))
      .applyIf(box.backgroundColor != nil) {
        $0.background(box.backgroundColor)
      }
      .modifier(BorderModifier(border: box.border))
      .modifier(ShadowModifier(shadows: box.shadow ?? []))
      .modifier(InsetsModifier(insets: box.margin))
  }
}
