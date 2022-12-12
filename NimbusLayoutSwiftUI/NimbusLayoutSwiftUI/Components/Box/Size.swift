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

enum AdaptiveSize: Equatable, Decodable {
  case expand
  case fitContent
  case fixed(Double)
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let value = try? container.decode(Int.self) {
      self = .fixed(Double(value))
    } else if let value = try? container.decode(Double.self) {
      self = .fixed(value)
    } else {
      let string = try container.decode(String.self)
      switch string {
      case "expand": self = .expand
      case "fitContent": self = .fitContent
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid adaptiveSize content.")
        )
      }
    }
  }
}

struct Size: Decodable {
  @Default<FitContent>
  var width: AdaptiveSize
  
  @Default<FitContent>
  var height: AdaptiveSize
  
  var minWidth: Double?
  var minHeight: Double?
  var maxWidth: Double?
  var maxHeight: Double?
  
  @Default<False>
  var clipped: Bool
  
  private func isEmpty(_ value: Double?) -> Bool {
    return value == nil || value == 0
  }
  
  func isFixedEmpty() -> Bool {
    return width == .fitContent && height == .fitContent
  }
  
  func isMinMaxEmpty() -> Bool {
    return isEmpty(minWidth) && maxWidth == nil && isEmpty(minHeight) && maxHeight == nil && width != .expand && height != .expand
  }
  
  struct FitContent: DefaultProtocol {
    static var defaultValue = AdaptiveSize.fitContent
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
    switch size.width {
    case .expand:
      maxWidth = size.maxWidth ?? .infinity
    case .fitContent:
      if size.minWidth != nil || size.maxWidth != nil {
        minWidth = size.minWidth
        maxWidth = size.maxWidth
        fixedWidth = true
      }
    case .fixed(let value):
      self.width = value
    }
    
    switch size.height {
    case .expand:
      maxHeight = size.maxHeight ?? .infinity
    case .fitContent:
      if size.minHeight != nil || size.maxHeight != nil {
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
