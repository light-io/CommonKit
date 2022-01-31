//
// Created by Alexander Lakhonin on 24.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

#if canImport(UIKit)

import UIKit

public protocol LayoutDimension: LayoutAnchor {
  func constraint(equalToConstant: CGFloat) -> NSLayoutConstraint
  func constraint(equalTo: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint

  func constraint(greaterThanOrEqualToConstant: CGFloat) -> NSLayoutConstraint
  func constraint(greaterThanOrEqualTo: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint

  func constraint(lessThanOrEqualToConstant: CGFloat) -> NSLayoutConstraint
  func constraint(lessThanOrEqualTo: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutDimension: LayoutDimension { }

public struct LayoutDimensionProperty<Dimension: LayoutDimension> {
  public let anchor: Dimension
}

public extension LayoutDimensionProperty {
  func equal(to constant: CGFloat) -> NSLayoutConstraint {
    anchor.constraint(equalToConstant: constant)
  }

  func equal(
    to anotherDimension: Dimension, multiplier: CGFloat = 1, constant: CGFloat = 0
  ) -> NSLayoutConstraint {
    anchor.constraint(equalTo: anotherDimension, multiplier: multiplier, constant: constant)
  }

  func greaterThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
    anchor.constraint(greaterThanOrEqualToConstant: constant)
  }

  func greaterThanOrEqual(
    to anotherDimension: Dimension, multiplier: CGFloat = 1, constant: CGFloat = 0
  ) -> NSLayoutConstraint {
    anchor.constraint(greaterThanOrEqualTo: anotherDimension, multiplier: multiplier, constant: constant)
  }

  func lessThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
    anchor.constraint(lessThanOrEqualToConstant: constant)
  }

  func lessThanOrEqual(
    to anotherDimension: Dimension, multiplier: CGFloat = 1, constant: CGFloat = 0
  ) -> NSLayoutConstraint {
    anchor.constraint(lessThanOrEqualTo: anotherDimension, multiplier: multiplier, constant: constant)
  }
}

@inline(__always)
public func == <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: CGFloat) -> NSLayoutConstraint {
  lhs.equal(to: rhs)
}

@inline(__always)
public func == <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: D) -> NSLayoutConstraint {
  lhs.equal(to: rhs)
}

@inline(__always)
public func == <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: LayoutExpression<D>) -> NSLayoutConstraint {
  switch rhs.type {
  case .multiplication:
    return lhs.equal(to: rhs.anchor, multiplier: rhs.value)
  case .offset:
    return lhs.equal(to: rhs.anchor, constant: rhs.value)
  }
}

@inline(__always)
public func >= <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: CGFloat) -> NSLayoutConstraint {
  lhs.greaterThanOrEqual(to: rhs)
}

@inline(__always)
public func >= <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: D) -> NSLayoutConstraint {
  lhs.greaterThanOrEqual(to: rhs)
}

@inline(__always)
public func >= <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: LayoutExpression<D>) -> NSLayoutConstraint {
  switch rhs.type {
  case .multiplication:
    return lhs.greaterThanOrEqual(to: rhs.anchor, multiplier: rhs.value)
  case .offset:
    return lhs.greaterThanOrEqual(to: rhs.anchor, constant: rhs.value)
  }
}

@inline(__always)
public func <= <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: CGFloat) -> NSLayoutConstraint {
  lhs.lessThanOrEqual(to: rhs)
}

@inline(__always)
public func <= <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: D) -> NSLayoutConstraint {
  lhs.lessThanOrEqual(to: rhs)
}

@inline(__always)
public func <= <D: LayoutDimension>(lhs: LayoutDimensionProperty<D>, rhs: LayoutExpression<D>) -> NSLayoutConstraint {
  switch rhs.type {
  case .multiplication:
    return lhs.lessThanOrEqual(to: rhs.anchor, multiplier: rhs.value)
  case .offset:
    return lhs.lessThanOrEqual(to: rhs.anchor, constant: rhs.value)
  }
}

#endif
