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

@testable import NimbusLayoutSwiftUI

class BoxTests: XCTestCase {
  
  // TODO: Missing Shadow and Border
  
  func testModifier() throws {
    let box = Box(
      backgroundColor: "#ff0000",
      shadow: [],
      margin: Margin(all: 5),
      padding: Padding(all: 5),
      size: Size(width: 50, height: 50, clipped: true),
      border: Border()
    )
    
    let view = HStack {
      Color.green
    }
    
    assertSnapshot(matching: view.modifier(BoxModifier(box: box)), as: .image)
  }
}
