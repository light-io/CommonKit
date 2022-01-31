//
// Created by Alexander Lakhonin on 26.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

import MetalKit
import CommonUtils

///
/// Arcball camera/orbit camera is a simple type of camera that rotates around a center point.
///
public final class ArcballCamera: Camera {
  public var minDistance: Float = 0.5
  public var maxDistance: Float = 10
  public var target: Float3 = [0, 0, 0] {
    didSet {
      _viewMatrix = updateViewMatrix()
    }
  }

  public var distance: Float = 0 {
    didSet {
      _viewMatrix = updateViewMatrix()
    }
  }

  public override var rotation: Float3 {
    didSet {
      _viewMatrix = updateViewMatrix()
    }
  }

  public override var viewMatrix: float4x4 {
    return _viewMatrix
  }

  private var _viewMatrix = float4x4.identity()

  public override init() {
    super.init()
    _viewMatrix = updateViewMatrix()
  }

  public override func zoom(delta: Float) {
    let sensitivity: Float = 0.05
    distance -= delta * sensitivity
    _viewMatrix = updateViewMatrix()
  }

  public override func rotate(delta: Float2) {
    let sensitivity: Float = 0.005
    rotation.y += delta.x * sensitivity
    rotation.x += delta.y * sensitivity
    rotation.x = max(-Float.pi/2, min(rotation.x, Float.pi/2))
    _viewMatrix = updateViewMatrix()
  }

  private func updateViewMatrix() -> float4x4 {
    let translateMatrix = float4x4(translation: [target.x, target.y, target.z - distance])
    let rotateMatrix = float4x4(rotationYXZ: [-rotation.x, rotation.y, 0])
    let matrix = (rotateMatrix * translateMatrix).inverse
    position = rotateMatrix.upperLeft * -matrix.columns.3.xyz
    return matrix
  }
}
