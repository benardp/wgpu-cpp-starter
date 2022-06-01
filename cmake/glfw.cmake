include(FetchContent)
FetchContent_Declare(ext_glfw
  GIT_REPOSITORY https://github.com/glfw/glfw.git
  GIT_TAG        3.3.7
  GIT_SHALLOW    TRUE
)

set(GLFW_BUILD_EXAMPLES OFF CACHE INTERNAL "Turn off examples")
set(GLFW_BUILD_TESTS OFF CACHE INTERNAL "Turn off tests")
set(GLFW_BUILD_DOCS OFF CACHE INTERNAL "Turn off docs")

FetchContent_MakeAvailable(ext_glfw)