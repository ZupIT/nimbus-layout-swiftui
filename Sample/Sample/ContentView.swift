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
import NimbusLayoutSwiftUI

struct ContentView: View {
  var body: some View {
    Nimbus(baseUrl: "https://localhost:8080") {
      NimbusNavigator(json: """
                      {
                        "_:component": "layout:localimage",
                        "properties": {
                          "id": "nimbus-local",
                          "scale": "fillBounds",
                          "width": 70,
                          "height": 70,
                          "clipped": true
                        }
                      }
      """)
    }
    .layoutComponents()
    /*HStack(alignment: .top, spacing: 0) {
      HStack(alignment: .top, spacing: 0) {
        Text("R")
      }.frame(maxWidth: .infinity, maxHeight: nil).background(Color.red).padding(5)
      HStack(alignment: .top, spacing: 0) {
        Text("G")
      }.frame(maxWidth: .infinity, maxHeight: nil).background(Color.green)
      HStack(alignment: .top, spacing: 0) {
        Text("B")
      }.frame(maxWidth: .infinity, maxHeight: nil).background(Color.blue)
    }.background(Color.gray)*/
    /*VStack(alignment: .leading, spacing: 0) {
      Text("r")
    }.frame(width: 30, height: nil, alignment: .leading).frame(maxWidth: nil, maxHeight: .infinity, alignment: .leading).background(Color.red)*/
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
