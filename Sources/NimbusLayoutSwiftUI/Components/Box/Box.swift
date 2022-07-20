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

struct Box {
  var backgroundColor: Color = .clear
  var shadow: [Shadow]?
  
  var margin: Margin
  var padding: Padding
  var size: Size
  var border: Border
}

extension Box: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.backgroundColor = try getMapColorDefault(map: map, name: "backgroundColor", default: .clear)
    
    let shadowModel: [[String: Any]]? = try getMapProperty(map: map, name: "shadow")
    self.shadow = shadowModel?.compactMap { try? Shadow(from: $0) }
    
    self.margin = try Margin(from: map)
    self.padding = try Padding(from: map)
    self.size = try Size(from: map)
    self.border = try Border(from: map)
  }
}

struct BoxModifier: ViewModifier {
  var box: Box
  
  // Container properties
  @Environment(\.size) var size
  @Environment(\.alignment) var alignment
  
  func body(content: Content) -> some View {
    content
      .modifier(InsetsModifier(insets: box.padding))
      .frame(width: size.width, height: size.height, alignment: alignment)
      .modifier(SizeModifier(size: box.size))
      .modifier(BorderModifier(border: box.border))
      .background(box.backgroundColor)
      .modifier(ShadowModifier(shadows: box.shadow ?? []))
      .modifier(InsetsModifier(insets: box.margin))
  }
}

struct SizeKey: EnvironmentKey {
  static var defaultValue: (width: CGFloat?, height: CGFloat?) = (nil, nil)
}

extension EnvironmentValues {
  var size: (width: CGFloat?, height: CGFloat?) {
    get { self[SizeKey.self] }
    set { self[SizeKey.self] = newValue }
  }
}

struct AlignmentKey: EnvironmentKey {
  static var defaultValue: Alignment = .center
}

extension EnvironmentValues {
  var alignment: Alignment {
    get { self[AlignmentKey.self] }
    set { self[AlignmentKey.self] = newValue }
  }
}
