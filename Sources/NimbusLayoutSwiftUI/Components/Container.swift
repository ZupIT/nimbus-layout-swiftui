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

enum Direction {
  case row
  case column
}

protocol HasContainer {
  var container: Container { get }
}

struct AlignedOnMainAxis: _VariadicView_UnaryViewRoot {
  var direction: Direction
  var container: Container
  var isLazy: Bool = false
  
  private func shouldIgnoreAlignment(size: AdaptiveSize?, min: Double?, max: Double?) -> Bool {
    return size == .fitContent && min == nil && max == nil
  }
  
  private func shouldIgnoreAlignment() -> Bool {
    let size = container.box.size
    return (direction == .column && shouldIgnoreAlignment(size: size.height, min: size.minHeight, max: size.maxHeight))
    || (direction == .row && shouldIgnoreAlignment(size: size.width, min: size.minWidth, max: size.maxWidth))
  }
  
  @ViewBuilder
  func buildWithAlignment(children: _VariadicView.Children) -> some View {
    switch(container.mainAxisAlignment) {
      case .start:
        ForEach(children) { child in
          child
        }
        Spacer(minLength: 0)
      case .end:
        Spacer(minLength: 0)
        ForEach(children) { child in
          child
        }
      case .center:
        Spacer(minLength: 0)
        ForEach(children) { child in
          child
        }
        Spacer(minLength: 0)
      case .spaceAround:
        ForEach(children) { child in
          Spacer(minLength: 0)
          child
          Spacer(minLength: 0)
        }
      case .spaceEvenly:
        Spacer(minLength: 0)
        ForEach(children) { child in
          child
          Spacer(minLength: 0)
        }
      case .spaceBetween:
        let last = children.last?.id
        ForEach(children) { child in
          child
          if child.id != last {
            Spacer(minLength: 0)
          }
        }
    }
  }
  
  @ViewBuilder
  func content(children: _VariadicView.Children) -> some View {
    if (shouldIgnoreAlignment()) {
      ForEach(children) { child in
        child
      }
    } else {
      buildWithAlignment(children: children)
    }
  }
  
  @ViewBuilder
  func body(children: _VariadicView.Children) -> some View {
    switch direction {
    case .row:
      let alignment = container.crossAxisAlignment.verticalAlignment
      if #available(iOS 14.0, *), isLazy {
        LazyHStack(alignment: alignment, spacing: 0) {
          content(children: children)
        }
      } else {
        HStack(alignment: alignment, spacing: 0) {
          content(children: children)
        }
      }
    case .column:
      let alignment = container.crossAxisAlignment.horizontalAlignment
      if #available(iOS 14.0, *), isLazy {
        LazyVStack(alignment: alignment, spacing: 0) {
          content(children: children)
        }
      } else {
        VStack(alignment: alignment, spacing: 0) {
          content(children: children)
        }
      }
    }
  }
}

struct Container {
  var crossAxisAlignment: CrossAxisAlignment
  var mainAxisAlignment: MainAxisAlignment
  var box: Box
}

extension Container: Deserializable {
  init(from map: [String : Any]?) throws {
    self.crossAxisAlignment = try getMapEnumDefault(map: map, name: "crossAxisAlignment", default: .start)
    self.mainAxisAlignment = try getMapEnumDefault(map: map, name: "mainAxisAlignment", default: .start)
    self.box = try Box(from: map)
  }
}

public struct ContainerView<Content>: View, HasContainer where Content: View {
  var direction: Direction
  var container: Container
  var children: () -> Content
  var isLazy: Bool = false
  
  init(direction: Direction, model: Container, @ViewBuilder children: @escaping () -> Content, isLazy: Bool = false) {
    self.direction = direction
    self.container = model
    self.children = children
    self.isLazy = isLazy
  }
    
  public var body: some View {
    _VariadicView.Tree(AlignedOnMainAxis(direction: direction, container: container, isLazy: isLazy), content: children)
      .modifier(BoxModifier(box: container.box, alignment: container.crossAxisAlignment.alignment))
  }
}

// MARK: - Extensions

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
  
  var alignment: Alignment {
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
