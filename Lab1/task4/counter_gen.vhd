library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity COUNTER_GEN is 
    generic(NBIT: integer);
    port (CLK: in std_logic;
          RST: in std_logic;
          EN: in std_logic;
          D: out std_logic_vector(NBIT-1 downto 0));
end COUNTER_GEN; 

architecture STRUCTURAL of COUNTER_GEN is

begin

    COUNTER_P : process(CLK, RST) is
        variable COUNT : integer := 0;
    begin
        if(RST='0') then
            COUNT := 0;
        elsif(CLK'event and CLK='1' and EN='1') then
            COUNT := COUNT + 1;
        end if;

        D <= std_logic_vector(to_unsigned(COUNT, D'length));
    end process;
end STRUCTURAL;

