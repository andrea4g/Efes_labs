#include <alt_stdio.h>
#include <sys/alt_timestamp.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>
 
#define BAUD_RATE 9600
#define NBIT 8
#define STOPBIT 1
#define NOPARITY 0
#define EVENPARITY 1
#define ODDPARITY 2
#define PARITY NOPARITY
#define read IORD_ALTERA_AVALON_PIO_DATA

int main(){
	/* Setup */
	int tps = alt_timestamp_freq();
	int tpb = tps / BAUD_RATE;
	int tphb = tpb/2;
	int tb = 1 + NBIT + (PARITY != 0 ? 1 : 0);
	int payload[NBIT];
	/* Loop */
	while (1){

		if(read(PIO_0_BASE) == 1) {
			/* UART_RX high */
		}
		else {
			/* UART_RX low */
			/* Start bit */
			alt_timestamp_start(void);
			while (alt_timestamp() < tphb);
			if(read(PIO_0_BASE) == 1){
				alt_putstr("Error 1!\n");
			}
			/* Payload */
			for	(int i = 0; i< NBIT; i++){
				alt_timestamp_start(void);
				while (alt_timestamp() < tpb);
				payload[i] = read(PIO_0_BASE);
			}
			/* Stop bit */
			while (alt_timestamp() < tpb);
			if(read(PIO_0_BASE) == 0){
				alt_putstr("Error 2!\n");
			}
			char c = 0;
			for(int i = 0; i < NBIT; i++){
				c += (payload[i] << i);
			}
			printf("%c",c);
		}
	}
	return 0;
}
 
