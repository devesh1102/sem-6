#include "i2s_setup.h"

/* Fore more information see SPRUFX4A - Section 1.2.14.1 */
void I2S2_setup(void)
{
    I2S2_SCTRL   = 0x0090; /* Set I2S2 in stereo mode, 16-bit, with data packing, slave */
	I2S2_INTMASK = 0x0000; /* Disable all I2S2 interrupts  */
}

void I2S2_enable(void)
{
	Uint16 register_value;
	
	/* Enable I2S0 */
	register_value = I2S2_SCTRL;
	I2S2_SCTRL = 0x8000 | register_value;
	
}
