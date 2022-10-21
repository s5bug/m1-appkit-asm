; libSystem.exit
;     (status : int / i32 {x0})
;     -> nothing
.extern _exit

; libobjc.objc_getClass
;     (name : *const char / *u8 {x0})
;     -> id {x0}
.extern _objc_getClass
; libobjc.objc_msgSend
;     (self : id / * {x0}, op : SEL / * {x1}, ???...)
;     ->  ???
.extern _objc_msgSend
; libobjc.sel_getUid
;     (str : *const char / *u8 {x0})
;     -> SEL {x0}
.extern _sel_getUid

.text
.align 4
run:
    ; begin
    sub sp, sp, #16
    stp x19, lr, [sp]

    ; x19 = clazz_NSApplication
    adrp x0, str_NSApplication@PAGE
    add x0, x0, str_NSApplication@PAGEOFF
    bl _objc_getClass
    mov x19, x0
    ; op = sel_sharedApplication
    adrp x0, str_sharedApplication@PAGE
    add x0, x0, str_sharedApplication@PAGEOFF
    bl _sel_getUid
    mov x1, x0
    ; self = x19
    mov x0, x19
    bl _objc_msgSend
    ; x19 = app
    mov x19, x0

    ; end
    ldp x19, lr, [sp]
    add sp, sp, #16
    ret

.global _main
_main:
    bl asm_app_delegate_create
    bl run

    ; status = 0
    mov x0, #0
    bl _exit

.data
.align 8
str_NSApplication:
    .ascii "NSApplication"
    .byte 0

str_sharedApplication:
    .ascii "sharedApplication"
    .byte 0

str_run:
    .ascii "run"
    .byte 0
