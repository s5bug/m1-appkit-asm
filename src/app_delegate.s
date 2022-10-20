; libobjc.class_addMethod
;     (cls : Class / * {x0}, name : SEL / * {x1}, imp : IMP / * {x2}, types : *const char / *u8 {x3})
;     -> BOOL {x0}
.extern _class_addMethod
; libobjc.objc_allocateClassPair
;     (superclass : Class / * {x0}, name : *const char / *u8 {x1}, extraBytes : size_t / u64 {x2})
;     -> Class {x0}
.extern _objc_allocateClassPair
; libobjc.objc_lookUpClass
;     (name : *const char / *u8 {x0})
;     -> Class {x0}
.extern _objc_lookUpClass
; libobjc.objc_registerClassPair
;     (cls : Class / * {x0})
;     -> void/unit
.extern _objc_registerClassPair
; libobjc.sel_getUid
;     (str : *const char / *u8 {x0})
;     -> SEL {x0}
.extern _sel_getUid

.bss
.align 8
; clazz_asm_app_delegate : Class
.global clazz_AsmAppDelegate
clazz_AsmAppDelegate: .skip 8

.text
.align 4
; asm_app_delegate_create
;     ()
;     -> void/unit
.global asm_app_delegate_create
asm_app_delegate_create:
    ; begin
    sub sp, sp, #16
    str lr, [sp]

    ; name = &str_NSObject
    adrp x0, str_NSObject@PAGE
    add x0, x0, str_NSObject@PAGEOFF
    ; superclass = clazz_NSObject
    bl _objc_lookUpClass
    ; name = &str_AsmAppDelegate
    adrp x1, str_AsmAppDelegate@PAGE
    add x1, x1, str_AsmAppDelegate@PAGEOFF
    ; extraBytes = 0
    mov x2, #0
    bl _objc_allocateClassPair
    ; clazz_AsmAppDelegate = x0
    adrp x1, clazz_AsmAppDelegate@PAGE
    str x0, [x1, clazz_AsmAppDelegate@PAGEOFF]

    ; str = &str_applicationDidFinishLaunching
    adrp x0, str_applicationDidFinishLaunching@PAGE
    add x0, x0, str_applicationDidFinishLaunching@PAGEOFF
    bl _sel_getUid
    ; name = x0
    mov x1, x0
    ; cls = clazz_AsmAppDelegate
    adrp x0, clazz_AsmAppDelegate@PAGE
    ldr x0, [x0, clazz_AsmAppDelegate@PAGEOFF]
    ; imp = AsmAppDelegate_didFinishLaunching
    adrp x2, AsmAppDelegate_didFinishLaunching@PAGE
    add x2, x2, AsmAppDelegate_didFinishLaunching@PAGEOFF
    ; types = str_Sig$int$obj$sel$obj
    adrp x3, str_Sig$int$obj$sel$obj@PAGE
    add x3, x3, str_Sig$int$obj$sel$obj@PAGEOFF
    bl _class_addMethod

    ; cls = clazz_AsmAppDelegate
    adrp x0, clazz_AsmAppDelegate@PAGE
    ldr x0, [x0, clazz_AsmAppDelegate@PAGEOFF]
    bl _objc_registerClassPair

    ; end
    ldr lr, [sp]
    add sp, sp, #16
    ret

AsmAppDelegate_didFinishLaunching:
    ; x0 = YES
    mov x0, #1
    ret

.data
.align 8
str_AsmAppDelegate:
    .ascii "AsmAppDelegate"
    .byte 0

str_NSObject:
    .ascii "NSObject"
    .byte 0

str_applicationDidFinishLaunching:
    .ascii "applicationDidFinishLaunching:"
    .byte 0

str_Sig$int$obj$sel$obj:
    .ascii "i@:@"
    .byte 0
