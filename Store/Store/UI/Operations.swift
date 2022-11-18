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
import NimbusSwiftUI

// MARK: - formatPrice
let formatPrice: (FormatPriceOperation) -> Any? = { operation in
  operation.format()
}

struct FormatPriceOperation: OperationDecodable {
  static var properties = ["value", "code"]
  
  var code: String
  var value: Double
  
  func format() -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = code
    return formatter.string(from: NSNumber(value: value))
  }
}

// MARK: - sumProducts
let sumProducts: (ProductsOperation) -> Any? = { operation in
  operation.products.map {
    $0.price
  }
  .reduce(0.0, +)
}

struct ProductsOperation: OperationDecodable {
  static var properties = ["products"]
  
  struct Item: Decodable {
    var price: Double
  }
  
  var products: [Item]
}
