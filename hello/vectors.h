// стандартный набор векторов для Cortex-M3

void Reset_Handler(void);     /* Reset Handler */
void NMI_Handler(void);       /* NMI Handler */
void HardFault_Handler(void); /* Hard Fault Handler */
void MemManage_Handler(void); /* MPU Fault Handler */
void BusFault_Handler(void);  /* Bus Fault Handler */
void UsageFault_Handler(void);/* Usage Fault Handler */
void SVC_Handler(void);       /* SVCall Handler */
void DebugMon_Handler(void);  /* Debug Monitor Handler */
void PendSV_Handler(void);    /* PendSV Handler */
void SysTick_Handler(void);   /* SysTick Handler */

extern void _stack_top;		// глобальный указатель на вершину стека
							// задан в скрипте линкера
