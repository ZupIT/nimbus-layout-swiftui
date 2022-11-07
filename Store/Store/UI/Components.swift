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

// MARK: - store:button
struct CustomButton: View, Decodable {
  var text: String
  
  @Event
  var onPress: () -> Void
  
  var body: some View {
    Button(text) {
      onPress()
    }
  }
}

// MARK: - store:textInput
struct TextInput: View, Decodable {
  var placeholder: String
  
  @State var value: String
  
  @Event var onChange: (String) -> Void
  
  var body: some View {
    TextField(placeholder, text: $value)
      .onChange(of: value) {
        onChange($0)
      }
      .padding(.horizontal, 8)
      .padding(.vertical, 12)
      .font(Font.system(size: 14, weight: .light))
      .background(Color.white)
      .cornerRadius(6)
      .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 227/255, green: 227/255, blue: 227/255), lineWidth: 1))
      
  }
}
