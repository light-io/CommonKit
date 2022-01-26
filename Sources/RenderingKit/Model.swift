//
// Created by Alexander Lakhonin on 26.01.2022.
// Copyright © 2022 Alexander Lakhonin. All right reserved.
//

import MetalKit

open class Model: Node {
  public let pipelineState: MTLRenderPipelineState
  public let meshes: [MTKMesh]

  // MARK: - Methods

  public init(pipelineState: MTLRenderPipelineState, meshes: [MTKMesh]) {
    self.pipelineState = pipelineState
    self.meshes = meshes
  }

  open func draw(using renderEncoder: MTLRenderCommandEncoder) {
    renderEncoder.setRenderPipelineState(pipelineState)
    for mesh in meshes {
      let vertexBuffer = mesh.vertexBuffers[0].buffer
      renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)

      for submesh in mesh.submeshes {
        renderEncoder.drawIndexedPrimitives(
          type: .triangle,
          indexCount: submesh.indexCount,
          indexType: submesh.indexType,
          indexBuffer: submesh.indexBuffer.buffer,
          indexBufferOffset:  submesh.indexBuffer.offset)
      }
    }
  }
}
