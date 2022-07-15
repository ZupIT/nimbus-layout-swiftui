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
import NimbusLayoutSwiftUI

class HomeModel: ObservableObject {
  @Published var selectedTab: Tab = .products
  
  enum Tab: Int {
    case products
    case cart
    case orders
    case exit
  }
}

struct Home: View {
  @ObservedObject var model = HomeModel()
  
  @State var badgeNumber = 0
  @State var nimbus: NimbusCore.Nimbus?
  
  var body: some View {
    GeometryReader { geometry in
      TabView(selection: $model.selectedTab) {
        NimbusNavigator(url: "/products")
          .tabItem {
            Label("Products", systemImage: "list.bullet")
          }
          .tag(HomeModel.Tab.products)
        
        NimbusNavigator(url: "/cart")
          .tabItem {
            Label("Cart", systemImage: "cart")
          }
          .tag(HomeModel.Tab.cart)
        
        NimbusNavigator(url: "/order")
          .tabItem {
            Label("Orders", systemImage: "person.crop.square")
          }
          .tag(HomeModel.Tab.orders)
        
        Text("Exit")
          .tabItem {
            Label("Exit", systemImage: "rectangle.portrait.and.arrow.right")
          }
          .tag(HomeModel.Tab.exit)
      }
      .environmentObject(model)
      
      // cart badge layout
      ZStack {
        Circle()
          .foregroundColor(.red)
        Text("\(self.badgeNumber)")
          .foregroundColor(.white)
          .font(Font.system(size: 12))
      }
      .frame(width: 20, height: 20)
      .offset(x: 2 * (geometry.size.width / 5), y: geometry.size.height - 45)
      .opacity(self.badgeNumber == 0 ? 0 : 1)
    }
    // configuring cart badge number
    .core { core in
      self.nimbus = core
      core.globalState.onChange {
        if let state = nimbus?.globalState.getValueCopy() as? [String: Any],
           let count = (state["cart"] as? [Any])?.count {
          badgeNumber = count
        }
      }
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}