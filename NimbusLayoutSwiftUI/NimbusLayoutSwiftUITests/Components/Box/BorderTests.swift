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

class BorderTests: XCTestCase {
  
  func testModifier() throws {
    let view = Color.green.frame(width: 50, height: 50)
    
    var border = try getBorder(borderWidth: 2)
    assertSnapshot(matching: view.modifier(BorderModifier(border: border)), as: .image)
    
    border = try getBorder(borderColor: "#FF0000", borderWidth: 2, cornerRadius: 25)
    assertSnapshot(matching: view.modifier(BorderModifier(border: border)), as: .image)
    
    border = try getBorder(borderColor: "#0000FF", borderWidth: 1, borderDashSpacing: 2)
    assertSnapshot(matching: view.modifier(BorderModifier(border: border)), as: .image)
    
    border = try getBorder(borderColor: "#0000FF", borderWidth: 1, borderDashLength: 4, borderDashSpacing: 1, cornerRadius: 10)
    assertSnapshot(matching: view.modifier(BorderModifier(border: border)), as: .image)
  }
  
  private func getBorder(
    borderColor: String? = nil,
    borderWidth: Double? = nil,
    borderDashLength: Double? = nil,
    borderDashSpacing: Double? = nil,
    cornerRadius: Double? = nil
  ) throws -> Border {
    let value: [String: Any] = [
      "borderColor": borderColor ?? NSNull(),
      "borderWidth": borderWidth ?? NSNull(),
      "cornerRadius": cornerRadius ?? NSNull(),
      "borderDashLength": borderDashLength ?? NSNull(),
      "borderDashSpacing": borderDashSpacing ?? NSNull()
    ]
    return try NimbusDecoder.decode(Border.self, from: value)
  }
}
