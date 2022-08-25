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

import NimbusSwiftUI

struct Padding: Insets {
  var all: Double?
  var start: Double?
  var end: Double?
  var top: Double?
  var bottom: Double?
  var horizontal: Double?
  var vertical: Double?
}

extension Padding: Deserializable {
  init(from map: [String : Any]?) throws {
    self.all = try getMapProperty(map: map, name: "padding")
    self.start = try getMapProperty(map: map, name: "paddingStart")
    self.end = try getMapProperty(map: map, name: "paddingEnd")
    self.top = try getMapProperty(map: map, name: "paddingTop")
    self.bottom = try getMapProperty(map: map, name: "paddingBottom")
    self.horizontal = try getMapProperty(map: map, name: "paddingHorizontal")
    self.vertical = try getMapProperty(map: map, name: "paddingVertical")
  }
}
