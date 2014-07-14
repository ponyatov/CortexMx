// универсальный стартовый код для любых ARM-микроконтроллеров
// скопипащен из руководства QuantumLeaps по использованию GNU toolchain

// этот стартовый код должен быть слинкован на начало ПЗУ,
// которое не обязательно начинается с нулевого адреса

.text // сегмент кода
.thumb // Cortex-M умеет только Thumb режим
//.code 32 // раскомментировать для ARM7TDMI (?)

.func _vector
.global _vector
_vector:	// таблица векторов прерываний/исключений
// используется команда относительного перехода,
// т.к. она корректно работает при стартовом ремапинге памяти
	.long _stack
	.long _reset+1
	B _reset	// Reset                 // Сброс
	B .			// Undefined Instruction // Неизвестная инструкция
	B .			// Software Interrupt    // Программное прерывание
	B .			// Prefetch Abort        // Сбой предвыборки
	B .			// Data Abort            // Сбой по данным
	B .			// Reserved              // зарезервировано
	B .			// IRQ                   // Прерывание
	B .			// FIQ                   // Быстрое прерывание
.endfunc

// строка копирайта, конец дополняется до границы машинного слова
.func _copyright
.global _copyright
_copyright:
.string "(c) Azbuka ARMaturschika"
.align 4
.endfunc

//.thumb_func
.func _reset
.global _reset
_reset:		// сюда передается управление при сбросе
//	LDR SP,=_stack_top
	B .
.endfunc

.data
.word 0x12345678,1234

.bss
.comm buf,0x10,10

.end
