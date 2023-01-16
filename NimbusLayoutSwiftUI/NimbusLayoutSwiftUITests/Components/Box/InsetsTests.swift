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

@testable import NimbusLayoutSwiftUI

class InsetsTests: XCTestCase {
  
  func testModifier() throws {
    var padding = Padding(
      all: 2
    )
    
    let view = Color.red
      .frame(width: 50, height: 50)
    
    assertSnapshot(matching: view.modifier(InsetsModifier(insets: padding)), as: .image)
    
    padding.vertical = 6
    assertSnapshot(matching: view.modifier(InsetsModifier(insets: padding)), as: .image)
    
    padding.horizontal = 6
    assertSnapshot(matching: view.modifier(InsetsModifier(insets: padding)), as: .image)
    
    padding.top = 10
    padding.bottom = 2
    padding.start = 8
    padding.end = 4
    assertSnapshot(matching: view.modifier(InsetsModifier(insets: padding)), as: .image)
  }
}
