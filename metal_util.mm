#include "metal_util.h"
#include <stdexcept>
#include <string>
#include <Cocoa/Cocoa.h>
#include <Metal/Metal.h>
#include <QuartzCore/CAMetalLayer.h>

#define GLFW_EXPOSE_NATIVE_COCOA
#import <GLFW/glfw3native.h>

namespace metal {

struct Context {
    id<MTLDevice> device = nullptr;
    CAMetalLayer *layer = nullptr;

    Context(GLFWwindow *window);
    ~Context();

    std::string device_name() const;
};

Context::Context(GLFWwindow *window)
{
    // Take the first Metal device
    NSArray<id<MTLDevice>> *devices = MTLCopyAllDevices();
    if (!devices) {
        throw std::runtime_error("No Metal device found!");
    }
    device = devices[0];
    [device retain];
    [devices release];

    // Setup the Metal layer
    layer = [CAMetalLayer layer];
    layer.device = device;
    layer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    layer.framebufferOnly = NO;

    NSWindow* nswindow = glfwGetCocoaWindow(window);
    nswindow.contentView.layer = layer;
    nswindow.contentView.wantsLayer = YES;
}

Context::~Context()
{
    [device release];
}

std::string Context::device_name() const
{
    return [device.name UTF8String];
}

std::shared_ptr<Context> make_context(GLFWwindow *window)
{
    return std::make_shared<Context>(window);
}

wgpu::SurfaceDescriptorFromMetalLayer surface_descriptor(std::shared_ptr<Context> &context)
{
    wgpu::SurfaceDescriptorFromMetalLayer surf_desc;
    surf_desc.layer = context->layer;
    return surf_desc;
}
}
