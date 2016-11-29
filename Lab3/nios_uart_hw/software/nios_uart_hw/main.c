#include <sys/alt_stdio.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>

int read(int port){
	return IORD_ALTERA_AVALON_PIO_DATA(port) & 0x01;
}

void write(int port, int val){
	IOWR_ALTERA_AVALON_PIO_DATA(port, val);
}

int edge_read(int port){
	return IORD_ALTERA_AVALON_PIO_EDGE_CAP(port) & 0x01;
}

void edge_write(int port, int val){
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(port, val);
}

int main()
{ 
  write(PIO_1_BASE, 0x000A);
  write(PIO_0_BASE, 0x0A2B);
  edge_write(PIO_3_BASE, 1);

  alt_putstr("READY!\n");

  while (1){
	  if(edge_read(PIO_3_BASE)){
		  alt_printf("RX: ");
		  int payload = IORD_ALTERA_AVALON_PIO_DATA(PIO_2_BASE);
		  int i;
		  for(i=2; i< 11; i++){
			alt_printf("%i",payload%2);
			payload = payload >> 1;
		  }
		  alt_printf("\n");
		  edge_write(PIO_3_BASE, 1);
	  }
  }
  return 0;
}
