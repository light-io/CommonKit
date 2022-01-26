//
// Created by Alexander Lakhonin on 26.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

import MetalKit
import CommonUtils

open class Camera: Node {
  public var fovDegrees: Float = 70
  public var aspect: Float = 1
  public var near: Float = 0.001
  public var far: Float = 100

  open var fovRadians: Float {
    return fovDegrees.degreesToRadians
  }

  open var projectionMatrix: float4x4 {
    return float4x4(
      projectionFov: fovRadians,
      near: near,
      far: far,
      aspect: aspect
    )
  }

  open var viewMatrix: float4x4 {
    let translateMatrix = float4x4(translation: position)
    let rotateMatrix = float4x4(rotation: rotation)
    let scaleMatrix = float4x4(scaling: scale)
    return (translateMatrix * scaleMatrix * rotateMatrix).inverse
  }

  open func zoom(delta: Float) {}
  open func rotate(delta: Float2) {}
}
