/*
 * Copyright 2023 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
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

@testable import NimbusSwiftUI
@testable import NimbusLayoutSwiftUI

class BoxTests: XCTestCase {
  
  func testModifier() throws {
    let box = try NimbusDecoder.decode(Box.self, from: [
      "backgroundColor": "#FF0000",
      "shadow": [["blur": 4.0, "color": "#FF0000"]],
      "margin": 5.0,
      "padding": 5.0,
      "width": 50.0,
      "height": 50.0,
      "clipped": true,
      "borderWidth": 1.0
    ])
    
    let view = HStack {
      Color.green
    }
    
    assertSnapshot(matching: view.modifier(BoxModifier(box: box)), as: .image)
  }
}
