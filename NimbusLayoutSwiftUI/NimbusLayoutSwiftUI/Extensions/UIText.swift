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

private struct AdaptiveSizeModifier: ViewModifier {
  @State private var height: CGFloat?
  
  private func updateHeight(height: CGFloat) -> some View {
    DispatchQueue.main.async {
      self.height = height
    }
    return Color.clear
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
        .fixedSize(horizontal: false, vertical: true)
        .background(GeometryReader { geo in
          updateHeight(height: geo.size.height)
        })
        .opacity(0)
      
      content
    }.frame(width: nil, height: height)
  }
}

public extension Text {
  @ViewBuilder
  func adaptiveSize() -> some View {
    self.modifier(AdaptiveSizeModifier())
  }
}
