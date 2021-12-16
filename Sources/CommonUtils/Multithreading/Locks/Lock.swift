//
// Created by Alexander Lakhonin on 05.10.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public protocol Lock {
  func lock()

  ///
  /// - Warning: A lock must be unlocked only from the same thread in which it was locked.
  /// Attempting to unlock from a different thread causes a runtime error.
  ///
  func unlock()
}

public extension Lock {
  ///
  /// Executes a closure returning a value while acquiring the lock.
  ///
  /// - Parameter value: The closure to run.
  ///
  /// - Returns: The value the closure generated.
  ///
  func wrapping<T>(_ value: @autoclosure () -> T) -> T {
    lock()
    defer { unlock() }
    return value()
  }

  ///
  /// Execute a closure while acquiring the lock.
  ///
  /// - Parameter work: The closure to run.
  ///
  func wrapping(_ work: () -> Void) {
    lock()
    defer { unlock() }
    work()
  }
}

extension NSLock: Lock { }
