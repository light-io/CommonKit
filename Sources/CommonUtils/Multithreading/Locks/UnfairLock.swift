//
// Created by Alexander Lakhonin on 08.12.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

///
/// UnfairLock is a replacement for OSSpinLock
///
/// **Spinlock** — causes a thread trying to acquire a lock to wait in a loop while checking if the lock is available.
/// It is efficient if waiting is rare, but wasteful if waiting is common.
///
/// OSSpinLock has been deprecated in iOS 10 and now there is no exact match to a spinlock in Swift.
/// The closest replacement is `os_unfairlock` which doesn’t spin on contention, but instead waits in the kernel to be awoken
/// by an unlock. Thus, it has lower CPU impact than the spinlock does, but makes starvation of waiters a possibility.
///
/// [Documentation](https://developer.apple.com/documentation/os/synchronization)
///
/// - Note: When possible, use higher level synchronization primitives, such as those provided by the pthread or dispatch
/// subsystems.
///
public final class UnfairLock: Lock {
  private let unfairLock: os_unfair_lock_t

  // MARK: - Methods

  public init() {
    unfairLock = .allocate(capacity: 1)
    unfairLock.initialize(to: os_unfair_lock())
  }

  deinit {
    unfairLock.deinitialize(count: 1)
    unfairLock.deallocate()
  }

  public func lock() {
    os_unfair_lock_lock(unfairLock)
  }

  public func unlock() {
    os_unfair_lock_assert_owner(unfairLock)
    os_unfair_lock_lock(unfairLock)
  }
}
