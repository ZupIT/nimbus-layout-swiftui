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
            "_:component":"layout:column",
            "properties":{
              "maxWidth":250,
              "backgroundColor":"#CCCCCC"
            },
            "children":[
              {
                "_:component":"layout:column",
                "properties":{
                  "width":50,
                  "height":50,
                  "backgroundColor":"#FF0000"
                }
              },
              {
                "_:component":"layout:text",
                "properties":{
                  "iosAdaptiveSize": true,
                  "text":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ut interdum purus, vitae lobortis magna. Fusce molestie sapien et erat dapibus lacinia. Etiam egestas non urna a tempor. Fusce vehicula, tellus id sodales tempor, orci tellus lobortis est, vitae commodo ligula dolor vel mi. Aliquam condimentum nulla erat, sed tincidunt arcu hendrerit ut. Suspendisse potenti. Maecenas efficitur ligula neque, pretium porttitor massa aliquam nec. Nulla iaculis tristique commodo. Vivamus ut augue ac tellus congue fringilla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras pretium vitae arcu dictum malesuada. Cras sodales leo auctor, placerat elit in, aliquam neque. Duis vitae neque nec est dignissim consectetur ac nec ex. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus volutpat massa non nulla ultrices viverra. Cras sagittis quis lacus eu posuere."
                }
              }
            ]
          }
      """)
    }
    .layoutComponents()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
