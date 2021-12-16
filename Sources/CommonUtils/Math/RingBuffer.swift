//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public struct RingBuffer<Value> {
  public var underlyingBuffer: [Value] {
    buffer
  }

  public var nextWriteIndex: Int {
    writeIndex
  }

  public var capacity: Int {
    didSet {
      buffer.reserveCapacity(capacity)
    }
  }

  private var buffer: [Value] = [] {
    didSet {
      assert(buffer.count <= capacity, "Ring buffer bigger than capacity")
    }
  }

  private var writeIndex: Int = 0 {
    didSet {
      if writeIndex >= capacity {
        writeIndex = 0
      }
    }
  }

  // MARK: - Methods

  public init(capacity: Int) {
    self.capacity = capacity
    buffer.reserveCapacity(capacity)
  }

  public mutating func write(_ value: Value) {
    if buffer.count < capacity {
      buffer.append(value)
    } else {
      buffer[writeIndex] = value
    }
    writeIndex += 1
  }
}
