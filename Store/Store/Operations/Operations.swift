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

import NimbusCore
import NimbusSwiftUI

let operations: [String: NimbusSwiftUI.Operation] = [
  "formatPrice": formatPrice,
  "sumProducts": sumProducts
]

// TODO: create a wrapper function for KotlinArray returning a Swift Array
let formatPrice: (KotlinArray<AnyObject>) -> Any? = { array in
  if let value = array.get(index:0) as? Double, let code = array.get(index: 1) as? String {
    
//    var arraySwift: [Any?] = []
//    for index in 0..<array.size {
//      arraySwift.append(array.get(index: index))
//    }
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = code
    return formatter.string(from: NSNumber(value: value))
  }
  return ""
}

let sumProducts: (KotlinArray<AnyObject>) -> Any? = { array in
  guard let products = array.get(index: 0) as? [[String: Any]] else { return 0 }
  
  var sum = 0.0
  for product in products {
    if let price = product["price"] as? Double {
      sum += price
    }
  }
  return sum
}
