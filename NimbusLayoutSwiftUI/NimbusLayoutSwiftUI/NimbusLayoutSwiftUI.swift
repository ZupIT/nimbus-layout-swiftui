/*
 * Copyright 2023 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
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
  .addComponent("text", NimbusText.self)
  .addComponent("row", Row<AnyView>.self)
  .addComponent("flowRow", FlowRow<AnyView>.self)
  .addComponent("lazyRow", LazyRow<AnyView>.self)
  .addComponent("column", Column<AnyView>.self)
  .addComponent("flowColumn", FlowColumn<AnyView>.self)
  .addComponent("lazyColumn", LazyColumn<AnyView>.self)
  .addComponent("screen", Screen<AnyView>.self)
  .addComponent("localImage", LocalImage.self)
  .addComponent("remoteImage", RemoteImage.self)
  .addComponent("scrollView", Scroll<AnyView>.self)
  .addComponent("lifecycle", Lifecycle<AnyView>.self)
  .addComponent("touchable", Touchable<AnyView>.self)
  .addComponent("stack", Stack<AnyView>.self)
  .addComponent("positioned", Positioned<AnyView>.self)
