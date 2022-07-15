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

struct Scroll: View {
  
  var children: [AnyComponent]
  
  var direction: Direction = .vertical
  enum Direction: String {
    case vertical
    case horizontal
    case both
  }
  
  var scrollIndicator = true
  
  var body: some View {
    ScrollView(direction.axis, showsIndicators: scrollIndicator) {
      ForEach(children.indices, id: \.self) { index in
        children[index]
      }
    }
  }
}

extension Scroll.Direction {
  var axis: Axis.Set {
    switch self {
    case .both:
      return [.vertical, .horizontal]
    case .vertical:
      return .vertical
    case .horizontal:
      return .horizontal
    }
  }
}

let scrollComponent: Component = { element, children in
  let direction: Scroll.Direction = try getMapEnumDefault(map: element.properties, name: "direction", default: .vertical)
  let scrollIndicator: Bool = try getMapPropertyDefault(map: element.properties, name: "scrollIndicator", default: true)
  
  return AnyComponent(Scroll(
    children: children,
    direction: direction,
    scrollIndicator: scrollIndicator)
  )
}
