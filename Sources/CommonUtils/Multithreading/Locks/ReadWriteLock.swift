//
// Created by Alexander Lakhonin on 08.12.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public protocol RWLock {
  func readLock()
  func writeLock()
  func unlock()
}

public final class ReadWriteLock: RWLock {
  private var readWriteLock: pthread_rwlock_t

  // MARK: - Methods

  public init() {
    readWriteLock = pthread_rwlock_t()
  }

  deinit {
    pthread_rwlock_destroy(&readWriteLock)
  }

  public func readLock() {
    pthread_rwlock_rdlock(&readWriteLock)
  }

  public func writeLock() {
    pthread_rwlock_wrlock(&readWriteLock)
  }

  public func unlock() {
    pthread_rwlock_unlock(&readWriteLock)
  }
}
