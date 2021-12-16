//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public struct WeakCollection<Element: AnyObject> {
  private var items: [WeakBox<Element>] = []

  public init(_ elements: [Element]) {
    items = elements.map { WeakBox($0) }
  }

  public mutating func append(_ element: Element) {
    items.append(WeakBox(element))
  }

  public mutating func flush() {
    items.removeAll(where: { $0.value == nil })
  }
}

extension WeakCollection: Collection {
  public var startIndex: Int { items.startIndex }
  public var endIndex: Int { items.endIndex }

  public subscript(_ index: Int) -> Element? {
    items[index].value
  }

  public func index(after idx: Int) -> Int {
    items.index(after: idx)
  }
}

extension WeakCollection: ExpressibleByArrayLiteral {
  public init(arrayLiteral: Element...) {
    self.init(arrayLiteral)
  }
}
