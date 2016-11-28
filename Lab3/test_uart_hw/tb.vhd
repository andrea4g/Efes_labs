library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity TESTBENCH is
    -- EMPTY!
end entity TESTBENCH;

architecture TEST of TESTBENCH is

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

    constant DIVISOR_C : std_logic_vector(15 downto 0):= "0000101000101011"; -- 2603 50E6/(2*9600)-1
    constant BITS_PER_DATA_C : std_logic_vector(3 downto 0):= "1010"; -- 11 BITS (COUNT 10)

    signal CLK_I, RST_I, UART_LINE_I, UART_CLOCK_OUT_I, STATus_I : std_logic;
    signal DATA_OUT_I : std_logic_vector(11 downto 0);

begin 

    CLK_P : process
    begin
        CLK_I <= '0';
        wait for 10 ns;
        CLK_I <= '1';
        wait for 10 ns;
    end process;

    RST_P : process
    begin
        RST_I <= '0';
        wait for 100 ns;
        RST_I <= '1';
        wait for 4 ms;
    end process;

    UART_P : process
    begin 
        -- IDLE
        UART_LINE_I <= '1';
        wait for 600 us;
        UART_LINE_I <= '0'; -- START BIT
        wait for 104 us;
        UART_LINE_I <= '1'; -- B0
        wait for 104 us;
        UART_LINE_I <= '0'; -- B1
        wait for 104 us;
        UART_LINE_I <= '1'; -- B2
        wait for 104 us;
        UART_LINE_I <= '0'; -- B3
        wait for 104 us;
        UART_LINE_I <= '1'; -- B4
        wait for 104 us;
        UART_LINE_I <= '0'; -- B5
        wait for 104 us;
        UART_LINE_I <= '1'; -- B6
        wait for 104 us;
        UART_LINE_I <= '0'; -- B7
        wait for 104 us;
        UART_LINE_I <= '1'; -- STOP BIT 1
        wait for 104 us;
        UART_LINE_I <= '1'; -- STOP BIT 0
        wait for 104 us;
    end process;

    UART_PERIPHERAL_0 : UART_PERIPHERAL
    port map (
        CLOCK => CLK_I,
        RESET => RST_I,
        UART_LINE => UART_LINE_I,
        DIVISOR => DIVISOR_C,
        BITS_PER_DATA => BITS_PER_DATA_C,
        DATA_OUT => DATA_OUT_I,
        UART_CLOCK_OUT => UART_CLOCK_OUT_I,
        STATus => STATus_I
    );


end architecture TEST;
