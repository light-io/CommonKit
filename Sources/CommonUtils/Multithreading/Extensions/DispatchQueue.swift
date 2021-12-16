//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public enum DispatchQueueType {
  case serial
  case concurrent
}

public extension DispatchQueue {
  /// Convenience initializer for dispatch queue
  /// - Parameters:
  ///   - name: queue name
  ///   - type: DispatchQueueType, serial or concurrent
  ///   - qos: DispatchQoS
  convenience init(_ name: String, type: DispatchQueueType, qos: DispatchQoS = .default) {
    switch type {
    case .serial:
      self.init(label: name, qos: qos)
    case .concurrent:
      self.init(label: name, qos: qos, attributes: .concurrent)
    }
  }
}
