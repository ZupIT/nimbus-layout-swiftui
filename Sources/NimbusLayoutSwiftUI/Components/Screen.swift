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

struct Screen<Content>: View where Content: View {
  var ignoreSafeArea: SafeArea
  var title: String?
  var showBackButton: Bool = true
  var children: () -> Content
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0, content: children)
    .modifier(SafeAreaModifier(safeArea: ignoreSafeArea))
    .navigationBarTitle(title ?? "")
    .navigationBarBackButtonHidden(!showBackButton)
  }
}

extension Screen: Deserializable {
  init(from map: [String : Any]?, @ViewBuilder children: @escaping () -> Content) throws {
    self.ignoreSafeArea = try SafeArea(from: map)
    self.title = try getMapProperty(map: map, name: "title")
    self.showBackButton = try getMapPropertyDefault(map: map, name: "showBackButton", default: true)
    self.children = children
  }
}
