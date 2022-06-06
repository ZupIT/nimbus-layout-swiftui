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
    
    NimbusNavigator(json: """
    {
      "_:component": "layout:row",
      "children": [
        {
          "_:component": "layout:row",
          "properties": {
            "backgroundColor": "#FF0000",
            "height" : 100,
            "width" : 50
          }
        },
        {
          "_:component": "layout:row",
          "properties": {
            "backgroundColor": "#00FF00",
            "height" : 80,
            "width": 50
          }
        },
        {
          "_:component": "layout:row",
          "properties": {
            "backgroundColor": "#0000FF",
            "minHeight": 50,
            
            "width": 50
          }
        }
      ],
      "properties": {
        "backgroundColor": "#FFCCCCCC",
        "mainAxisAlignment": "start",
        "crossAxisAlignment": "start"
      }
    }
    """)
    .environmentObject(NimbusConfig())
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
