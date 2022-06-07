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
import SnapshotTesting

import NimbusSwiftUI

class ColumnTests: XCTestCase {
  
  func testColumnFlex() {
    let view = NimbusNavigator(json:
    """
    {
      "_:component": "layout:column",
      "children": [
        {
          "_:component": "layout:column",
          "children": [{
            "_:component": "material:text",
            "properties": {
              "text": "r"
            }
          }],
          "properties": {
            "flex": 2,
            "backgroundColor": "#FF0000",
            "width": 30.0,
            "margin": 5
          }
        },
        {
          "_:component": "layout:column",
          "children": [{
            "_:component": "material:text",
            "properties": {
              "text": "g"
            }
          }],
          "properties": {
            "flex": 1,
            "backgroundColor": "#00FF00",
            "width": 30
          }
        },
        {
          "_:component": "layout:column",
          "children": [{
            "_:component": "material:text",
            "properties": {
              "text": "b"
            }
          }],
          "properties": {
            "flex": 1,
            "backgroundColor": "#0000FF",
            "width": 30,
            "paddingStart": 10
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
      .frame(width: 100, height: 160)
    assertSnapshot(matching: view, as: .image)
  }
  
}
