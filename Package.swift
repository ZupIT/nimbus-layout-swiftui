// swift-tools-version: 5.5

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

import PackageDescription

let package = Package(
  name: "NimbusLayoutSwiftUI",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "NimbusLayoutSwiftUI",
      targets: ["NimbusLayoutSwiftUI"]
    )
  ],
  dependencies: [
    .package(path: "../nimbus-swiftui"),
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.9.0"
    )
  ],
  targets: [
    .target(
      name: "NimbusLayoutSwiftUI",
      dependencies: [
        .product(name: "NimbusSwiftUI", package: "nimbus-swiftui")
      ]
    ),
    .testTarget(
      name: "NimbusLayoutSwiftUITests",
      dependencies: [
        "NimbusLayoutSwiftUI",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
      ]
    )
  ]
)
