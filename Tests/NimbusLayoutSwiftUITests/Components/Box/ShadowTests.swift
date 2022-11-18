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

@testable import NimbusSwiftUI
@testable import NimbusLayoutSwiftUI

class ShadowTests: XCTestCase {
  func testModifier() throws {
    let shadows = try [
      ["x": 2.0, "y": 2.0, "blur": 2.0, "color": "#FF0000"],
      ["x": -2.0, "y": -2.0, "blur": 4.0],
    ].map {
      try NimbusDecoder.decode(Shadow.self, from: $0)
    }

    let view = Color.green.frame(width: 50, height: 50)
    
    assertSnapshot(matching: ZStack { view.modifier(ShadowModifier(shadows: shadows)) }.frame(width: 70, height: 70), as: .image)
  }
}
