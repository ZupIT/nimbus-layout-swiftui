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

import SwiftUI

extension Color {
  /// Create a color from hex String.
  /// Format:  #RRGGBB[AA]
  init?(hex: String) {
    guard hex.range(of: "^#[0-9A-F]{6,8}$", options: [.regularExpression, .caseInsensitive]) != nil else {
      return nil
    }
    var int = UInt64()
    let hexDigits = String(hex.suffix(from: hex.index(after: hex.startIndex)))
    Scanner(string: hexDigits).scanHexInt64(&int)
    let r, g, b, a: UInt64
    switch hexDigits.count {
      
    case 6: // RGB (24-bit)
      (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
    case 8: // RGBA (32-bit)
      (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      return nil
    }
    self.init(
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}

extension Optional where Wrapped == String {
  var color: Color? {
    switch self {
    case .none:
      return nil
    case .some(let wrapped):
      return Color(hex: wrapped)
    }
  }
}
