//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

@inline(__always)
public func asyncOnMain(execute work: @escaping () -> Void) {
  DispatchQueue.main.async(execute: work)
}

@inline(__always)
public func asyncOnMain(after deadline: DispatchTime, execute work: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: deadline, execute: work)
}
