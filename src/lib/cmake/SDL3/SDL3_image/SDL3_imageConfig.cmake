# sdl3_image cmake project-config input for CMakeLists.txt script

include(FeatureSummary)
set_package_properties(SDL3_image PROPERTIES
    URL "https://www.libsdl.org/projects/SDL_image/"
    DESCRIPTION "SDL_image is an image file loading library"
)

set(SDL3_image_FOUND ON)

set(SDLIMAGE_AVIF          TRUE)
set(SDLIMAGE_AVIF_SHARED   ON)
set(SDLIMAGE_BMP           TRUE)
set(SDLIMAGE_GIF           TRUE)
set(SDLIMAGE_JPG           TRUE)
set(SDLIMAGE_JPG_SHARED    OFF)
set(SDLIMAGE_JXL           FALSE)
set(SDLIMAGE_JXL_SHARED    OFF)
set(SDLIMAGE_LBM           TRUE)
set(SDLIMAGE_PCX           TRUE)
set(SDLIMAGE_PNG           TRUE)
set(SDLIMAGE_PNG_SHARED    OFF)
set(SDLIMAGE_PNM           TRUE)
set(SDLIMAGE_QOI           TRUE)
set(SDLIMAGE_SVG           TRUE)
set(SDLIMAGE_TGA           TRUE)
set(SDLIMAGE_TIF           TRUE)
set(SDLIMAGE_TIF_SHARED    ON)
set(SDLIMAGE_XCF           TRUE)
set(SDLIMAGE_XPM           TRUE)
set(SDLIMAGE_XV            TRUE)
set(SDLIMAGE_WEBP          TRUE)
set(SDLIMAGE_WEBP_SHARED   ON)

set(SDLIMAGE_JPG_SAVE ON)
set(SDLIMAGE_PNG_SAVE ON)

set(SDLIMAGE_VENDORED  OFF)

set(SDLIMAGE_BACKEND_IMAGEIO   OFF)
set(SDLIMAGE_BACKEND_STB       ON)
set(SDLIMAGE_BACKEND_WIC       OFF)

set(SDLIMAGE_SDL3_REQUIRED_VERSION  3.1.3)

set(SDL3_image_SDL3_image-shared_FOUND FALSE)
if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/SDL3_image-shared-targets.cmake")
    include("${CMAKE_CURRENT_LIST_DIR}/SDL3_image-shared-targets.cmake")
    set(SDL3_image_SDL3_image-shared_FOUND TRUE)
endif()

set(SDL3_image_SDL3_image-static_FOUND FALSE)
if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/SDL3_image-static-targets.cmake")

    if(SDLIMAGE_VENDORED)
        if(SDLIMAGE_AVIF AND NOT SDLIMAGE_AVIF_SHARED)
            find_package(Threads)
        endif()
        if(SDLIMAGE_JXL AND NOT SDLIMAGE_JXL_SHARED)
            include(CheckLanguage)
            check_language(CXX)
            if(NOT CMAKE_CXX_COMPILER AND NOT _sdl3image_nowarning)
                message(WARNING "CXX language not enabled. Linking to SDL3_image::SDL3_image-static might fail.")
            endif()
        endif()
        if(SDLIMAGE_TIF AND NOT SDLIMAGE_TIF_SHARED)
            if(NOT TARGET CMath::CMath)
                add_library(CMath::CMath INTERFACE IMPORTED)
                find_library(CMATH_LIBRARY NAMES m)
                if(CMATH_LIBRARY)
                    set_property(TARGET CMath::CMath PROPERTY INTERFACE_LINK_LIBRARIES "${CMAKE_LIBRARY}")
                endif()
            endif()
        endif()
        if(SDLIMAGE_WEBP AND NOT SDLIMAGE_WEBP_SHARED)
            find_package(Threads)
        endif()
    else()
        set(_sdl_cmake_module_path "${CMAKE_MODULE_PATH}")
        list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

        include(CMakeFindDependencyMacro)

        if(SDLIMAGE_AVIF AND NOT TARGET avif AND NOT SDLIMAGE_AVIF_SHARED)
            find_package(libavif 1.0 QUIET)
            if(NOT libavif_FOUND)
                find_package(libavif 1.0 QUIET)
            endif()
            if(NOT libavif_FOUND)
                set(SDL3_image_FOUND FALSE)
                return()
            endif()
        endif()

        if(SDLIMAGE_JPG AND NOT TARGET JPEG::JPEG AND NOT SDLIMAGE_JPG_SHARED AND NOT (SDLIMAGE_BACKEND_STB OR SDLIMAGE_BACKEND_WIC OR SDLIMAGE_BACKEND_IMAGEIO))
            find_dependency(JPEG)
        endif()

        if(SDLIMAGE_JXL AND NOT TARGET libjxl::libjxl)
            list(APPEND libjxl_ROOT "${CMAKE_CURRENT_LIST_DIR}")
            find_dependency(libjxl)
        endif()

        if(SDLIMAGE_PNG AND NOT TARGET PNG::PNG AND NOT SDLIMAGE_PNG_SHARED AND NOT (SDLIMAGE_BACKEND_STB OR SDLIMAGE_BACKEND_WIC OR SDLIMAGE_BACKEND_IMAGEIO))
            find_dependency(PNG)
        endif()

        if(SDLIMAGE_TIF AND NOT TARGET TIFF::TIFF AND NOT (SDLIMAGE_BACKEND_IMAGEIO OR SDLIMAGE_BACKEND_WIC))
            find_dependency(TIFF)
        endif()

        if(SDLIMAGE_WEBP AND NOT TARGET WebP::webp AND NOT SDLIMAGE_WEBP_SHARED)
            list(APPEND webp_ROOT "${CMAKE_CURRENT_LIST_DIR}")
            find_dependency(webp)
        endif()

        set(CMAKE_MODULE_PATH "${_sdl_cmake_module_path}")
        unset(_sdl_cmake_module_path)

    endif()

    include("${CMAKE_CURRENT_LIST_DIR}/SDL3_image-static-targets.cmake")
    set(SDL3_image_SDL3_image-static_FOUND TRUE)
endif()

function(_sdl_create_target_alias_compat NEW_TARGET TARGET)
    if(CMAKE_VERSION VERSION_LESS "3.18")
        # Aliasing local targets is not supported on CMake < 3.18, so make it global.
        add_library(${NEW_TARGET} INTERFACE IMPORTED)
        set_target_properties(${NEW_TARGET} PROPERTIES INTERFACE_LINK_LIBRARIES "${TARGET}")
    else()
        add_library(${NEW_TARGET} ALIAS ${TARGET})
    endif()
endfunction()

# Make sure SDL3_image::SDL3_image always exists
if(NOT TARGET SDL3_image::SDL3_image)
    if(TARGET SDL3_image::SDL3_image-shared)
        _sdl_create_target_alias_compat(SDL3_image::SDL3_image SDL3_image::SDL3_image-shared)
    elseif(TARGET SDL3_image::SDL3_image-static)
        _sdl_create_target_alias_compat(SDL3_image::SDL3_image SDL3_image::SDL3_image-static)
    endif()
endif()


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was SDL3_imageConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################
check_required_components(SDL3_image)
