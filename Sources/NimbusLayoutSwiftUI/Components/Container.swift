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

enum CrossAxisAlignment: String {
  case stretch
  case start
  case end
  case center
}

enum MainAxisAlignment: String {
  case start
  case end
  case center
  case spaceBetween
  case spaceAround
  case spaceEvenly
}

protocol HasContainer {
  var container: Container { get }
}

struct Container {
  var flex: Int?
  var crossAxisAlignment: CrossAxisAlignment
  var mainAxisAlignment: MainAxisAlignment
  
  var box: Box
}

extension Container: Deserializable {
  init(from map: [String : Any]) throws {
    
    self.flex = getMapProperty(map: map, name: "flex")
    
    let crossAxis: String? = getMapProperty(map: map, name: "crossAxisAlignment")
    self.crossAxisAlignment = CrossAxisAlignment(rawValue: crossAxis ?? "start") ?? .start
    
    let mainAxis: String? = getMapProperty(map: map, name: "mainAxisAlignment")
    self.mainAxisAlignment = MainAxisAlignment(rawValue: mainAxis ?? "start") ?? .start
    
    self.box = try Box(from: map)
  }
}

public struct ContainerView: View, HasContainer {
  
  @State var availableSize: CGSize = .zero
  
  var direction: Direction
  enum Direction {
    case row
    case column
  }
  
  var container: Container
  var children: [AnyComponent]
  
  var totalFlex: Int
  
  init(direction: Direction, model: Container, children: [AnyComponent]) {
    self.direction = direction
    self.container = model
    self.children = children
    
    totalFlex = children.compactMap { $0.component as? HasContainer }
      .compactMap(\.container.flex)
      .reduce(0, +)
  }
  
  public var body: some View {
    ZStack {
      Color.clear
        .frame(
          width: direction == .column ? 1 : nil,
          height: direction == .row ? 1 : nil
        )
        .readSize { size in
          availableSize = size
        }
      stack {
        if totalFlex == 0 {
          mainAxis()
        } else {
          ForEach(children.indices, id: \.self) { index in
            component(children[index]) { size in
              switch direction {
              case .row:
                availableSize.width -= size.width
              case .column:
                availableSize.height -= size.height
              }
            }
          }
        }
      }
    }
    .modifier(BoxModifier(box: container.box))
    .fixedSize(
      horizontal: direction == .column,
      vertical: direction == .row
    )
  }
  
  @ViewBuilder
  func stack<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
    switch direction {
    case .row:
      HStack(alignment: container.crossAxisAlignment.verticalAlignment, spacing: 0) {
        content()
      }
    case .column:
      VStack(alignment: container.crossAxisAlignment.horizontalAlignment, spacing: 0) {
        content()
      }
    }
  }
  
  @ViewBuilder
  func component(_ item: AnyComponent, onChange: @escaping (CGSize) -> Void) -> some View {
    if let flex = item.flex {
      item
        .frame(
          width: direction == .row ? availableSize.width * (CGFloat(flex) / CGFloat(totalFlex)) : nil,
          height: direction == .column ? availableSize.height * (CGFloat(flex) / CGFloat(totalFlex)) : nil
        )
    } else {
      item
        .readSize(onChange: onChange)
    }
  }

  @ViewBuilder
  func mainAxis() -> some View {
    switch container.mainAxisAlignment {
    case .start:
      ForEach(children.indices, id: \.self) { index in
        children[index]
      }
      Spacer(minLength: 0)
    case .end:
      Spacer(minLength: 0)
      ForEach(children.indices, id: \.self) { index in
        children[index]
      }
    case .center:
      Spacer(minLength: 0)
      ForEach(children.indices, id: \.self) { index in
        children[index]
      }
      Spacer(minLength: 0)
    case .spaceAround:
      ForEach(children.indices, id: \.self) { index in
        Spacer(minLength: 0)
        children[index]
        Spacer(minLength: 0)
      }
    case .spaceEvenly:
      Spacer(minLength: 0)
      ForEach(children.indices, id: \.self) { index in
        children[index]
        Spacer(minLength: 0)
      }
    case .spaceBetween:
      ForEach(children.indices, id: \.self) { index in
        children[index]
        if index != children.count - 1 {
          Spacer(minLength: 0)
        }
      }
    }
  }
}

// MARK: - Extensions

extension AnyComponent {
  var flex: Int? {
    (component as? HasContainer)?.container.flex
  }
}

extension CrossAxisAlignment {
  var verticalAlignment: VerticalAlignment {
    switch self {
    case .stretch:
      return .center
    case .start:
      return .top
    case .end:
      return .bottom
    case .center:
      return .center
    }
  }
  
  var horizontalAlignment: HorizontalAlignment {
    switch self {
    case .stretch:
      return .center
    case .start:
      return .leading
    case .end:
      return .trailing
    case .center:
      return .center
    }
  }
}
