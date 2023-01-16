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
import NimbusSwiftUI

struct FlowRow<Content: View>: View, Decodable {
  @Children var children: () -> Content
  @Root var box: Box
  
  var body: some View {
    if #available(iOS 14.0, *) {
      return AnyView(
        FlowLayout(axis: .horizontal, alignment: Alignment(horizontal: .leading, vertical: .top), content: children)
          .modifier(BoxModifier(box: box))
      )
    } else {
      print("Nimbus Caught Error: The FlowRow component is only available on iOS 14+")
      return AnyView(
        Row(children: children, container: Container(box: box))
      )
    }
  }
}
