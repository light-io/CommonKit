//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation
import Combine

public extension Publisher where Failure == Never {
  func weakAssign<T: AnyObject>(
    to keyPath: ReferenceWritableKeyPath<T, Output>,
    on object: T
  ) -> AnyCancellable {
    sink { [weak object] value in
      object?[keyPath: keyPath] = value
    }
  }
}
