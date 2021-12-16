//
// Created by Alexander Lakhonin on 09.12.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

public extension String {
  func toDispatchData() -> DispatchData? {
    guard let stringData = data(using: .unicode) else {
      return nil
    }
    let dispatchData = withUnsafeBytes(of: stringData) { (ptr: UnsafeRawBufferPointer) in
      DispatchData(bytes: UnsafeRawBufferPointer(start: ptr.baseAddress, count: stringData.count))
    }
    return dispatchData
  }
}
