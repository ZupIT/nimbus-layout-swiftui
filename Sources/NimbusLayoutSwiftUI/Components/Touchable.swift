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

typealias Actions = @convention(block) (Any?) -> Void

struct Touchable: View, HasAccessibility {
  var onPress: Actions
  var children: [AnyComponent]
  
  var accessibility: Accessibility
  
  var body: some View {
    ForEach(children.indices, id: \.self) { index in
      children[index]
    }
    .modifier(AccessibilityModifier(accessibility: accessibility))
    .onTapGesture {
      onPress(nil)
    }
  }
}

extension Touchable {
  init(from map: [String : Any], children: [AnyComponent]) throws {
    
    self.onPress = unsafeBitCast(
      map["onPress"] as? AnyObject,
      to: Actions.self
    )
    
    self.children = children
    self.accessibility = try Accessibility(from: map)
  }
}
