#pragma once

#include <memory>
#include <GLFW/glfw3.h>
#include <dawn/webgpu_cpp.h>

namespace metal {

// TODO: Could do the same for D3D12 and Vulkan, quite similar setup to ChameleonRT
struct Context;

std::shared_ptr<Context> make_context(GLFWwindow *window);

wgpu::SurfaceDescriptorFromMetalLayer surface_descriptor(std::shared_ptr<Context> &context);

}
