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

struct Screen: View {
  var ignoreSafeArea: [SafeAreaEdge] = []
  var title: String?
  var showBackButton: Bool = true
  
  var children: [AnyComponent]
  
  var body: some View {
    ForEach(children.indices, id: \.self) { index in
      children[index]
    }
    .modifier(SafeAreaModifier(edgesIgnored: ignoreSafeArea))
    .navigationBarTitle(Text(title ?? ""), displayMode: .inline)
    .navigationBarBackButtonHidden(!showBackButton)
  }
}

extension Screen: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    let ignoreSafeArea: [String]? = try getMapProperty(map: map, name: "ignoreSafeArea")
    self.ignoreSafeArea = ignoreSafeArea?.compactMap { SafeAreaEdge(rawValue: $0) } ?? []
    
    self.title = try getMapProperty(map: map, name: "title")
    self.showBackButton = try getMapPropertyDefault(map: map, name: "showBackButton", default: true)
    self.children = children
  }
}
