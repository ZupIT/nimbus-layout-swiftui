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

struct SafeArea {
  var top: Bool = true
  var bottom: Bool = true
  var trailing: Bool = true
  var leading: Bool = true
  var vertical: Bool = true
  var horizontal: Bool = true
  var all: Bool = true
  
  var edges: Edge.Set {
    var edges: Edge.Set = []
    if all {
      edges.insert(.all)
    }
    if vertical {
      edges.insert(.vertical)
    }
    if horizontal {
      edges.insert(.horizontal)
    }
    if top {
      edges.insert(.top)
    }
    if bottom {
      edges.insert(.bottom)
    }
    if leading {
      edges.insert(.leading)
    }
    if trailing {
      edges.insert(.trailing)
    }
    return edges
  }
}

extension SafeArea: Deserializable {
  init(from map: [String : Any]) throws {
    let top: Bool? = getMapProperty(map: map, name: "top")
    self.top = top ?? true
    
    let bottom: Bool? = getMapProperty(map: map, name: "bottom")
    self.bottom = bottom ?? true
    
    let trailing: Bool? = getMapProperty(map: map, name: "trailing")
    self.trailing = trailing ?? true
    
    let leading: Bool? = getMapProperty(map: map, name: "leading")
    self.leading = leading ?? true
    
    let vertical: Bool? = getMapProperty(map: map, name: "vertical")
    self.vertical = vertical ?? true
    
    let horizontal: Bool? = getMapProperty(map: map, name: "horizontal")
    self.horizontal = horizontal ?? true
    
    let all: Bool? = getMapProperty(map: map, name: "all")
    self.all = all ?? true
  }
}

struct SafeAreaModifier: ViewModifier {
  var safeArea: SafeArea
    
  func body(content: Content) -> some View {
    content
      .edgesIgnoringSafeArea(safeArea.edges)
  }
}
