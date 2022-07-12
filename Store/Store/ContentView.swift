//
//  ContentView.swift
//  Store
//
//  Created by Daniel Tes on 07/07/22.
//

import SwiftUI

import NimbusCore

import NimbusSwiftUI
import NimbusLayoutSwiftUI

struct ContentView: View {
  var body: some View {
    Nimbus(baseUrl: "http://127.0.0.1:8000") {
      Home()
    }
    .layoutComponents()
    .operations(operations)
    .components(components)
//    .globalStateSet([], path: "cart")
  }
}

struct Loading: View {
  var body: some View {
    ProgressView()
  }
}

struct Home: View {
  @ObservedObject var model = HomeModel()
  
  var body: some View {
    TabView(selection: $model.selectedTab) {
      NimbusNavigator(url: "/sample.json")
        .tabItem {
          Label("Products", systemImage: "list.bullet")
        }
        .tag(HomeModel.Tab.products)
        
      NimbusNavigator(url: "/cart.json")
        .tabItem {
          Label("Cart", systemImage: "cart")
        }
        .tag(HomeModel.Tab.cart)
      
      NimbusNavigator(url: "/orders.json")
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
  }
}

class HomeModel: ObservableObject {
  @Published var selectedTab: Tab = .products
  
  enum Tab: Int {
    case products
    case cart
    case orders
    case exit
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

let components: [String: Component] = [
  "material:spinner": { _, _ in
    AnyComponent(Loading())
  },
  "material:button": { element, _ in
    AnyComponent(try CustomButton(from: element.properties))
  }
]

struct CustomButton: View {
  var text: String
  var onPress: () -> Void
  
  var body: some View {
    Button(text) {
      onPress()
    }
  }
}

extension CustomButton: Deserializable {
  init(from map: [String : Any]?, children: [AnyComponent]) throws {
    self.text = try getMapProperty(map: map, name: "text")
    let function = getMapFunction(map: map, name: "onPress")
    self.onPress = { function(nil) }
  }
}

let operations: [String: NimbusSwiftUI.Operation] = [
  "formatPrice": formatPrice
]

let formatPrice: (KotlinArray<AnyObject>) -> Any? = { array in
  if let value = array.get(index:0) as? Double {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter.string(from: NSNumber(value: value))
  }
  return ""
}
