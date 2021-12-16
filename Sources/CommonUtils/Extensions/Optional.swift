//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public extension Optional {
  @inline(__always)
  var isNil: Bool {
    self == nil
  }

  @inline(__always)
  var isNotNil: Bool {
    self != nil
  }
}

public extension Optional where Wrapped: Collection {
  var isNilOrEmpty: Bool {
    self?.isEmpty ?? true
  }
}
