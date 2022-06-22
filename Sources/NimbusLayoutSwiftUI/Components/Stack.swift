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

struct Stack: View {
  
  var box: Box
  
  var children: [AnyComponent]
  
  var body: some View {
    ZStack {
      ForEach(children.indices, id: \.self) { index in
        children[index]
      }
    }
    .modifier(BoxModifier(box: box))
  }
  
}

extension Stack {
  init(from map: [String : Any], children: [AnyComponent]) throws {
    self.box = try Box(from: map)
    self.children = children
  }
}

// MARK: - Positioned

struct Positioned: View {
  
  enum Alignment: String {
    case topStart
    case topEnd
    case bottomStart
    case bottomEnd
    case topCenter
    case bottomCenter
    case centerStart
    case centerEnd
    case center
  }
  var alignment: Alignment = .topStart
  
  var x: Double = 0
  var y: Double = 0
  
  var box: Box
  
  var children: [AnyComponent]
  
  var body: some View {
    ZStack(alignment: alignment.zstack) {
      Color.clear
      ForEach(children.indices, id: \.self) { index in
        children[index]
          .modifier(BoxModifier(box: box))
          .offset(x: x, y: y)
      }
    }
  }
  
}

extension Positioned {
  init(from map: [String : Any], children: [AnyComponent]) throws {
    let alignment: String? = getMapProperty(map: map, name: "alignment")
    self.alignment = Positioned.Alignment(rawValue: alignment ?? "topStart") ?? .topStart
    
    let x: Double? = getMapProperty(map: map, name: "x")
    self.x = x ?? 0
    let y: Double? = getMapProperty(map: map, name: "y")
    self.y = y ?? 0
    
    self.box = try Box(from: map)
    self.children = children
  }
}

extension Positioned.Alignment {
  var zstack: Alignment {
    switch self {
    case .topStart: return .topLeading
    case .topEnd: return .topTrailing
    case .bottomStart: return .bottomLeading
    case .bottomEnd: return .bottomTrailing
    case .topCenter: return .top
    case .bottomCenter: return .bottom
    case .centerStart: return .leading
    case .centerEnd: return .trailing
    case .center: return .center
    }
  }
}
