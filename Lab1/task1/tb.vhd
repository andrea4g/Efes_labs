library ieee; 
use ieee.std_logic_1164.all; 

entity TESTBENCH is 
    end TESTBENCH; 

architecture TEST of TESTBENCH is

    component TASK1 is 
        port( SW : in std_logic_vector(1 downto 0);
              LEDR : out std_logic_vector(0 downto 0));
    end component;
    
    signal SW_i : std_logic_vector(1 downto 0);
    signal LEDR_i : std_logic_vector(0 downto 0);

begin

    DUT : TASK1
    port map (
        SW  => SW_i,
        LEDR  => LEDR_i );

    TEST_P : process is
    begin
        SW_i(0) <= '0';
        SW_i(1) <= '0';
        wait for 10 us;
        SW_i(0) <= '1';
        SW_i(1) <= '0';
        wait for 10 us;
        SW_i(0) <= '0';
        SW_i(1) <= '1';
        wait for 10 us;
        SW_i(0) <= '1';
        SW_i(1) <= '1';
        wait for 10 us;
    end process;


end TEST;
