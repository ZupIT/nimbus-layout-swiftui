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

public typealias Nimbus = NimbusSwiftUI.Nimbus
public typealias NimbusNavigator = NimbusSwiftUI.NimbusNavigator

let layoutComponentMap: [String: Component] = [
  "layout:text": { element, _ in
    AnyComponent(try NimbusText(from: element.properties), element.id)
  },
  "layout:row": { element, children in
    AnyComponent(Row(children: children, container: try Container(from: element.properties)), element.id)
  },
  "layout:column": { element, children in
    AnyComponent(Column(children: children, container: try Container(from: element.properties)), element.id)
  },
  "layout:localImage": { element, _ in
    AnyComponent(try LocalImage(from: element.properties), element.id)
  },
  "layout:remoteImage": { element, _ in
    AnyComponent(try RemoteImage(from: element.properties), element.id)
  },
  "layout:scrollView": scrollComponent,
  "layout:lifecycle": { element, children in
    AnyComponent(try Lifecycle(from: element.properties, children: children), element.id)
  },
  "layout:screen": { element, children in
    AnyComponent(try Screen(from: element.properties, children: children), element.id)
  },
  "layout:touchable": { element, children in
    AnyComponent(try Touchable(from: element.properties, children: children), element.id)
  },
  "layout:stack": { element, children in
    AnyComponent(try Stack(from: element.properties, children: children), element.id)
  },
  "layout:positioned": { element, children in
    AnyComponent(try Positioned(from: element.properties, children: children), element.id)
  }
]

extension Nimbus {
  public func layoutComponents() -> Self {
    components(layoutComponentMap)
  }
}
