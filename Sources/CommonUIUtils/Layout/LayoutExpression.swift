//
// Created by Alexander Lakhonin on 24.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

#if canImport(UIKit)

import UIKit

public struct LayoutExpression<A: LayoutAnchor> {
  enum ExpressionType {
    case offset
    case multiplication
  }

  let anchor: A
  let value: CGFloat
  let type: ExpressionType
}

@inline(__always)
public func * <D: LayoutDimension>(lhs: D, rhs: CGFloat) -> LayoutExpression<D> {
  LayoutExpression(anchor: lhs, value: rhs, type: .multiplication)
}

@inline(__always)
public func + <A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> LayoutExpression<A> {
  LayoutExpression(anchor: lhs, value: rhs, type: .offset)
}

@inline(__always)
public func - <A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> LayoutExpression<A> {
  lhs + (-rhs)
}

#endif
