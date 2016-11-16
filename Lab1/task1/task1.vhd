library ieee; 
use ieee.std_logic_1164.all; 

entity TASK1 is 
    port( SW : in std_logic_vector(1 downto 0);
          LEDR : out std_logic_vector(0 downto 0));
end TASK1; 

architecture BEHAVIORAL of TASK1 is
begin
    LEDR(0) <= SW(0) and SW(1);
end BEHAVIORAL;
