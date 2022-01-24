//
// Created by Alexander Lakhonin on 24.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

import MetalKit

public extension MTLComputePipelineState {
  ///
  /// Threads per threadgroup, or threadgroup size.
  ///
  var threadgroupSize: MTLSize {
    MTLSizeMake(threadExecutionWidth, maxTotalThreadsPerThreadgroup / threadExecutionWidth, 1)
  }

  ///
  /// Calculate number of threadgroups per grid.
  /// - Note: Avaliable on device which does not support non-uniform threadgroup sizes.
  ///
  func calculateThreadgroupsPerGrid(for texture: MTLTexture) -> MTLSize {
    MTLSize(
      width: Int(ceil(Float(texture.width) / Float(threadgroupSize.width))),
      height: Int(ceil(Float(texture.height) / Float(threadgroupSize.height))),
      depth: 1
    )
  }

  ///
  /// Calculate number of threads per grid.
  /// - Note: Avaliable only on device which supports non-uniform threadgroup sizes.
  ///
  func calculateThreadsPerGrid(for texture: MTLTexture) -> MTLSize {
    MTLSize(width: texture.width, height: texture.height, depth: 1)
  }
}
