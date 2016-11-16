library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity TB is 
    end TB; 

architecture TEST of TB is

    component TASK2 is 
        port ( KEY : in std_logic_vector(0 downto 0);
               SW : in std_logic_vector(7 downto 0);
               HEX0 : out std_logic_vector(6 downto 0);
               LEDG : out std_logic_vector(0 downto 0);
               LEDR : out std_logic_vector(3 downto 0));
    end component; 

    signal KEY_i : std_logic_vector(0 downto 0);
    signal SW_i : std_logic_vector(7 downto 0);
    signal HEX0_i : std_logic_vector(6 downto 0);
    signal LEDG_i : std_logic_vector(0 downto 0);
    signal LEDR_i : std_logic_vector(3 downto 0);

begin


    TASK2_0 : TASK2
    port map (
        KEY  => KEY_i,
        SW  => SW_i,
        HEX0  => HEX0_i,
        LEDG  => LEDG_i,
        LEDR  => LEDR_i );

    TEST_P : process is
    begin
        for I in 0 to 31 loop
            SW_i <= std_logic_vector(to_unsigned(I, SW_i'length));
            wait for 5 ns;
        end loop;
    end process;

    C_P : process is 
    begin 
        KEY_i(0) <= '0';
        wait for 2.5 ns;
        KEY_i(0) <= '1';
        wait for 2.5 ns;
    end process;

end TEST;
