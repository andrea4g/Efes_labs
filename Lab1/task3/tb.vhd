library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity TESTBENCH is 
end TESTBENCH; 

architecture TEST of TESTBENCH is

    component TASK3 is 
        port(
            SW : in std_logic_vector(1 downto 0);
            KEY : in std_logic_vector(1 downto 0);
            LEDR : out std_logic_vector(3 downto 0);
            LEDG : out std_logic_vector(0 downto 0)
        );
    end component;

    signal SW_i : std_logic_vector(1 downto 0);
    signal KEY_i : std_logic_vector(1 downto 0);
    signal LEDG_i : std_logic_vector(0 downto 0);
    signal LEDR_i : std_logic_vector(3 downto 0);

    alias CLK : std_logic is KEY_i(0);
    alias RST : std_logic is KEY_i(1);
    alias D_in : std_logic is SW_i(0);
    alias EN : std_logic is SW_i(1);

begin

    DUT : TASK3
    port map (
        SW  => SW_i,
        KEY  => KEY_i,
        LEDR  => LEDR_i,
        LEDG  => LEDG_i
    );

    TEST_P : process is
    begin
        -- Disable shift register
        EN <= '0'; 
        wait for 10 us;

        -- Issue reset
        RST <= '0';
        wait for 1 us;
        RST <= '1';
        wait for 1 us;


        -- Test disable behaviour
        D_in <= '0'; 
        wait for 5 us;
        D_in <= '1'; 
        wait for 5 us;
        D_in <= '0'; 
        wait for 5 us;
        D_in <= '1'; 
        wait for 5 us;
        
        -- Enable shift register
        EN <= '1';

        -- Test enable behaviour
        D_in <= '0'; 
        wait for 5 us;
        D_in <= '1'; 
        wait for 5 us;
        D_in <= '0'; 
        wait for 5 us;
        D_in <= '1'; 
        wait for 5 us;

    end process;

    CLK_P : process is 
    begin 
        CLK <= '0';
        wait for 2.5 us;
        CLK <= '1';
        wait for 2.5 us;
    end process;

end TEST;
