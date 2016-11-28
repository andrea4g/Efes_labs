library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity uart_hw is
    port (
    clock, reset_n: in std_logic;
    uart_line: in std_logic;
    uart_bits: out std_logic_vector(11 downto 0);
    status_bit: out std_logic;
    uart_clock_out: out std_logic
);
end entity uart_hw;

architecture struct of uart_hw is

    component uart_processor is
        port (
        signal clk_0 : IN STD_LOGIC;
        signal reset_n : IN STD_LOGIC;
        signal out_port_from_the_bit_per_char : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        signal out_port_from_the_divisor : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        signal in_port_to_the_status : IN STD_LOGIC;
        signal in_port_to_the_uart_data : IN STD_LOGIC_VECTOR (11 DOWNTO 0)
    );
    end component;

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
    end component;

    signal divisor: std_logic_vector(15 downto 0);
    signal bits_per_data: std_logic_vector(3 downto 0);
    signal data_out: std_logic_vector(11 downto 0);
    signal status: std_logic;
begin
    up: uart_processor 
    port map (clock, reset_n, bits_per_data, divisor, status, data_out);

              per: uart_peripheral 
              port map (clock, reset_n, uart_line, divisor, bits_per_data, data_out,
              uart_clock_out, status);

    uart_bits <= data_out;
    status_bit <= status;
end architecture struct;
