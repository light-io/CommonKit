//
// Created by Alexander Lakhonin on 15.10.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation
import simd

public typealias Float2 = SIMD2<Float>
public typealias Float3 = SIMD3<Float>
public typealias Float4 = SIMD4<Float>

public extension Float {
  var radiansToDegrees: Float {
    (self / Float.pi) * 180
  }

  var degreesToRadians: Float {
    (self / 180) * Float.pi
  }
}

public extension float4x4 {
  static func identity() -> float4x4 {
    matrix_identity_float4x4
  }

  init(translation: Float3) {
    self.init(
      [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [translation.x, translation.y, translation.z, 1]
    )
  }

  init(scaling: Float3) {
    self.init(
      [scaling.x, 0, 0, 0],
      [0, scaling.y, 0, 0],
      [0, 0, scaling.z, 0],
      [0, 0, 0, 1]
    )
  }

  // MARK: - Rotate

  /// Rotate around X axis.
  /// - Parameter angle: Angle in radians.
  init(rotationX angle: Float) {
    self.init(
      [1, 0, 0, 0],
      [0, cos(angle), sin(angle), 0],
      [0, -sin(angle), cos(angle), 0],
      [0, 0, 0, 1]
    )
  }

  /// Rotate around Y axis.
  /// - Parameter angle: Angle in radians.
  init(rotationY angle: Float) {
    self.init(
      [cos(angle), 0, -sin(angle), 0],
      [0, 1, 0, 0],
      [sin(angle), 0, cos(angle), 0],
      [0, 0, 0, 1]
    )
  }

  /// Rotate around Z axis.
  /// - Parameter angle: Angle in radians.
  init(rotationZ angle: Float) {
    self.init(
      [ cos(angle), sin(angle), 0, 0],
      [-sin(angle), cos(angle), 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1]
    )
  }

  init(projectionFov fov: Float, near: Float, far: Float, aspect: Float, lhs: Bool = true) {
    let y = 1 / tan(fov * 0.5)
    let x = y / aspect
    let z = lhs ? far / (far - near) : far / (near - far)
    let X = Float4(x, 0, 0, 0)
    let Y = Float4(0, y, 0, 0)
    let Z = lhs ? Float4(0, 0, z, 1) : Float4(0, 0, z, -1)
    let W = lhs ? Float4(0, 0, z * -near, 0) : Float4(0, 0, z * near, 0)
    self.init()
    columns = (X, Y, Z, W)
  }

  init(rotation angle: Float3) {
    let rotationX = float4x4(rotationX: angle.x)
    let rotationY = float4x4(rotationY: angle.y)
    let rotationZ = float4x4(rotationZ: angle.z)
    self = rotationX * rotationY * rotationZ
  }

  init(rotationYXZ angle: Float3) {
    let rotationX = float4x4(rotationX: angle.x)
    let rotationY = float4x4(rotationY: angle.y)
    let rotationZ = float4x4(rotationZ: angle.z)
    self = rotationY * rotationX * rotationZ
  }

  // MARK:- Upper left 3x3
  var upperLeft: float3x3 {
    let x = columns.0.xyz
    let y = columns.1.xyz
    let z = columns.2.xyz
    return float3x3(columns: (x, y, z))
  }
}

// MARK:- float4
public extension Float4 {
  var xyz: Float3 {
    get {
      Float3(x, y, z)
    }
    set {
      x = newValue.x
      y = newValue.y
      z = newValue.z
    }
  }

  // convert from double4
  init(_ d: SIMD4<Double>) {
    self.init()
    self = [Float(d.x), Float(d.y), Float(d.z), Float(d.w)]
  }
}
