//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public extension Array {
  subscript(safe index: Int) -> Element? {
    get {
      indices ~= index ? self[index] : nil
    }
    set {
      guard indices ~= index, let newValue = newValue else { return }
      self[index] = newValue
    }
  }
}
