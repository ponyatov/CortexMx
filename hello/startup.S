// универсальный стартовый код для любых Cortex-Mx микроконтроллеров
// этот стартовый код должен быть слинкован на начало ПЗУ,
// которое не обязательно начинается с нулевого адреса

.thumb	// Cortex-M умеет только Thumb режим

.section ".vectors"
.func _vectors
.global _vectors
_vectors:	// таблица векторов прерываний/исключений Cortex-M
// используется команда относительного перехода,
// т.к. она корректно работает при стартовом ремапинге памяти
	.word _stack_top	// Initial SP  значение указателя стека после сброса
	.word _reset		// Reset                 // Сброс
	.word _dummy		// NMI
	.word _dummy		// Hard fault
	.word _dummy		// Memory management fault
	.word _dummy		// Bus fault
	.word _dummy		// Usage fault
	.word _dummy		// r
	.word _dummy		// r
	.word _dummy		// r
	.word _dummy		// r
	.word _dummy		// SVCall
	.word _dummy		// Reserved for Debug
	.word _dummy		// r
	.word _dummy		// PendSV
	.word _dummy		// Systick
	.word _dummy		// IRQ0
	.word _dummy		// IRQ1
	.word _dummy		// IRQ2
	.word _dummy		// IRQ3
	.word _dummy		// IRQ4
	.word _dummy		// IRQ5
	.word _dummy		// IRQ6
	.word _dummy		// IRQ7
.endfunc

// строка копирайта, конец дополняется до границы машинного слова
.section ".copyright"
.func _C_startup
.global _C_startup
_C_startup:
.string "startup.asm (c) Azbuka ARMaturschika"
.align 4
.endfunc

.text	// сегмент кода

// сюда передается управление при сбросе
.thumb_func
_reset:
//	LDR SP,=_stack_top
	B .

// обработчик-заглушка
.thumb_func
_dummy:
	B .

//.data
//.word 0x12345678,1234

//.bss
//.comm buf,0x10,10

.end
