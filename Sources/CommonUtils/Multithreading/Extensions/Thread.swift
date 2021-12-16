//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public extension Thread {
  @inline(__always)
  static func assertIsMain() {
    assert(isMainThread, "Execution in background thread")
  }

  @inline(__always)
  static func assertIsBackground() {
    assert(!isMainThread, "Execution in main thread")
  }
}
