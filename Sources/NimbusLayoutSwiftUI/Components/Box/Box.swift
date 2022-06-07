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

// MARK: - Models

import SwiftUI
import NimbusSwiftUI

struct Box {
  var backgroundColor: Color = .clear
  var shadow: [Shadow]?
  
  var margin: Margin
  var padding: Padding
  var size: Size
  var border: Border
}

extension Box: Deserializable {
  init(from map: [String : Any]) throws {
    let color: String? = getMapProperty(map: map, name: "backgroundColor")
    self.backgroundColor = color.color ?? .clear
    
    let shadowModel: [[String: Any]]? = getMapProperty(map: map, name: "shadow")
    self.shadow = shadowModel?.map { try! Shadow(from: $0) }
    
    self.margin = try Margin(from: map)
    self.padding = try Padding(from: map)
    self.size = try Size(from: map)
    self.border = try Border(from: map)
  }
}

struct BoxModifier: ViewModifier {
  var box: Box
  
  func body(content: Content) -> some View {
    ZStack(alignment: .topLeading) {
      box.backgroundColor
        .modifier(BorderModifier(border: box.border))
      content
        .modifier(InsetsModifier(insets: box.padding))
    }
    .modifier(SizeModifier(size: box.size))
    .modifier(ShadowModifier(shadows: box.shadow ?? []))
    .modifier(InsetsModifier(insets: box.margin))
  }
}
