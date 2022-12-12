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

protocol DefaultProtocol {
  associatedtype Value: Decodable
  static var defaultValue: Value { get }
}

@propertyWrapper
struct Default<T: DefaultProtocol> {
  var wrappedValue: T.Value
  
  init(wrappedValue: T.Value) {
    self.wrappedValue = wrappedValue
  }
  
  init() {
    self.wrappedValue = T.defaultValue
  }
}

extension Default: Decodable {}

extension KeyedDecodingContainer {
  func decode<T: DefaultProtocol>(_ type: Default<T>.Type, forKey key: K) throws -> Default<T> {
    guard let value = try? decode(T.Value.self, forKey: key) else {
      return Default()
    }
    return Default(wrappedValue: value)
  }
}

// MARK: - Default values

struct DoubleZero: DefaultProtocol {
  static var defaultValue: Double = 0
}

struct DoubleOne: DefaultProtocol {
  static var defaultValue: Double = 1
}

struct ColorBlack: DefaultProtocol {
  static var defaultValue: Color = .black
}

struct False: DefaultProtocol {
  static var defaultValue = false
}

struct True: DefaultProtocol {
  static var defaultValue = false
}
