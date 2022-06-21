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
@testable import NimbusLayoutSwiftUI

class LocalImageTests: XCTestCase {
  override func setUp() {
    bundle = .module
  }
  
  func localImage(for scale: String) -> some View {
    return NimbusNavigator(json:
    """
    {
      "_:component": "layout:localimage",
      "properties": {
        "id": "nimbus-local",
        "scale": "\(scale)",
        "width": 70,
        "height": 70,
        "clipped": true
      }
    }
    """
    )
      .environmentObject(NimbusConfig())
      .frame(width: 80, height: 125)
  }
  
  func testLocalImageCenter() {
    assertSnapshot(matching: localImage(for: "center"), as: .image)
  }
  
  func testLocalImageFillBounds() {
    assertSnapshot(matching: localImage(for: "fillBounds"), as: .image)
  }
  
  func testLocalImageFillWidth() {
    assertSnapshot(matching: localImage(for: "fillWidth"), as: .image)
  }
  
  func testLocalImageFillHeight() {
    assertSnapshot(matching: localImage(for: "fillHeight"), as: .image)
  }
  
  // integrated (image + row strech)
  func testImageIntrinsicSize() {
    let view = NimbusNavigator(json: """
    {
      "_:component": "layout:row",
      "children": [
        {
          "_:component": "layout:localimage",
          "properties": {
            "id": "nimbus-local",
            "scale": "fillWidth",
            "width": 60,
            "clipped": true
          }
        },
        {
          "_:component": "layout:row",
          "properties": {
            "flex": 1,
            "strech": true,
            "backgroundColor": "#00FF00"
          }
        }],
      "properties": {
        "backgroundColor": "#CCCCCCFF"
      }
    }
    """)
    .environmentObject(NimbusConfig())
    .frame(width: 300, height: 120)
    
    assertSnapshot(matching: view, as: .image)
  }
}
