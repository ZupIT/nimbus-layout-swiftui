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

import NimbusLayoutSwiftUI

class HelloTests: XCTestCase {
  
  func testHello() {
    let view = NimbusNavigator(json:
    """
    {
      "_:component": "material:text",
      "properties": {
        "text": "Hello!!!"
      }
    }
    """
    )
      .environmentObject(NimbusConfig())
      .frame(width: 100, height: 100)
    assertSnapshot(matching: view, as: .image)
  }
  
}
