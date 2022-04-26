
# Common
if (MSVC)
    add_compile_options(/W4)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    add_compile_options(/wd4127) # disabled warning: C4127: conditional expression is constant
else()
    add_compile_options(-Wall -Wextra ) #-Wconversion
endif()

# Target
function(target_no_warning TARGET WNAME)

    # message(STATUS "target_no_warning TARGET: ${TARGET} WNAME: ${WNAME}" )

    set(MSVC_Warning)
    set(GCC_Warning ${WNAME})
    set(CLANG_Warning ${WNAME})

    if (WNAME STREQUAL "-Wno-multichar")
        set(MSVC_Warning )
    elseif(WNAME STREQUAL "-Wimplicit-fallthrough=0")
        set(CLANG_Warning "-Wno-implicit-fallthrough")
    elseif(WNAME STREQUAL "-Wno-unused-parameter")
        set(MSVC_Warning /wd4100)
    elseif(WNAME STREQUAL "-Wno-unused-variable")
        set(MSVC_Warning /wd4101)
    elseif(WNAME STREQUAL "-Wunused-const-variable=0")

    elseif(WNAME STREQUAL "-Wno-type-limits")

    elseif(WNAME STREQUAL "-Wno-unknown-pragmas")

    elseif(WNAME STREQUAL "-Wno-uninitialized")
        set(MSVC_Warning /wd4701 /wd4703)
    elseif(WNAME STREQUAL "-Wno-float-conversion")
        set(MSVC_Warning /wd4244)
    elseif(WNAME STREQUAL "-Wno-deprecated")
        set(MSVC_Warning /wd4996)
    elseif(WNAME STREQUAL "-Wno-conversion")
        set(MSVC_Warning /wd4244 /wd4267 /wd4245)
    elseif(WNAME STREQUAL "-Wno-cast-function-type")
        unset(CLANG_Warning)
    elseif(WNAME STREQUAL "-Wno-array-bounds")
    elseif(WNAME STREQUAL "-Wno-shift-negative-value")
    elseif(WNAME STREQUAL "-Wno-implicit-fallthrough")
    elseif(WNAME STREQUAL "-Wno-empty-body")
    elseif(WNAME STREQUAL "-Wno-attributes")
    elseif(WNAME STREQUAL "-Wno-absolute-value")
    elseif(WNAME STREQUAL "-Wno-tautological-pointer-compare")

    elseif(WNAME STREQUAL "-w")
        set(MSVC_Warning /w)

    # Only MSVC warnings
    elseif(WNAME STREQUAL "-WMSVC-no-translation-unit-is-empty")
        unset(GCC_Warning)
        unset(CLANG_Warning)
        set(MSVC_Warning /wd4206)
    elseif(WNAME STREQUAL "-WMSVC-no-nonstandard-extension-used")
        unset(GCC_Warning)
        unset(CLANG_Warning)
        set(MSVC_Warning /wd4201)
    elseif(WNAME STREQUAL "-WMSVC-no-assignment-within-conditional-expression")
        unset(GCC_Warning)
        unset(CLANG_Warning)
        set(MSVC_Warning /wd4706)
    elseif(WNAME STREQUAL "-WMSVC-no-hides-previous")
        unset(GCC_Warning)
        unset(CLANG_Warning)
        set(MSVC_Warning /wd4456 /wd4456 /wd4457)
    elseif(WNAME STREQUAL "-WMSVC-no-undefined-assuming-extern") # warning: C4013: 'read' undefined; assuming extern returning int
        unset(GCC_Warning)
        unset(CLANG_Warning)
        set(MSVC_Warning /wd4013)
    elseif(WNAME STREQUAL "-WMSVC-named-type-definition-in-parentheses")
        unset(GCC_Warning)
        unset(CLANG_Warning)
        set(MSVC_Warning /wd4115)
    else()
        message(WARNING "Unknown warning: ${WNAME}, please add this warning to ${CMAKE_CURRENT_LIST_DIR}/SetupCompileWarnings.cmake")
    endif()

    if (CC_IS_MSVC)
        target_compile_options(${TARGET} PRIVATE ${MSVC_Warning})
    elseif(CC_IS_CLANG)
        target_compile_options(${TARGET} PRIVATE ${CLANG_Warning})
    else()
        target_compile_options(${TARGET} PRIVATE ${GCC_Warning})
    endif()

endfunction()
