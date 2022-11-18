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

struct Margin: Insets {
  var all: Double?
  var start: Double?
  var end: Double?
  var top: Double?
  var bottom: Double?
  var horizontal: Double?
  var vertical: Double?
}

extension Margin: Decodable {
  enum CodingKeys: String, CodingKey {
    case all = "margin"
    case start = "marginStart"
    case end = "marginEnd"
    case top = "marginTop"
    case bottom = "marginBottom"
    case horizontal = "marginHorizontal"
    case vertical = "marginVertical"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.all = try container.decodeIfPresent(Double.self, forKey: .all)
    self.start = try container.decodeIfPresent(Double.self, forKey: .start)
    self.end = try container.decodeIfPresent(Double.self, forKey: .end)
    self.top = try container.decodeIfPresent(Double.self, forKey: .top)
    self.bottom = try container.decodeIfPresent(Double.self, forKey: .bottom)
    self.horizontal = try container.decodeIfPresent(Double.self, forKey: .horizontal)
    self.vertical = try container.decodeIfPresent(Double.self, forKey: .vertical)
  }
}
