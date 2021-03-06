// ������������� ��������� ��� ��� ����� Cortex-Mx �����������������
// ���� ��������� ��� ������ ���� ��������� �� ������ ���,
// ������� �� ����������� ���������� � �������� ������

.thumb	// Cortex-M ����� ������ Thumb �����

.section ".vectors"
.func _vectors
.global _vectors
_vectors:	// ������� �������� ����������/���������� Cortex-M
// ������������ ������� �������������� ��������,
// �.�. ��� ��������� �������� ��� ��������� ��������� ������
	.word _stack_top	// Initial SP  �������� ��������� ����� ����� ������
	.word _reset		// Reset                 // �����
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

// ������ ���������, ����� ����������� �� ������� ��������� �����
.section ".copyright"
.func _C_startup
.global _C_startup
_C_startup:
.string "startup.asm (c) Azbuka ARMaturschika"
.align 4
.endfunc

.text	// ������� ����

// ���� ���������� ���������� ��� ������
.thumb_func
_reset:
//	LDR SP,=_stack_top
	B .

// ����������-��������
.thumb_func
_dummy:
	B .

//.data
//.word 0x12345678,1234

//.bss
//.comm buf,0x10,10

.end
