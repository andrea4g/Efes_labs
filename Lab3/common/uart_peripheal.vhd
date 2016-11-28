library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity uart_peripheral is
    port (
    clock, reset: in std_logic;
    uart_line: in std_logic;
    divisor: in std_logic_vector(15 downto 0);
    bits_per_data: in std_logic_vector(3 downto 0);
    data_out: out std_logic_vector(11 downto 0);
    uart_clock_out: out std_logic;
    status: out std_logic
);
end entity uart_peripheral;

architecture struct of uart_peripheral is
    component uart_clock_gen is
        port (
        clock, reset: in std_logic;
        clear: in std_logic;
        end_val: in std_logic_vector(15 downto 0);
        uart_clock: out std_logic
    );
    end component;
    component counter4 is
        port (
        clock, reset: in std_logic;
        clear: in std_logic;
        end_val: in std_logic_vector(3 downto 0);
        tc: out std_logic
    );
    end component;
    component uart_fsm is
        port (
        clock, reset: in std_logic;
        uart_line: in std_logic;
        tc_char: in std_logic;
        clear: out std_logic;
        shift_enable: out std_logic;
        waiting: out std_logic
    );
    end component;
    component shift_reg12 is
        port (
        uart_clock, reset: in std_logic;
        clear: in std_logic;
        shift_enable: in std_logic;
        rx_line: in std_logic;
        data_out: out std_logic_vector(11 downto 0)
    );
    end component;
    signal uart_clock, clear, tc_char, shift_enable: std_logic;

begin
    uart_clock_out <= uart_clock;

    c16: uart_clock_gen 
    port map(clock, reset, clear, divisor, uart_clock);

             c4: counter4 
             port map(uart_clock, reset, clear, bits_per_data, tc_char);

                      s12: shift_reg12 
                      port map(uart_clock, reset, clear, shift_enable, uart_line, data_out);

                               fsm: uart_fsm 
                               port map(clock, reset, uart_line, tc_char, clear, shift_enable, status);
end architecture struct;
