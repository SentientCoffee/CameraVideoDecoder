print("Building external dependencies...")
project "Externals"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"

    staticruntime "on"

    targetdir "Build/bin/%{cfg.architecture}/%{cfg.buildcfg}"
    objdir "Build/obj/%{cfg.architecture}/%{cfg.buildcfg}"

    warnings "default"

    includedirs {
        "glad/include",
        "glfw3/include",
        -- "imgui/include/imgui",
        "opencv/Install/opencv/include",
        -- "stb/include/stb"
    }

    files {
        "glad/include/KHR/khrplatform.h",
        "glad/include/glad/glad.h",
        "glad/src/glad.c",

        "glfw3/include/glfw/glfw3.h",
        "glfw3/include/glfw/glfw3native.h",
        "glfw3/src/glfw_config.h",
        "glfw3/src/context.c",
        "glfw3/src/init.c",
        "glfw3/src/input.c",
        "glfw3/src/monitor.c",
        "glfw3/src/vulkan.c",
        "glfw3/src/window.c",
    }

    filter "system:windows"
        systemversion "latest"

        files {
            "glfw3/src/win32_init.c",
            "glfw3/src/win32_joystick.c",
            "glfw3/src/win32_monitor.c",
            "glfw3/src/win32_time.c",
            "glfw3/src/win32_thread.c",
            "glfw3/src/win32_window.c",
            "glfw3/src/wgl_context.c",
            "glfw3/src/egl_context.c",
            "glfw3/src/osmesa_context.c"
        }

        defines {
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS",
        }

    filter "configurations:Debug"
        defines {
            "_DEBUG",
            "FT_DEBUG_LEVEL_ERROR",
            "FT_DEBUG_LEVEL_TRACE"
        }

        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines { "NDEBUG" }
        runtime "Release"
        optimize "on"

    filter "configurations:Distribution"
        defines { "NDEBUG" }
        runtime "Release"
        optimize "on"