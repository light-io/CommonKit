//
// Created by Alexander Lakhonin on 17.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Combine

public final class CancellableBag {
  fileprivate var subscriptions: Set<AnyCancellable> = []

  // MARK: - Methods

  public init() { }

  public func cancellAll() {
    subscriptions.removeAll()
  }
}

public extension AnyCancellable {
  func store(in cancellableBag: CancellableBag) {
    cancellableBag.subscriptions.insert(self)
  }
}
