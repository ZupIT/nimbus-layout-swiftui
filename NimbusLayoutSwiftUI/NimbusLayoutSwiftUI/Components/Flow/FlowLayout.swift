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

internal struct FlowLayoutSpacing {
  var horizontal: CGFloat
  var vertical: CGFloat
  
  init (horizontal: CGFloat, vertical: CGFloat) {
    self.horizontal = horizontal
    self.vertical = vertical
  }
}

private struct Flow<Content>: View
where Content : View {
  var alignment: Alignment
  var axis: Axis
  var size: CGSize
  var content: () -> Content
  var spacing: FlowLayoutSpacing
    
  var body: some View {
    var view = (
      alignments: [] as [CGSize],
      leading: 0 as CGFloat,
      top: 0 as CGFloat,
      maxMeasure: 0 as CGFloat
    )
    
    var line = (
      lastAdjusted: false,
      maxMeasure: 0 as CGFloat
    )
    
    var indexes = (
      current: 0,
      firstLine: 0,
      max: nil as Int?
    )
                
    ZStack(alignment: .topLeading) {
      content()
        .fixedSize()
        .alignmentGuide(.leading) { dimensions in
          if let maxIndex = indexes.max, indexes.current > maxIndex {
            indexes.current %= maxIndex
          }
          if view.alignments.indices.contains(indexes.current) {
            return view.alignments[indexes.current].width
          }
          
          let isHorizontal = (axis == .horizontal)
          let measures = (
            isHorizontal ? (
              dimension: (
                measure: (
                  value: dimensions.height,
                  oppositeValue: dimensions.width
                ),
                axisMeasure: dimensions[alignment.vertical],
                endMeasure: dimensions[.bottom]
              ),
              size: size.height,
              spacing: (
                value: spacing.horizontal,
                oppositeValue: spacing.vertical
              )
            ) : (
              dimension: (
                measure: (
                  value: dimensions.width,
                  oppositeValue: dimensions.height
                ),
                axisMeasure: dimensions[alignment.horizontal],
                endMeasure: dimensions[.trailing]
              ),
              size: size.width,
              spacing: (
                value: spacing.vertical,
                oppositeValue: spacing.horizontal
              )
            )
          )
          var topLeading: CGFloat {
            get {
              return (isHorizontal ? view.top : view.leading)
            }
            set(value) {
              if (isHorizontal) {
                view.top = value
              } else {
                view.leading = value
              }
            }
          }
          var oppositeTopLeading: CGFloat {
            get {
              return (isHorizontal ? view.leading : view.top)
            }
            set(value) {
              if (isHorizontal) {
                view.leading = value
              } else {
                view.top = value
              }
            }
          }
          var calculatedAdjustment: CGFloat {
            get {
              return (line.maxMeasure + topLeading) * (measures.dimension.axisMeasure / measures.dimension.endMeasure)
            }
          }
                    
          if (abs(topLeading - measures.dimension.measure.value) > measures.size) {
            if (-topLeading > line.maxMeasure) {
              let previousLinesAdjustment = calculatedAdjustment
              for index in 0..<indexes.firstLine {
                if (isHorizontal) {
                  view.alignments[index].height += previousLinesAdjustment
                } else {
                  view.alignments[index].width += previousLinesAdjustment
                }
              }
            }
            line.maxMeasure = max(line.maxMeasure, -topLeading)
            
            let currentLineAdjustment = calculatedAdjustment
            for index in indexes.firstLine..<indexes.current {
              if (isHorizontal) {
                view.alignments[index].height -= currentLineAdjustment
              } else {
                view.alignments[index].width -= currentLineAdjustment
              }
            }
            
            oppositeTopLeading -= (topLeading == 0 ? measures.dimension.measure.oppositeValue : view.maxMeasure) + measures.spacing.value
            topLeading = 0
            indexes.firstLine = indexes.current
            view.maxMeasure = measures.dimension.measure.oppositeValue
          } else {
            view.maxMeasure = max(view.maxMeasure, measures.dimension.measure.oppositeValue)
          }
          
          view.alignments.append(CGSize(width: view.leading, height: view.top))
          topLeading -= measures.dimension.measure.value + measures.spacing.oppositeValue
          return view.alignments[indexes.current].width
        }
        .alignmentGuide(.top) { _ in
          if let maxIndex = indexes.max, indexes.current > maxIndex {
            indexes.current %= maxIndex
          }
                    
          var top: CGFloat = 0
          if (view.alignments.indices.contains(indexes.current)) {
            top = view.alignments[indexes.current].height
          }
                    
          indexes.current += 1
          return top
        }
            
        Color.clear
          .frame(width: 1, height: 1)
          .alignmentGuide(.leading) { dimensions in
            if (indexes.max == nil) {
              indexes.max = indexes.current
            }
                    
            if !line.lastAdjusted, let lastIndex = view.alignments.indices.last {
              let isHorizontal = (axis == .horizontal)
              let topLeading = (isHorizontal ? view.top : view.leading)
              let dimensionAxisMeasure = (isHorizontal ? dimensions[alignment.vertical] : dimensions[alignment.horizontal])
              let dimensionEndMeasure = (isHorizontal ? dimensions[.bottom] : dimensions[.trailing])
              let adjustment = (line.maxMeasure + topLeading) * (dimensionAxisMeasure / dimensionEndMeasure)
              
              for index in indexes.firstLine...lastIndex {
                if (isHorizontal) {
                  view.alignments[index].height -= adjustment
                } else {
                  view.alignments[index].width -= adjustment
                }
              }
                
              line.lastAdjusted = true
            }
                    
            indexes.current = 0
            indexes.firstLine = 0
            view.leading = 0
            view.top = 0
            view.maxMeasure = 0
            line.maxMeasure = 0
            return 0
          }
          .hidden()
        }
        .frame(
          width: axis == .vertical ? 0 : nil,
          height: axis == .horizontal ? 0 : nil,
          alignment: alignment
        )
    }
}

@available(iOS 14.0, *)
internal struct FlowLayout<Content>: View
where Content : View {
  @State private var contentSize = CGSize.zero
  @State private var transaction = Transaction()
  private var alignment: Alignment
  private var axis: Axis
  private var content: () -> Content
  
  init(axis: Axis, alignment: Alignment, content: @escaping () -> Content) {
    self.alignment = alignment
    self.axis = axis
    self.content = content
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: alignment) {
        Color.clear.hidden()
        Flow(
          alignment: alignment,
          axis: axis,
          size: geometry.size,
          content: content,
          spacing: FlowLayoutSpacing(horizontal: 0, vertical: 0)
        )
        .transaction { updateTransaction($0) }
        .background(
          GeometryReader { geometry in
            Color.clear
              .onAppear { contentSize = geometry.size }
              .onChange(of: geometry.size) { newContentSize in
                DispatchQueue.main.async {
                  withTransaction(transaction) { contentSize = newContentSize }
                }
              }
          }
          .hidden()
        )
      }
    }
    .frame(
      width: axis == .horizontal ? contentSize.width : nil,
      height: axis == .vertical ? contentSize.height : nil
    )
  }
}


@available(iOS 14.0, *)
internal extension FlowLayout {
  func updateTransaction(_ newTransaction: Transaction) {
    if (
      transaction.animation != newTransaction.animation ||
      transaction.disablesAnimations != newTransaction.disablesAnimations ||
      transaction.isContinuous != newTransaction.isContinuous
    ) {
      DispatchQueue.main.async { transaction = newTransaction }
    }
  }
}
