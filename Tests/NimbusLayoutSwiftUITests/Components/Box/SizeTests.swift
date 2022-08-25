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

class SizeTests: XCTestCase {
  func testModifier() throws {
    var size = Size(maxWidth: 50, maxHeight: 50, clipped: true)
    
    let view = ZStack(alignment: .top) {
      Color.blue.frame(width: 60, height: 60)
    }
    
    assertSnapshot(matching: view.modifier(SizeModifier(size: size)), as: .image, named: "maxSize")
    
    size.minWidth = 45
    size.minHeight = 35
    assertSnapshot(matching: view.modifier(SizeModifier(size: size)), as: .image, named: "bounded")
    
    size.width = .fixed(30)
    size.height = .fixed(20)
    assertSnapshot(matching: view.modifier(SizeModifier(size: size)), as: .image, named: "fixed")
    
    size.clipped = false
    let newView = ZStack { view.modifier(SizeModifier(size: size, alignment: .center)) }.frame(width: 70, height: 70)
    assertSnapshot(matching: newView, as: .image, named: "unclipped")
    
    let minSize = Size(minWidth: 90, minHeight: 70)
    assertSnapshot(matching: view.modifier(SizeModifier(size: minSize, alignment: .center)), as: .image, named: "minSize")
  }
}
