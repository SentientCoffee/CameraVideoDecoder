print("Building project \"VideoDecoder\"...")
print("")
project "VideoDecoder"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"

    staticruntime "on"

    targetdir "Build/bin/%{cfg.architecture}/%{cfg.buildcfg}"
    objdir "Build/obj/%{cfg.architecture}/%{cfg.buildcfg}"

    pchheader "vdpch.h"
	pchsource "src/vdpch.cpp"

    defines { "GLFW_INCLUDE_NONE" }

    flags { "FatalWarnings" }

    includedirs {
        "%{wks.location}/Externals/glad/include",
        "%{wks.location}/Externals/glfw3/include",
        -- "%{wks.location}/Externals/glm/include",
        -- "%{wks.location}/Externals/imgui/include",
        "%{wks.location}/Externals/opencv/Install/opencv/include",
        "%{wks.location}/Externals/spdlog/include",
        -- "%{wks.location}/Externals/stb/include",
        
        "include"
    }

    libdirs {
        "%{wks.location}/Externals/opencv/Install/opencv/x64/vc16/**"
    }

    links {
        "Externals",
        "opengl32"
    }

    files {
        "include/**.h",
        "include/**.hpp",
        "include/**.inl",
        "src/**.cpp"
    }

    filter "system:windows"
        systemversion "latest"
        defines {
            "PLATFORM_WINDOWS"
        }

    filter "system:linux"
        systemversion "latest"
        defines {
            "PLATFORM_LINUX"
        }

    filter "configurations:Debug"
        defines {
            "_DEBUG=1",
            "_RELEASE=0",
            "_DIST=0",
            "_ENABLE_ASSERTS=1"
        }

        runtime "Debug"
        symbols "on"

        links {
            "IlmImfd",
            "ippicvmt",
            "ippiwd",
            "ittnotifyd",
            "libjasperd",
            "libjpeg-turbod",
            "libpngd",
            "libprotobufd",
            "libtiffd",
            "libwebpd",
            "quircd",
            "zlibd",

            "opencv_calib3d440d",
            "opencv_core440d",
            "opencv_features2d440d",
            "opencv_flann440d",
            "opencv_highgui440d",
            "opencv_imgcodecs440d",
            "opencv_imgproc440d",
            "opencv_ml440d",
            "opencv_objdetect440d",
            "opencv_photo440d",
            "opencv_shape440d",
            "opencv_stitching440d",
            "opencv_superres440d",
            "opencv_video440d",
            "opencv_videoio440d",
            "opencv_videostab440d"
        }

    filter "configurations:Release"
        defines {
            "_DEBUG=0",
            "_RELEASE=1",
            "_DIST=0",
            "_ENABLE_ASSERTS=0"
        }
        runtime "Release"
        optimize "on"
        
        links {
            "IlmImf",
            "ippicvmt",
            "ippiw",
            "ittnotify",
            "libjasper",
            "libjpeg-turbo",
            "libpng",
            "libprotobuf",
            "libtiff",
            "libwebp",
            "quirc",
            "zlib",

            "opencv_calib3d440",
            "opencv_core440",
            "opencv_features2d440",
            "opencv_flann440",
            "opencv_highgui440",
            "opencv_imgcodecs440",
            "opencv_imgproc440",
            "opencv_ml440",
            "opencv_objdetect440",
            "opencv_photo440",
            "opencv_shape440",
            "opencv_stitching440",
            "opencv_superres440",
            "opencv_video440",
            "opencv_videoio440",
            "opencv_videostab440"
        }

    filter "configurations:Distribution"
        defines {
            "_DEBUG=0",
            "_RELEASE=0",
            "_DIST=1",
            "_ENABLE_ASSERTS=0"
        }

        runtime "Release"
        optimize "on"

        links {
            "IlmImf",
            "ippicvmt",
            "ippiw",
            "ittnotify",
            "libjasper",
            "libjpeg-turbo",
            "libpng",
            "libprotobuf",
            "libtiff",
            "libwebp",
            "quirc",
            "zlib",

            "opencv_calib3d440",
            "opencv_core440",
            "opencv_features2d440",
            "opencv_flann440",
            "opencv_highgui440",
            "opencv_imgcodecs440",
            "opencv_imgproc440",
            "opencv_ml440",
            "opencv_objdetect440",
            "opencv_photo440",
            "opencv_shape440",
            "opencv_stitching440",
            "opencv_superres440",
            "opencv_video440",
            "opencv_videoio440",
            "opencv_videostab440"
        }