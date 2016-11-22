#include <sys/alt_stdio.h>
#include <sys/alt_timestamp.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>

#define BAUD_RATE 19200
#define NBIT 8
#define STOPBIT 1
#define NOPARITY 0
#define EVENPARITY 1
#define ODDPARITY 2
#define PARITY EVENPARITY

int read(int port){
	return IORD_ALTERA_AVALON_PIO_DATA(port) & 0x01;
}

void write(int port, int val){
	IOWR_ALTERA_AVALON_PIO_DATA(port, val);
}

char display_map[16] = {
		0x01,
		0x4f,
		0x12,
		0x06,
		0x4c,
		0x24,
		0x20,
		0x0f,
		0x00,
		0x04,
		0x08,
		0x60,
		0x31,
		0x42,
		0x30,
		0x38
};

int main(){
	/* Setup */
	int tps = alt_timestamp_freq();
	int tpb = tps / BAUD_RATE;
	int tphb = tpb/2;
	int payload[NBIT];
	int i;
	int parity;
	int even;

	/* Loop */
	while (1){
		if(read(PIO_0_BASE) == 1) {
			/* UART_RX high */
			// IDLE
			write(PIO_3_BASE, 0);
		} else {
			/* UART_RX low */
			/* Start bit */
			even = 0;
			write(PIO_3_BASE, 1);
			alt_timestamp_start();
			while (alt_timestamp() < tphb);
			if(read(PIO_0_BASE) == 1){
				alt_putstr("ERROR: start bit!\n");
			}
			/* Payload */
			for	(i = 0; i< NBIT; i++){
				alt_timestamp_start();
				while (alt_timestamp() < tpb);
				payload[i] = read(PIO_0_BASE);
				even ^= payload[i];
			}
			/* Parity */
			if(PARITY!=NOPARITY){
				alt_timestamp_start();
				while (alt_timestamp() < tpb);
				parity = read(PIO_0_BASE);
				if(PARITY == EVENPARITY && parity!=even){
					alt_putstr("ERROR: even parity check failed!\n");
				}
				if(PARITY == ODDPARITY && parity==even){
					alt_putstr("ERROR: odd parity check failed!\n");
				}
			}
			/* Stop bit */
			alt_timestamp_start();
			while (alt_timestamp() < tpb);
			if(read(PIO_0_BASE) == 0){
				alt_putstr("ERROR: stop bit!\n");
			}
			char c = 0;
			for(i = 0; i < NBIT; i++){
				c += (payload[i] << i);
			}
			alt_printf("%c\n",c);
			write(PIO_1_BASE, display_map[c & 0x0f]);
			write(PIO_2_BASE, display_map[c >> 4]);
		}
	}
	return 0;
}
