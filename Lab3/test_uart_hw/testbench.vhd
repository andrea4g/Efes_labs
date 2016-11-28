library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity testbench is
    -- Empty!
    end entity testbench;

architecture test of testbench is

    component uart_peripheral is
        port (
        clock, reset: in std_logic;
        uart_line: in std_logic;
        divisor: in std_logic_vector(15 downto 0);
        bits_per_data: in std_logic_vector(3 downto 0);
        data_out: out std_logic_vector(11 downto 0);
        uart_clock_out: out std_logic;
        status: out std_logic
    );
    end component uart_peripheral;

    constant divisor_c : std_logic_vector(15 downto 0):= "0000101000101011"; -- 2603 50e6/(2*9600)-1
    constant bits_per_data_c : std_logic_vector(3 downto 0):= "1010"; -- 11 bits (count 10)

    signal clk_i, rst_i, uart_line_i, uart_clock_out_i, status_i : std_logic;
    signal data_out_i : std_logic_vector(11 downto 0);

begin 

    CLK_P : process
    begin
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
    end process;

    RST_P : process
    begin
        rst_i <= '0';
        wait for 100 ns;
        rst_i <= '1';
        wait for 2 ms;
    end process;

    UART_P : process
    begin 
        -- Idle
        uart_line_i <= '1';
        wait for 600 us;
        uart_line_i <= '0'; -- Start bit
        wait for 104 us;
        uart_line_i <= '1'; -- B0
        wait for 104 us;
        uart_line_i <= '0'; -- B1
        wait for 104 us;
        uart_line_i <= '1'; -- B2
        wait for 104 us;
        uart_line_i <= '0'; -- B3
        wait for 104 us;
        uart_line_i <= '1'; -- B4
        wait for 104 us;
        uart_line_i <= '0'; -- B5
        wait for 104 us;
        uart_line_i <= '1'; -- B6
        wait for 104 us;
        uart_line_i <= '0'; -- B7
        wait for 104 us;
        uart_line_i <= '1'; -- Stop bit 1
        wait for 104 us;
        uart_line_i <= '1'; -- Stop bit 0
        wait for 104 us;
    end process;

    uart_peripheral_0 : uart_peripheral
    port map (
        clock => clk_i,
        reset => rst_i,
        uart_line => uart_line_i,
        divisor => divisor_c,
        bits_per_data => bits_per_data_c,
        data_out => data_out_i,
        uart_clock_out => uart_clock_out_i,
        status => status_i
    );


end architecture test;
