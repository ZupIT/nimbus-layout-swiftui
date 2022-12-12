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

struct Stack<Content: View>: View, Decodable {
  
  @Root var box: Box
  @Children var children: () -> Content
  
  var body: some View {
    ZStack(content: children).modifier(BoxModifier(box: box))
  }
  
}

// MARK: - Positioned

struct Positioned<Content>: View, Decodable where Content: View {
  
  @Default<TopStart>
  var alignment: PositionedAlignment
  
  @Default<DoubleZero>
  var x: Double
  
  @Default<DoubleZero>
  var y: Double
  
  @Root
  var box: Box
  
  @Children
  var children: () -> Content
  
  var body: some View {
    ZStack(alignment: alignment.zstack) {
      Color.clear
      VStack(alignment: .leading, spacing: 0, content: children)
        .modifier(BoxModifier(box: box))
        .offset(x: x, y: y)
    }
  }
  
}

enum PositionedAlignment: String, Decodable {
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

struct TopStart: DefaultProtocol {
  static var defaultValue = PositionedAlignment.topStart
}

extension PositionedAlignment {
  var zstack: SwiftUI.Alignment {
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
