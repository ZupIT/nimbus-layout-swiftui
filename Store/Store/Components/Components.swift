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

let components: [String: Component] = [
  "store:spinner": { element, _ in
    AnyComponent(ProgressView(), element.id)
  },
  "store:button": { element, _ in
    AnyComponent(try CustomButton(from: element.properties), element.id)
  },
  "store:textInput": { element, _ in
    AnyComponent(try TextInput(from: element.properties), element.id)
  }
]

// MARK: - store:button
struct CustomButton: View {
  var text: String
  var onPress: () -> Void
  
  var body: some View {
    Button(text) {
      onPress()
    }
  }
}

extension CustomButton: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.text = try getMapProperty(map: map, name: "text")
    let function = getMapFunction(map: map, name: "onPress")
    self.onPress = {
      Task {
        function(nil)
      }
    }
  }
}

// MARK: - store:textInput
struct TextInput: View {
  var placeholder: String
  @State var value: String
  var onChange: ((String) -> Void)? = nil
  
  var body: some View {
    TextField(placeholder, text: $value)
      .onChange(of: value) {
        onChange?($0)
      }
      .padding(.horizontal, 8)
      .padding(.vertical, 12)
      .font(Font.system(size: 14, weight: .light))
      .background(Color.white)
      .cornerRadius(6)
      .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 227/255, green: 227/255, blue: 227/255), lineWidth: 1))
      
  }
}

extension TextInput: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.placeholder = try getMapProperty(map: map, name: "placeholder")
    self.value = try getMapProperty(map: map, name: "value")
    
    self.onChange = nil
    if map?["onChange"] != nil {
      let function = getMapFunction(map: map, name: "onChange")
      self.onChange = {
        string in function(string)
      }
    }
  }
}
