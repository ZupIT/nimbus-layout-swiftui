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
        "_:component": "layout:stack",
        "children": [
          {
            "_:component": "layout:positioned",
            "children": [{
              "_:component": "layout:row",
              "children" : [{
                "_:component": "layout:text",
                "properties": {
                  "text": "r"
                }
              }]
            }],
            "properties": {
              "alignment": "topStart",
              "backgroundColor": "#FF0000",
              "width": 50.0,
              "height": 50.0,
              "x": 10.0,
              "y": 10.0
            }
          },
          {
            "_:component": "layout:positioned",
            "children": [{
              "_:component": "layout:row",
              "children" : [{
                "_:component": "layout:text",
                "properties": {
                  "text": "g"
                }
              }]
            }],
            "properties": {
              "alignment": "topEnd",
              "backgroundColor": "#00FF00",
              "width": 50.0,
              "height": 50.0,
              "x": -10.0,
              "y": 10.0
            }
          },
          {
            "_:component": "layout:positioned",
            "children": [{
              "_:component": "layout:row",
              "children" : [{
                "_:component": "layout:text",
                "properties": {
                  "text": "b"
                }
              }]
            }],
            "properties": {
              "alignment": "bottomStart",
              "backgroundColor": "#0000FF",
              "width": 50.0,
              "height": 50.0,
              "x": 10.0,
              "y": -10.0
            }
          },
          {
            "_:component": "layout:positioned",
            "children": [{
              "_:component": "layout:row",
              "children" : [{
                "_:component": "layout:text",
                "properties": {
                  "text": "m"
                }
              }]
            }],
            "properties": {
              "alignment": "bottomEnd",
              "backgroundColor": "#FFFF00",
              "width": 50.0,
              "height": 50.0,
              "x": -10.0,
              "y": -10.0
            }
          }],
        "properties": {
          "backgroundColor": "#CCCCCCFF",
          "width": 150.0,
          "height": 150.0
        }
      }
      """)
    }
    .ui([layout])
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
