//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public struct WeakBox<A: AnyObject> {
  private weak var _value: A?

  public var value: A? {
    _value
  }

  public init(_ value: A) {
    _value = value
  }
}
