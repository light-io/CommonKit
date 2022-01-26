//
// Created by Alexander Lakhonin on 26.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

import MetalKit
import CommonUtils

open class Node {
  public var name: String = "untitled"
  public var position: Float3 = [0, 0, 0]
  public var rotation: Float3 = [0, 0, 0]
  public var scale: Float3 = [1, 1, 1]

  open var modelMatrix: float4x4 {
    let translateMatrix = float4x4(translation: position)
    let rotateMatrix = float4x4(rotation: rotation)
    let scaleMatrix = float4x4(scaling: scale)
    return translateMatrix * rotateMatrix * scaleMatrix
  }
}
