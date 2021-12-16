//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public struct MAQueue<Value: FloatingPoint> {
  public var avg: Value {
    sum / Value(count)
  }

  private var buffer: RingBuffer<Value>
  private var windowSize: Int
  private var sum: Value = 0

  private var count: Int {
    buffer.underlyingBuffer.count < windowSize ? buffer.underlyingBuffer.count : windowSize
  }

  // MARK: - Methods

  public init(windowSize: Int) {
    self.windowSize = windowSize
    buffer = RingBuffer<Value>(capacity: windowSize)
  }

  public mutating func add(_ value: Value) {
    if buffer.underlyingBuffer.count == windowSize {
      sum -= buffer.underlyingBuffer[buffer.nextWriteIndex]
    }
    sum += value
    buffer.write(value)
  }

  public mutating func set(windowSize: Int) {
    self.windowSize = windowSize
    buffer.capacity = windowSize
  }
}
