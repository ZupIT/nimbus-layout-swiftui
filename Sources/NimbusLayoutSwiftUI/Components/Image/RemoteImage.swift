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
import NimbusSwiftUI

struct RemoteImage: View, BaseImage {
  var url: String
  var placeholder: String?
  
  var scale: ImageScale
  var size: Size
  var accessibility: Accessibility
  
  var body: some View {
    BaseImageView(
      mode: .remote(url, placeholder: placeholder),
      scale: scale,
      size: size,
      accessibility: accessibility
    )
  }
}

extension RemoteImage: Deserializable {
  init(from map: [String : Any]?) throws {
    self.url = try getMapProperty(map: map, name: "url")
    self.placeholder = try getMapProperty(map: map, name: "placeholder")
    self.scale = try getMapEnumDefault(map: map, name: "scale", default: .center)
    
    self.size = try Size.init(from: map)
    self.accessibility = try Accessibility.init(from: (map?["accessibility"] as? [String: Any]))
  }
}
