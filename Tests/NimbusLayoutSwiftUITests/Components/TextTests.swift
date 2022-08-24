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

import XCTest
import SwiftUI
import SnapshotTesting
import NimbusSwiftUI

class TextTests: XCTestCase {
  
  // Integrated
  func testText() throws {
    assertSnapshot(matching: text(), as: .image)
    assertSnapshot(matching: text(size: 16, weight: "thin"), as: .image)
    assertSnapshot(matching: text(size: 10, weight: "bold", color: "#00FF00"), as: .image)
    assertSnapshot(matching: text(size: 8, weight: "extraLight", color: "#FF0000"), as: .image)
  }
  
  func text(size: Double = 12, weight: String = "normal", color: String = "#000000") -> some View {
    let json = """
    {
      "_:component": "layout:text",
      "properties": {
        "text": "Sample",
        "size": \(size),
        "weight": "\(weight)",
        "color": "\(color)"
      }
    }
    """
    return Nimbus(baseUrl: "base") {
      NimbusNavigator(json:
        json
      )
    }
    .layoutComponents()
    .frame(width: 80, height: 80)
  }
  
  func adaptiveText(size: Double = 12, weight: String = "normal", color: String = "#000000") -> some View {
    let json = """
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
    """
    return Nimbus(baseUrl: "base") {
      NimbusNavigator(json:
        json
      )
    }
    .layoutComponents()
  }
}
