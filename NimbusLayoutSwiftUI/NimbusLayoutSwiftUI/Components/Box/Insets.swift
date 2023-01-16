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

protocol Insets {
  var all: Double? { get }
  var start: Double? { get }
  var end: Double? { get }
  var top: Double? { get }
  var bottom: Double? { get }
  var horizontal: Double? { get }
  var vertical: Double? { get }
}

extension Insets {
  private func isEmpty(_ value: Double?) -> Bool {
    value == nil || value == 0
  }
  
  func isEmpty() -> Bool {
    isEmpty(all) && isEmpty(start) && isEmpty(end) && isEmpty(top)
      && isEmpty(bottom) && isEmpty(horizontal) && isEmpty(vertical)
  }
}

struct InsetsModifier: ViewModifier {
  var insets: Insets
  
  var edgeInsets: EdgeInsets {
    var edgeInsets = EdgeInsets()
    if let all = insets.all {
      edgeInsets.bottom = all
      edgeInsets.top = all
      edgeInsets.leading = all
      edgeInsets.trailing = all
    }
    if let vertical = insets.vertical {
      edgeInsets.bottom = vertical
      edgeInsets.top = vertical
    }
    if let horizontal = insets.horizontal {
      edgeInsets.leading = horizontal
      edgeInsets.trailing = horizontal
    }
    if let top = insets.top {
      edgeInsets.top = top
    }
    if let bottom = insets.bottom {
      edgeInsets.bottom = bottom
    }
    if let start = insets.start {
      edgeInsets.leading = start
    }
    if let end = insets.end {
      edgeInsets.trailing = end
    }
    return edgeInsets
  }
  
  func body(content: Content) -> some View {
    content.applyIf(!insets.isEmpty()) { $0.padding(edgeInsets) }
  }
}
