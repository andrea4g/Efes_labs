library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LAB3_TEST is
    port (
        CLK : in std_logic;
        RST : in std_logic;
        UART_RX : in std_logic;
        HEX : out std_logic_vector(0 to 13);
        LEDG : out std_logic;
        LEDR : out std_logic_vector(11 downto 0)
    );
end entity LAB3_TEST;

architecture STRUCTURAL of LAB3_TEST is

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
    
    component HEX_7SEG_DECODER is
        port(ENC : in std_logic_vector(3 downto 0);
             DEC : out std_logic_vector(0 to 6));
    end component HEX_7SEG_DECODER; 

    signal DATA_OUT_i : std_logic_vector(11 downto 0);
    constant DIVISOR_C : std_logic_vector(15 downto 0):= "0000101000101011"; -- 2603 50E6/(2*9600)-1
    constant BITS_PER_DATA_C : std_logic_vector(3 downto 0):= "1010"; -- 11 BITS (COUNT 10)

begin

    UART_PERIPHERAL_0 : UART_PERIPHERAL
    port map (
        CLOCK => CLK,
        RESET => RST,
        UART_LINE => UART_RX,
        DIVISOR => DIVISOR_C,
        BITS_PER_DATA => BITS_PER_DATA_C,
        DATA_OUT => DATA_OUT_i,
        UART_CLOCK_OUT => open,
        STATUS => LEDG
    );
    
    LEDR <= DATA_OUT_i;
    
    HEX_7SEG_DECODER_0 : HEX_7SEG_DECODER
    port map (
        ENC(3 downto 0)  => DATA_OUT_i(9 downto 6),
        DEC(0 to 6)  => HEX(0 to 6));


    HEX_7SEG_DECODER_1 : HEX_7SEG_DECODER
    port map (
        ENC(3 downto 0)  => DATA_OUT_i(5 downto 2),
        DEC(0 to 6)  => HEX(7 to 13));

end architecture STRUCTURAL;
