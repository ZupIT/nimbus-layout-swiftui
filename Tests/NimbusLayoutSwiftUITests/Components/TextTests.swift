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
    return NimbusNavigator(json:
      json
    )
      .environmentObject(NimbusConfig())
      .frame(width: 80, height: 80)
  }
  
}
