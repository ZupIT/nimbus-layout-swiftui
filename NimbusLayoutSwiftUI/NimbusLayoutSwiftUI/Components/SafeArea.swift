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

enum SafeAreaEdge: String, Decodable {
  case top
  case bottom
  case trailing
  case leading
  case vertical
  case horizontal
  case all
}

extension Array where Element == SafeAreaEdge {
  var edges: Edge.Set {
    var edges: Edge.Set = []
    for edge in self {
      switch edge {
      case .top:
        edges.insert(.top)
      case .bottom:
        edges.insert(.bottom)
      case .trailing:
        edges.insert(.trailing)
      case .leading:
        edges.insert(.leading)
      case .vertical:
        edges.insert(.vertical)
      case .horizontal:
        edges.insert(.horizontal)
      case .all:
        edges.insert(.all)
      }
    }
    return edges
  }
}

struct SafeAreaModifier: ViewModifier {
  var edgesIgnored: [SafeAreaEdge]
    
  func body(content: Content) -> some View {
    content
      .edgesIgnoringSafeArea(edgesIgnored.edges)
  }
}
