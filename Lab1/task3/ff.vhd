library ieee;
use ieee.std_logic_1164.all; 

entity FF is
    port (D: in std_logic;
          CLK: in std_logic;
          RST: in std_logic;
          EN : in std_logic;
          Q: out std_logic);
end FF;

architecture ASYNCHRONOUS of FF is -- register with asyncronous reset

begin
    P_ASYNCH: process(CLK,RST)
    begin
        if RST='1' then
            Q <= '0'; 
        elsif CLK'event and CLK='1' then -- positive edge triggered
            if(EN='1') then
                Q <= D; -- input is written on output
            end if;
        end if;
    end process;
end ASYNCHRONOUS;

