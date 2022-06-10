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
import NimbusCore
import NimbusSwiftUI

public typealias NimbusConfig = NimbusSwiftUI.NimbusConfig
public typealias NimbusNavigator = NimbusSwiftUI.NimbusNavigator

let layoutComponents: [String: Component] = [
//  TODO: move to sample / tests
  "material:text": { element, _ in
    AnyComponent(Text((element.properties?["text"] as? String) ?? ""))
  },
  "layout:row": { element, children in
    AnyComponent(Row(children: children, container: try! Container(from: element.properties ?? [:])))
  },
  "layout:column": { element, children in
    AnyComponent(Column(children: children, container: try! Container(from: element.properties ?? [:])))
  },
  "layout:localimage": { element, _ in
    AnyComponent(try! LocalImage(from: element.properties ?? [:]))
  },
  "layout:remoteimage": { element, _ in
    AnyComponent(try! RemoteImage(from: element.properties ?? [:]))
  },
  "layout:scroll": scrollComponent
]

// TODO: Handle force try

// TODO: move to core
protocol Deserializable {
  init(from map: [String: Any]) throws
}

extension NimbusConfig {
  public convenience init() {
    self.init(baseUrl: "base", components: layoutComponents)
  }
}
