//
// Created by Alexander Lakhonin on 05.10.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

@propertyWrapper
public final class Atomic<Value> {
  public var projectedValue: Atomic<Value> { self }

  public var wrappedValue: Value {
    get {
      queue.sync { value }
    }
    set {
      queue.async(flags: .barrier) { [weak self] in self?.value = newValue }
    }
  }

  private let queue: DispatchQueue
  private var value: Value

  // MARK: - Methods

  public init(wrappedValue: Value) {
    value = wrappedValue
    queue = DispatchQueue("com.atomic_queue_for_\(Value.self)", type: .concurrent)
  }

  public func mutate(_ transform: @escaping (inout Value) -> Void) {
    queue.async(flags: .barrier) { transform(&self.value) }
  }
}
