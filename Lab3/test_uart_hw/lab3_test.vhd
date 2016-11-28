library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LAB3_TEST is
    port (
        CLK : in std_logic;
        RST : in std_logic;
        HEX : out std_logic_vector(0 to 13);
        LEDR : out std_logic
        UART_RX : out std_logic;
    );
end entity LAB3_TEST;

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

    component HEX_7SEG_DECODER is
        port(ENC : in std_logic_vector(3 downto 0);
             DEC : out std_logic_vector(0 to 6));
    end HEX_7SEG_DECODER; 

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

    HEX_7SEG_DECODER_0 : HEX_7SEG_DECODER
    port map (
        ENC  => (5 downto 2),
        DEC  => UART_BITS_i(0 to 6));


    HEX_7SEG_DECODER_1 : HEX_7SEG_DECODER
    port map (
        ENC  => (9 downto 6),
        DEC  => UART_BITS_i(7 to 13));

end architecture STRUCTURAL;
