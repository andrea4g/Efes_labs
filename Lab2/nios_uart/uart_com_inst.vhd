  --Example instantiation for system 'uart_com'
  uart_com_inst : uart_com
    port map(
      out_port_from_the_pio_1 => out_port_from_the_pio_1,
      out_port_from_the_pio_2 => out_port_from_the_pio_2,
      out_port_from_the_pio_3 => out_port_from_the_pio_3,
      clk_0 => clk_0,
      in_port_to_the_pio_0 => in_port_to_the_pio_0,
      reset_n => reset_n
    );


