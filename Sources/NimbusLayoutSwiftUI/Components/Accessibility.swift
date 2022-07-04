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

struct Accessibility {
  var label: String?
  var isHeader: Bool?
}

extension Accessibility: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.label = try getMapProperty(map: map, name: "label")
    self.isHeader = try getMapProperty(map: map, name: "isHeader")
  }
}

protocol HasAccessibility {
  var accessibility: Accessibility { get }
}

struct AccessibilityModifier: ViewModifier {
  var accessibility: Accessibility
    
  func body(content: Content) -> some View {
    content
      .label(accessibility.label)
      .isHeader(accessibility.isHeader)
  }
}

private extension View {
  @ViewBuilder
  func label(_ label: String?) -> some View {
    if let label = label {
      self.accessibility(label: Text(label))
    } else {
      self
    }
  }
  
  @ViewBuilder
  func isHeader(_ isHeader: Bool?) -> some View {
    if let isHeader = isHeader, isHeader {
      self.accessibility(addTraits: .isHeader)
    } else {
      self.accessibility(removeTraits: .isHeader)
    }
  }
}
