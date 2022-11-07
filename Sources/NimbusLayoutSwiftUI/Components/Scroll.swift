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

struct Scroll<Content: View>: View, Decodable {
  
  @Children var children: () -> Content
  var direction: Direction // = .vertical
  enum Direction: String, Decodable {
    case vertical
    case horizontal
    case both
  }
    
  @Default<True> var scrollIndicator: Bool
  
  var body: some View {
    ScrollView(direction.axis, showsIndicators: scrollIndicator) {
      VStack(alignment: .leading, spacing: 0, content: children)
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
