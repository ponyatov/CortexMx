#include <stdint.h>

#include <stm32f10x_lib.h>

GPIO_InitTypeDef GPIOB_InitStruct = {
	.GPIO_Pin = GPIO_Pin_All,
	.GPIO_Speed = GPIO_Speed_2MHz,
	.GPIO_Mode = GPIO_Mode_Out_PP
};

int main() {
	ErrorStatus HSEStartUpStatus;
	RCC_ClocksTypeDef Clocks;

	/*
	 * Clock initialization
	 */
	RCC_HSEConfig(RCC_HSE_ON);
	HSEStartUpStatus = RCC_WaitForHSEStartUp();

	if (HSEStartUpStatus != SUCCESS) {
		while (1);
	}

	RCC_SYSCLKConfig(RCC_SYSCLKSource_HSE);
	RCC_HCLKConfig(RCC_SYSCLK_Div1);
	RCC_PCLK2Config(RCC_HCLK_Div1);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE);

	/*
	 * NVIC initialization
	 */
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_3);
	NVIC_SystemHandlerPriorityConfig(SystemHandler_SysTick, 7, 0);

	/*
	 * GPIOB initialization
	 */
	GPIO_Init(GPIOB, &GPIOB_InitStruct);
	GPIO_WriteBit(GPIOB, GPIO_Pin_All, Bit_RESET);

	/*
	 * SysTick initialization
	 */
	SysTick_CLKSourceConfig(SysTick_CLKSource_HCLK);

	RCC_GetClocksFreq(&Clocks);
	SysTick_SetReload((Clocks.HCLK_Frequency)/2);

	SysTick_ITConfig(ENABLE);
	SysTick_CounterCmd(SysTick_Counter_Enable);

	while(1);
}
