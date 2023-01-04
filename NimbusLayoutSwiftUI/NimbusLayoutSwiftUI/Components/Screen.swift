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

struct Screen<Content: View>: View, Decodable {
  var ignoreSafeArea: [SafeAreaEdge]?
  var title: String?
  var safeAreaTopBackground: Color?
  @Default<True> var showBackButton: Bool
  @Children var children: () -> Content
  
  var body: some View {
    GeometryReader { proxy in
      safeAreaTopBackground
        .frame(
          width: proxy.size.width,
          height: UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height
        )
        .edgesIgnoringSafeArea(.top)
      VStack(alignment: .leading, spacing: 0) {
        children()
          .modifier(SafeAreaModifier(edgesIgnored: ignoreSafeArea ?? []))
      }
      .navigationBarTitle(Text(title ?? ""), displayMode: .inline)
      .navigationBarHidden(title?.isEmpty ?? true)
      .navigationBarBackButtonHidden(!showBackButton)
    }
  }
}
