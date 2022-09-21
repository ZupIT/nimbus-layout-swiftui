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

public typealias Nimbus = NimbusSwiftUI.Nimbus
public typealias NimbusNavigator = NimbusSwiftUI.NimbusNavigator

public let layout = NimbusSwiftUILibrary("layout")
  .addComponent("text") { (element, _) in
    AnyView(try NimbusText(from: element.properties))
  }
  .addComponent("row") { (element, children) in
    AnyView(Row(children: children, container: try Container(from: element.properties)))
  }
  .addComponent("column") { (element, children) in
    AnyView(Column(children: children, container: try Container(from: element.properties)))
  }
  .addComponent("screen") { (element, children) in
    AnyView(try Screen(from: element.properties, children: children))
  }
  .addComponent("localImage") { (element, _) in
    AnyView(try LocalImage(from: element.properties))
  }
  .addComponent("remoteImage") { (element, _) in
    AnyView(try RemoteImage(from: element.properties))
  }
  .addComponent("scrollView") { (element, children) in
    AnyView(try Scroll(from: element.properties, children: children))
  }
  .addComponent("lifecycle") { (element, children) in
    AnyView(try Lifecycle(from: element.properties, children: children))
  }
  .addComponent("touchable") { (element, children) in
    AnyView(try Touchable(from: element.properties, children: children))
  }
  .addComponent("stack") { (element, children) in
    AnyView(try Stack(from: element.properties, children: children))
  }
  .addComponent("positioned") { (element, children) in
    AnyView(try Positioned(from: element.properties, children: children))
  }
