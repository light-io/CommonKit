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
}
