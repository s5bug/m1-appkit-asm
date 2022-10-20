cmake_minimum_required(VERSION 3.23)
project(m1_appkit_asm ASM)

add_executable(m1_appkit_asm
        src/app_delegate.s
        src/main.s)

set_target_properties(m1_appkit_asm PROPERTIES
        MACOSX_BUNDLE TRUE)

target_link_libraries(m1_appkit_asm
        objc)
