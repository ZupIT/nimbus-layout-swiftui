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
    return nil
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
  
  private func isEmpty(_ value: Double?) -> Bool {
    return value == nil || value == 0
  }
  
  func isFixedEmpty() -> Bool {
    return width == .fitContent && height == .fitContent
  }
  
  func isMinMaxEmpty() -> Bool {
    return isEmpty(minWidth) && maxWidth == nil && isEmpty(minHeight) && maxHeight == nil && width != .expand && height != .expand
  }
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
  private let fixedEmpty: Bool
  private let minMaxEmpty: Bool
  
  init (size: Size, alignment: Alignment?) {
    self.alignment = alignment ?? .topLeading
    clipped = size.clipped
    fixedEmpty = size.isFixedEmpty()
    minMaxEmpty = size.isMinMaxEmpty()
    switch(size.width) {
    case .expand:
      maxWidth = size.maxWidth ?? .infinity
    case .fitContent:
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
    case .fitContent:
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
      .applyIf(!minMaxEmpty) {
        $0.frame(
          minWidth: minWidth.cgFloat,
          maxWidth: maxWidth.cgFloat,
          minHeight: minHeight.cgFloat,
          maxHeight: maxHeight.cgFloat,
          alignment: alignment
        )
      }
      .applyIf(!fixedEmpty) {
        $0.frame(
          width: width.cgFloat,
          height: height.cgFloat,
          alignment: alignment
        )
      }
      .applyIf(fixedWidth || fixedHeight) {
        $0.fixedSize(horizontal: fixedWidth, vertical: fixedHeight)
      }
      .applyIf(clipped) { $0.clipped() }
  }
}
