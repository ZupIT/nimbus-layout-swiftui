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

@testable import NimbusLayoutSwiftUI

class ColorTests: XCTestCase {
  
  func testInvalidHexColor() {
    XCTAssertNil(Color(hex: "AABBCC"))
    XCTAssertNil(Color(hex: "#1"))
    XCTAssertNil(Color(hex: "#12"))
    XCTAssertNil(Color(hex: "#12345"))
    XCTAssertNil(Color(hex: "#1234567"))
    XCTAssertNil(Color(hex: "#XABBCCDD"))
    XCTAssertNil(Color(hex: "#AABBCCDDY"))
  }
  
  func testShortRGB() {
    XCTAssertEqual(Color(hex: "#5AD")?.description, "#55AADDFF")
  }
  
  func testShortRGBA() {
    XCTAssertEqual(Color(hex: "#368a")?.description, "#336688AA")
  }
  
  func testRGB() {
    XCTAssertEqual(Color(hex: "#ac0D42")?.description, "#AC0D42FF")
  }
  
  func testRGBA() {
    XCTAssertEqual(Color(hex: "#31BF523C")?.description, "#31BF523C")
  }
  
  func testColorDecode() throws {
    let data = "\"#FF0000\"".data(using: .utf8)!
    let color = try JSONDecoder().decode(Color.self, from: data)
    
    XCTAssertEqual(color.description, "#FF0000FF")
  }
  
  func testColorDecodeError() {
    let data = "\"#FF000\"".data(using: .utf8)!
    XCTAssertThrowsError(try JSONDecoder().decode(Color.self, from: data)) { error in
      guard case let .dataCorrupted(context) = (error as! DecodingError),
              context.debugDescription == "Invalid color string." else {
        XCTFail("Invalid error.")
        return
      }
    }
  }
}
