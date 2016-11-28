library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LAB3_NIOS is
    port (
        CLK : in std_logic;
        RST : in std_logic;
        HEX : out std_logic_vector(0 to 13);
        LEDR : out std_logic
        UART_RX : out std_logic;
    );
end entity LAB3_NIOS;

architecture STRUCTURAL of LAB3_TEST is

    component UART_HW is
        port (
        CLOCK, RESET_N: in std_logic;
        UART_LINE: in std_logic;
        UART_BITS: out std_logic_vector(11 downto 0);
        STATUS_BIT: out std_logic;
        UART_CLOCK_OUT: out std_logic
    );
    end component UART_HW;

    signal UART_BITS_i : std_logic_vector(11 downto 0);

begin

    UART_HW_0 : UART_HW
    port map (
        CLOCK => CLK,
        RESET_N => RST,
        UART_LINE => UART_RX,
        UART_BITS => UART_BITS_i,
        STATUS_BIT => LEDR,
        UART_CLOCK_OUT => open
    );

end architecture STRUCTURAL;
