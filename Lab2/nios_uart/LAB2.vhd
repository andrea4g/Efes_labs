library ieee;
use ieee.std_logic_1164.all;

entity LAB2 is
  port (
    -- 1) global signals:
      signal clk_0 : IN STD_LOGIC;
      signal reset_n : IN STD_LOGIC;

    -- the_pio_0
      signal in_port_to_the_pio_0     :  IN STD_LOGIC;
    
    -- the_pio_1
      signal out_port_from_the_pio_1  :  OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    
    -- the_pio_2
       signal out_port_from_the_pio_2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);

    -- the_pio_3
       signal out_port_from_the_pio_3 : OUT STD_LOGIC
  );
end entity LAB2;

architecture STRUCTURAL of LAB2 is

  component uart_com is 
    port (
      -- 1) global signals:
         signal clk_0                   : IN STD_LOGIC;
         signal reset_n                 : IN STD_LOGIC;

      -- the_pio_0
         signal in_port_to_the_pio_0    : IN  STD_LOGIC;

      -- the_pio_1
         signal out_port_from_the_pio_1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);

      -- the_pio_2
         signal out_port_from_the_pio_2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);

      -- the_pio_3
         signal out_port_from_the_pio_3 : OUT STD_LOGIC
  );
  end component uart_com;

begin

  --instantiation for system 'uart_com'
  uart_com_inst : uart_com
    port map(
      out_port_from_the_pio_1 => out_port_from_the_pio_1,
      out_port_from_the_pio_2 => out_port_from_the_pio_2,
      out_port_from_the_pio_3 => out_port_from_the_pio_3,
      clk_0                   => clk_0,
      in_port_to_the_pio_0    => in_port_to_the_pio_0,
      reset_n                 => reset_n
    );
end architecture STRUCTURAL;

