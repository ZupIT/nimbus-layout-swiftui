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

struct Size {
  var width: Double?
  var height: Double?
  var minWidth: Double?
  var minHeight: Double?
  var maxWidth: Double?
  var maxHeight: Double?
  
  var clipped: Bool = false
}

extension Size: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.width = try getMapProperty(map: map, name: "width")
    self.height = try getMapProperty(map: map, name: "height")
    self.minWidth = try getMapProperty(map: map, name: "minWidth")
    self.minHeight = try getMapProperty(map: map, name: "minHeight")
    self.maxWidth = try getMapProperty(map: map, name: "maxWidth")
    self.maxHeight = try getMapProperty(map: map, name: "maxHeight")
    
    self.clipped = try getMapPropertyDefault(map: map, name: "clipped", default: false)
  }
}

struct SizeModifier: ViewModifier {
  var size: Size
  
  @Environment(\.alignment) var alignment
  
  func body(content: Content) -> some View {
    content
      .frame(
        minWidth: size.width == nil ? size.minWidth.cgFloat : nil,
        maxWidth: size.width == nil ? size.maxWidth.cgFloat : nil,
        minHeight: size.height == nil ? size.minHeight.cgFloat : nil,
        maxHeight: size.height == nil ? size.maxHeight.cgFloat : nil
      )
      .frame(width: size.width.cgFloat, height: size.height.cgFloat, alignment: alignment)
      .content(clipped: size.clipped)
  }
}

private extension View {
  @ViewBuilder
  func content(clipped: Bool) -> some View {
    if clipped {
      self.clipped()
    } else {
      self
    }
  }
}
