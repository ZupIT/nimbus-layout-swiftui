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
  "store:spinner": { _, _ in
    AnyComponent(ProgressView())
  },
  "store:button": { element, _ in
    AnyComponent(try CustomButton(from: element.properties))
  },
  "store:textInput": { element, _ in
    AnyComponent(try TextInput(from: element.properties))
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
    self.onPress = { function(nil) }
  }
}

// MARK: - store:textInput
struct TextInput: View {
  var label: String
  @State var value: String
  var onChange: ((String) -> Void)? = nil
  
  var body: some View {
    TextField(label, text: $value)
      .onChange(of: value) {
        onChange?($0)
      }
  }
}

extension TextInput: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.label = try getMapProperty(map: map, name: "label")
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
