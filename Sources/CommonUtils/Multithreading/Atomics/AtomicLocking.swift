//
// Created by Alexander Lakhonin on 08.12.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

@propertyWrapper
public final class AtomicLocking<Value> {

  public var projectedValue: AtomicLocking<Value> { self }

  public var wrappedValue: Value {
    get {
      lock.readLock()
      let value = self.value
      lock.unlock()
      return value
    }
    set {
      lock.writeLock()
      value = newValue
      lock.unlock()
    }
  }

  private let lock: RWLock
  private var value: Value

  // MARK: - Methods

  public init(wrappedValue: Value) {
    value = wrappedValue
    lock = ReadWriteLock()
  }

  public func mutate(_ transform: @escaping (inout Value) -> Void) {
    lock.readLock()
    transform(&value)
    lock.unlock()
  }
}
