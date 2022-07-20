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
  var strech: Bool = false
  var crossAxisAlignment: CrossAxisAlignment
  var mainAxisAlignment: MainAxisAlignment
  
  var box: Box
}

extension Container: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.flex = try getMapProperty(map: map, name: "flex")
    self.strech = try getMapPropertyDefault(map: map, name: "stretch", default: false)
    self.crossAxisAlignment = try getMapEnumDefault(map: map, name: "crossAxisAlignment", default: .start)
    self.mainAxisAlignment = try getMapEnumDefault(map: map, name: "mainAxisAlignment", default: .start)
    
    self.box = try Box(from: map)
  }
}

public struct ContainerView: View, HasContainer {
  
  @Environment(\.size) var size
  
  var alignment: Alignment = .top
  
  // TODO: verify a way of reduce fixed sizes
  @State var available: CGFloat = .zero
  @State var state: ContainerState = .initialSize
  enum ContainerState {
    case initialSize
    case fixedSizes
    case rendering
  }
  
  var direction: Direction
  enum Direction {
    case row
    case column
  }
  
  var container: Container
  var children: [AnyComponent]
  
  var totalFlex: Int
  var fixedComponents: [AnyComponent]
  
  init(
    direction: Direction,
    model: Container,
    children: [AnyComponent]
  ) {
    self.direction = direction
    self.container = model
    self.children = children
    
    totalFlex = children.compactMap(\.flex)
      .reduce(0, +)
    fixedComponents = children.filter { $0.flex == nil }
    alignment = getAlignment()
  }
  
  init(
    direction: Direction,
    flex: Int? = nil,
    crossAxisAlignment: CrossAxisAlignment = .start,
    mainAxisAlignment: MainAxisAlignment = .start,
    children: [AnyComponent] = []
  ) {
    self.init(
      direction: direction,
      model: Container(
        flex: flex,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        box: try! Box(from: nil)
      ),
      children: children
    )
  }
  
  public var body: some View {
    ZStack {
      if state == .initialSize, totalFlex != 0 { // calculate available size
        Color.clear
          .frame(
            width: direction == .column ? 1 : nil,
            height: direction == .row ? 1 : nil
          )
          .readSize { size in
            let availableValue = direction == .row ? size.width : size.height
            if availableValue != .zero {
              available = availableValue
              state = fixedComponents.count > 0 ? .fixedSizes : .rendering
            }
          }
      }
      stack {
        if totalFlex == 0 { // rendering fixed components
          if children.count > 1 {
            mainAxis()
          } else {
            ForEach(children.indices, id: \.self) { index in
              children[index]
            }
          }
        } else {
          if state == .fixedSizes { // calculate all fixedPositions
            ForEach(fixedComponents.indices, id: \.self) { index in
              fixedComponents[index]
                .readSize { size in
                  available -= (direction == .row ? size.width : size.height)
                  if index == fixedComponents.count - 1 { // last fixed element
                    state = .rendering
                  }
                }
            }
          } else if state == .rendering { // rendenring components (flexible and fixed)
            ForEach(children.indices, id: \.self) { index in
              if let flex = children[index].flex {
                children[index]
                  .environment(\.size, (
                    width: direction == .row ? available * (CGFloat(flex) / CGFloat(totalFlex)) : nil,
                    height: direction == .column ? available * (CGFloat(flex) / CGFloat(totalFlex)) : nil
                  ))
              } else {
                children[index]
              }
            }
          }
        }
      }
    }
    .modifier(BoxModifier(box: container.box))
    .environment(\.alignment, alignment)
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
  func mainAxis() -> some View {
    switch container.mainAxisAlignment {
    case .start, .end, .center:
      ForEach(children.indices, id: \.self) { index in
        children[index]
      }
    case .spaceAround:
      ContainerView(
        direction: direction,
        children: children.map {
          AnyComponent(ContainerView(
            direction: direction,
            flex: 1,
            crossAxisAlignment: container.crossAxisAlignment,
            mainAxisAlignment: .center,
            children: [$0]
          ))
        }
      )
    case .spaceEvenly:
      ContainerView(
        direction: direction,
        crossAxisAlignment: container.crossAxisAlignment,
        children: spaceEvenlyChildren()
      )
    case .spaceBetween:
      ContainerView(
        direction: direction,
        crossAxisAlignment: container.crossAxisAlignment,
        children: spaceBetweenChildren()
      )
    }
  }
  
  func spaceBetweenChildren() -> [AnyComponent] {
    var result: [AnyComponent] = []
    for index in children.indices {
      result.append(children[index])
      if index != children.count - 1 {
        result.append(spacer)
      }
    }
    return result
  }
  
  func spaceEvenlyChildren() -> [AnyComponent] {
    var result: [AnyComponent] = []
    result.append(spacer)
    for index in children.indices {
      result.append(children[index])
      result.append(spacer)
    }
    return result
  }
  
  var spacer: AnyComponent {
    AnyComponent(
      ContainerView(
        direction: direction,
        flex: 1
      )
    )
  }
  
  func getAlignment() -> Alignment {
    switch direction {
    case .row:
      return Alignment(
        horizontal: container.mainAxisAlignment.horizontalAlignment,
        vertical: container.crossAxisAlignment.verticalAlignment
      )
    case .column:
      return Alignment(
        horizontal: container.crossAxisAlignment.horizontalAlignment,
        vertical: container.mainAxisAlignment.verticalAlignment
      )
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
    case .start:
      return .leading
    case .end:
      return .trailing
    case .center:
      return .center
    }
  }
}

extension MainAxisAlignment {
  var verticalAlignment: VerticalAlignment {
    switch self {
    case .start:
      return .top
    case .end:
      return .bottom
    case .center:
      return .center
    default:
      return .top
    }
  }
  
  var horizontalAlignment: HorizontalAlignment {
    switch self {
    case .start:
      return .leading
    case .end:
      return .trailing
    case .center:
      return .center
    default:
      return .leading
    }
  }
}
