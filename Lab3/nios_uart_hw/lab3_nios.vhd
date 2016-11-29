library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LAB3_NIOS is
    port (
        CLK : in std_logic;
        RST : in std_logic;
        UART_RX : in std_logic;
        LEDG : out std_logic;
        LEDR : out std_logic_vector(11 downto 0)
    );
end entity LAB3_NIOS;

architecture STRUCTURAL of LAB3_NIOS is

  component UART_PERIPHERAL is
      port (
      CLOCK, RESET: in std_logic;
      UART_LINE: in std_logic;
      DIVISOR: in std_logic_vector(15 downto 0);
      BITS_PER_DATA: in std_logic_vector(3 downto 0);
      DATA_OUT: out std_logic_vector(11 downto 0);
      UART_CLOCK_OUT: out std_logic;
      STATus: out std_logic
  );
  end component UART_PERIPHERAL;
    

  component nios_uart_hw is 
    port (
          -- 1) global signals:
             signal clk_0 : IN STD_LOGIC;
             signal reset_n : IN STD_LOGIC;

          -- the_pio_0
             signal out_port_from_the_pio_0 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);

          -- the_pio_1
             signal out_port_from_the_pio_1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

          -- the_pio_2
             signal in_port_to_the_pio_2 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

          -- the_pio_3
             signal in_port_to_the_pio_3 : IN STD_LOGIC
          );
  end component nios_uart_hw;

    signal UART_BITS_i : std_logic_vector(11 downto 0);
    signal DIVISOR_i : std_logic_vector(15 downto 0);
    signal BITS_PER_DATA_i : std_logic_vector(3 downto 0);
    signal STATUS_i : std_logic;

begin

    UART_PERIPHERAL_0 : UART_PERIPHERAL
    port map (
        CLOCK => CLK,
        RESET => RST,
        UART_LINE => UART_RX,
        DIVISOR => DIVISOR_i,
        BITS_PER_DATA => BITS_PER_DATA_i,
        DATA_OUT => UART_BITS_i,
        UART_CLOCK_OUT => open,
        STATUS => STATUS_i
    );
    
    LEDR <= UART_BITS_i;
    LEDG <= STATUS_i;
    
    nios_uart_hw_inst : nios_uart_hw
    port map(
        out_port_from_the_pio_0 => DIVISOR_i,
        out_port_from_the_pio_1 => BITS_PER_DATA_i,
        clk_0 => CLK,
        in_port_to_the_pio_2 => UART_BITS_i,
        in_port_to_the_pio_3 => STATUS_i,
        reset_n => RST
    );
end architecture STRUCTURAL;
