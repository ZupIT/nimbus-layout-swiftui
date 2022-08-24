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


enum AdaptiveSize: Equatable {
  case expand
  case fitContent
  case fixed(Double)
  
  static func fromAny(value: Any?) throws -> AdaptiveSize? {
    if (value == nil) {
      return nil
    }
    if (value is Int) {
      return .fixed(Double(value as! Int))
    }
    if (value is Double) {
      return .fixed(value as! Double)
    }
    if (value is String) {
      if ((value as! String) == "expand") {
        return .expand
      }
      if ((value as! String) == "fitContent") {
        return .fitContent
      }
    }
    throw DeserializationError.invalidType("\(value!) is not a valid size.")
  }
}

struct Size {
  var width: AdaptiveSize = .fitContent
  var height: AdaptiveSize = .fitContent
  var minWidth: Double?
  var minHeight: Double?
  var maxWidth: Double?
  var maxHeight: Double?
  
  var clipped: Bool = false
}

extension Size: Deserializable {
  init(from map: [String : Any]?) throws {
    let width: Any? = try getMapProperty(map: map, name: "width")
    self.width = try AdaptiveSize.fromAny(value: width) ?? .fitContent
    let height: Any? = try getMapProperty(map: map, name: "height")
    self.height = try AdaptiveSize.fromAny(value: height) ?? .fitContent
    self.minWidth = try getMapProperty(map: map, name: "minWidth")
    self.minHeight = try getMapProperty(map: map, name: "minHeight")
    self.maxWidth = try getMapProperty(map: map, name: "maxWidth")
    self.maxHeight = try getMapProperty(map: map, name: "maxHeight")
    
    self.clipped = try getMapPropertyDefault(map: map, name: "clipped", default: false)
  }
}

struct SizeModifier: ViewModifier {
  private let alignment: Alignment
  private var minWidth: Double?
  private var maxWidth: Double?
  private var minHeight: Double?
  private var maxHeight: Double?
  private var width: Double?
  private var height: Double?
  private var fixedWidth: Bool = false
  private var fixedHeight: Bool = false
  private let clipped: Bool
  
  init (size: Size, alignment: Alignment?) {
    self.alignment = alignment ?? .topLeading
    clipped = size.clipped
    switch(size.width) {
    case .expand:
      maxWidth = size.maxWidth ?? .infinity
    case .fitContent, nil:
      if (size.minWidth != nil || size.maxWidth != nil) {
        minWidth = size.minWidth
        maxWidth = size.maxWidth
        fixedWidth = true
      }
    case .fixed(let value):
      self.width = value
    }
    
    switch(size.height) {
    case .expand:
      maxHeight = size.maxHeight ?? .infinity
    case .fitContent, nil:
      if (size.minHeight != nil || size.maxHeight != nil) {
        minHeight = size.minHeight
        maxHeight = size.maxHeight
        fixedHeight = true
      }
    case .fixed(let value):
      self.height = value
    }
  }
  
  init(size: Size) {
    self.init(size: size, alignment: nil)
  }
  
  func body(content: Content) -> some View {
    content
      .frame(
        minWidth: minWidth.cgFloat,
        maxWidth: maxWidth.cgFloat,
        minHeight: minHeight.cgFloat,
        maxHeight: maxHeight.cgFloat,
        alignment: alignment
      )
      .frame(
        width: width.cgFloat,
        height: height.cgFloat,
        alignment: alignment
      )
      .fixedSize(horizontal: fixedWidth, vertical: fixedHeight)
      .content(clipped: clipped)
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
