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

class RowTests: XCTestCase {
  
  func testRowFlex() {
    let view = NimbusNavigator(json:
    """
    {
      "_:component": "layout:row",
      "children": [
        {
          "_:component": "layout:row",
          "children": [{
            "_:component": "material:text",
            "properties": {
              "text": "r"
            }
          }],
          "properties": {
            "flex":2,
            "backgroundColor": "#FF0000",
            "height": 40.0,
            "marginTop": 10,
            "marginBottom": 10
          }
        },
        {
          "_:component": "layout:row",
          "children": [{
            "_:component": "material:text",
            "properties": {
              "text": "g"
            }
          }],
          "properties": {
            "flex":1,
            "backgroundColor": "#00FF00",
            "height": 40.0
          }
        },
        {
          "_:component": "layout:row",
          "children": [{
            "_:component": "material:text",
            "properties": {
              "text": "b"
            }
          }],
          "properties": {
            "flex":1,
            "backgroundColor": "#0000FF",
            "height": 40.0,
            "paddingTop": 10
          }
        }
      ],
      "properties": {
        "backgroundColor": "#FFCCCCCC"
      }
    }
    """
    )
      .environmentObject(NimbusConfig())
      .frame(width: 100, height: 130)
    assertSnapshot(matching: view, as: .image)
  }

  func testRowMainAxisAlignment() {
    assertSnapshot(matching: view(mainAxis: "center"), as: .image)
    assertSnapshot(matching: view(mainAxis: "start"), as: .image)
    assertSnapshot(matching: view(mainAxis: "end"), as: .image)
    assertSnapshot(matching: view(mainAxis: "spaceBetween"), as: .image)
    assertSnapshot(matching: view(mainAxis: "spaceAround"), as: .image)
    assertSnapshot(matching: view(mainAxis: "spaceEvenly"), as: .image)
  }
  
  func testRowCrossAxisAlignment() {
    assertSnapshot(matching: view(crossAxis: "center"), as: .image)
    assertSnapshot(matching: view(crossAxis: "start"), as: .image)
    assertSnapshot(matching: view(crossAxis: "end"), as: .image)
    
    // TODO: stretch
//    assertSnapshot(matching: view(crossAxis: "strech"), as: .image)
  }
  
  func view(mainAxis: String = "start", crossAxis: String = "start") -> some View {
    let json = """
    {
      "_:component": "layout:row",
      "children": [
        {
          "_:component": "layout:row",
          "properties": {
            "backgroundColor": "#FF0000",
            "height" : 30,
            "width" : 20
          }
        },
        {
          "_:component": "layout:row",
          "properties": {
            "backgroundColor": "#00FF00",
            "height" : 20,
            "width": 20
          }
        },
        {
          "_:component": "layout:row",
          "properties": {
            "backgroundColor": "#0000FF",
            "height" : 20,
            "width": 20
          }
        }
      ],
      "properties": {
        "backgroundColor": "#FFCCCCCC",
        "mainAxisAlignment": "\(mainAxis)",
        "crossAxisAlignment": "\(crossAxis)"
      }
    }
    """
    return NimbusNavigator(json:
      json
    )
      .environmentObject(NimbusConfig())
      .frame(width: 80, height: 80)
  }
}
