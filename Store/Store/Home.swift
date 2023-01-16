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
import NimbusCore
import NimbusLayoutSwiftUI

let homeModelKey = "bottomNavigator"

class HomeModel: ObservableObject {
  @Published var selectedTab: Tab = .products
  
  enum Tab: Int {
    case products
    case cart
    case orders
    case exit
  }
  
  func changeTab(route: String) {
    switch(route) {
    case "Products": selectedTab = Tab.products
    case "Cart": selectedTab = Tab.cart
    case "Orders": selectedTab = Tab.orders
    case "exit": selectedTab = Tab.exit
    default: print("Invalid route: \(route)")
    }
  }
  
  func save(_ scope: NimbusCore.Scope) {
    scope.set(key: homeModelKey, value: self)
  }
  
  static func clear(_ scope: NimbusCore.Scope) {
    scope.unset(key: homeModelKey)
  }
  
  static func get(_ scope: NimbusCore.Scope) -> HomeModel? {
    let raw = scope.get(key: "bottomNavigator")
    return raw is HomeModel ? raw as? HomeModel : nil
  }
}

class ObservedCart: ObservableObject, Dependent {
  @Published var count = 0
  private var globalState: ServerDrivenState? = nil
  
  func start(globalState: ServerDrivenState) {
    self.globalState = globalState
    update()
    globalState.addDependent(dependent: self)
  }
  
  func update() {
    let data = AnyServerDrivenData(value: globalState?.get())
    if let products = data.get(key: "cart").get(key: "products").asListOrNull() {
      self.count = products.reduce(0) { total, current in
        total + (current.get(key: "quantity").asIntOrNull()?.intValue ?? 0)
      }
    }
  }
}

struct Home: View {
  @ObservedObject var model = HomeModel()
  @ObservedObject var cart = ObservedCart()
  
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
        
        NimbusNavigator(url: "/orders")
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
        Text("\(self.cart.count)")
          .foregroundColor(.white)
          .font(Font.system(size: 12))
      }
      .frame(width: 20, height: 20)
      .offset(x: 2 * (geometry.size.width / 5), y: geometry.size.height - 45)
      .opacity(self.cart.count == 0 ? 0 : 1)
    }
    // configuring cart badge number
    .core { core in
      self.nimbus = core
      if let globalState = core.states?.last {
        cart.start(globalState: globalState)
      }
      model.save(core)
    }
    .onDisappear {
      if let nimbus = nimbus {
        HomeModel.clear(nimbus)
      }
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
