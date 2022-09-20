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

import Foundation
import SwiftUI
import NimbusSwiftUI

let storeUI = NimbusSwiftUILibrary("store")
  .addComponent("spinner") { element, _ in
    AnyView(ProgressView())
  }
  .addComponent("button") { element, _ in
    AnyView(try CustomButton(from: element.properties))
  }
  .addComponent("textInput") { element, _ in
    AnyView(try TextInput(from: element.properties))
  }
  .addOperation("formatPrice", handler: formatPrice)
  .addOperation("sumProducts", handler: sumProducts)
