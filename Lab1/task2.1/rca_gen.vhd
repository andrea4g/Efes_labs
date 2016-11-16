library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity RCA_GEN is 
    generic(NBIT: integer);
    port (A: in std_logic_vector(NBIT-1 downto 0);
          B: in std_logic_vector(NBIT-1 downto 0);
          C_in: in std_logic;
          S: out std_logic_vector(NBIT-1 downto 0);
          C_out: out std_logic);
end RCA_GEN; 

architecture BEHAVIORAL of RCA_GEN is

    signal TEMP_i : std_logic_vector(NBIT downto 0);
    signal TEMP_C_in_i : std_logic_vector(0 downto 0);

begin

    TEMP_C_in_i(0) <= C_in;
    TEMP_i <= std_logic_vector(to_unsigned(to_integer(unsigned(A)) + to_integer(unsigned(B)) + to_integer(unsigned(TEMP_C_in_i)), NBIT));

    S <= TEMP_i(NBIT-1 downto 0);
    C_out <= TEMP_i(NBIT);
end BEHAVIORAL;
