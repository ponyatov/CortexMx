void SysTickHandler(void) {
	static BitAction toggle = Bit_SET;

	GPIO_WriteBit(GPIOB, GPIO_Pin_15, toggle);
	if (toggle == Bit_SET) {
		toggle = Bit_RESET;
	} else {
		toggle = Bit_SET;
	}
}
