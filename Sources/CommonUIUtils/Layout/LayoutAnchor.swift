//
// Created by Alexander Lakhonin on 24.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

#if canImport(UIKit)

import UIKit

public protocol LayoutAnchor {
  func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
  func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
  func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor { }

public struct LayoutAnchorProperty<Anchor: LayoutAnchor> {
  public let anchor: Anchor
}

public extension LayoutAnchorProperty {
  func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
    anchor.constraint(equalTo: otherAnchor, constant: constant)
  }

  func greaterThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
    anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
  }

  func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
    anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
  }
}

@inline(__always)
public func == <A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: A) -> NSLayoutConstraint {
  lhs.equal(to: rhs)
}

@inline(__always)
public func == <A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: LayoutExpression<A>) -> NSLayoutConstraint {
  lhs.equal(to: rhs.anchor, offsetBy: rhs.value)
}

@inline(__always)
public func >= <A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: A) -> NSLayoutConstraint {
  lhs.greaterThanOrEqual(to: rhs)
}

@inline(__always)
public func >= <A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: LayoutExpression<A>) -> NSLayoutConstraint {
  lhs.greaterThanOrEqual(to: rhs.anchor, offsetBy: rhs.value)
}

@inline(__always)
public func <= <A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: A) -> NSLayoutConstraint {
  lhs.lessThanOrEqual(to: rhs)
}

@inline(__always)
public func <= <A: LayoutAnchor>(lhs: LayoutAnchorProperty<A>, rhs: LayoutExpression<A>) -> NSLayoutConstraint {
  lhs.lessThanOrEqual(to: rhs.anchor, offsetBy: rhs.value)
}

#endif
