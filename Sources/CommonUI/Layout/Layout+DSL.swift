//
// Created by Alexander Lakhonin on 24.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

#if canImport(UIKit)

import UIKit

public final class LayoutProxy {
  public private(set) lazy var leading = anchorProperty(with: view.leadingAnchor)
  public private(set) lazy var trailing = anchorProperty(with: view.trailingAnchor)
  public private(set) lazy var top = anchorProperty(with: view.topAnchor)
  public private(set) lazy var bottom = anchorProperty(with: view.bottomAnchor)
  public private(set) lazy var centerX = anchorProperty(with: view.centerXAnchor)
  public private(set) lazy var centerY = anchorProperty(with: view.centerYAnchor)
  public private(set) lazy var width = dimensionProperty(with: view.widthAnchor)
  public private(set) lazy var height = dimensionProperty(with: view.heightAnchor)

  private let view: UIView

  fileprivate init(view: UIView) {
    self.view = view
  }

  private func anchorProperty<A: LayoutAnchor>(with anchor: A) -> LayoutAnchorProperty<A> {
    LayoutAnchorProperty(anchor: anchor)
  }

  private func dimensionProperty<D: LayoutDimension>(with anchor: D) -> LayoutDimensionProperty<D> {
    LayoutDimensionProperty(anchor: anchor)
  }
}

@resultBuilder
public enum LayoutBuilder {
  public static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
    components
  }

  public static func buildBlock(
    _ components: [NSLayoutConstraint],
    _ variadicComponents: NSLayoutConstraint...
  ) -> [NSLayoutConstraint] {
    components + variadicComponents
  }

  public static func buildBlock(_ components: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    components
  }

  public static func buildOptional(_ component: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
    component ?? []
  }

  public static func buildEither(first component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    component
  }

  public static func buildEither(second component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    component
  }
}

public extension UIView {
  func layout(@LayoutBuilder using block: (LayoutProxy) -> [NSLayoutConstraint]) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(block(LayoutProxy(view: self)))
  }
}

#endif
