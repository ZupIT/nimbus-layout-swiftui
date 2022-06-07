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

class BorderTests: XCTestCase {
  
  func testModifier() throws {
    let view = Color.green.frame(width: 50, height: 50)
    
    var border = Border(borderWidth: 2)
    assertSnapshot(matching: view.modifier(BorderModifier(border: border)), as: .image)
    
    border = Border(borderColor: .red, borderWidth: 2, cornerRadius: 25)
    assertSnapshot(matching: view.modifier(BorderModifier(border: border)), as: .image)
    
    border = Border(borderColor: .blue, borderWidth: 1, borderDashSpacing: 2)
    assertSnapshot(matching: view.modifier(BorderModifier(border: border)), as: .image)
    
    border = Border(borderColor: .blue, borderWidth: 1, borderDashLength: 4, borderDashSpacing: 1, cornerRadius: 10)
    assertSnapshot(matching: view.modifier(BorderModifier(border: border)), as: .image)
  }
}
