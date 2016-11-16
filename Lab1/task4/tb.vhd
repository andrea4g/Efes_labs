library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity TESTBENCH is 
end TESTBENCH; 

architecture TEST of TESTBENCH is

    component TASK4 is 
        port(
            SW : in std_logic_vector(0 downto 0);
            KEY : in std_logic_vector(1 downto 0);
            HEX0 : out std_logic_vector(0 to 6);
            HEX1 : out std_logic_vector(0 to 6);
            HEX2 : out std_logic_vector(0 to 6);
            HEX3 : out std_logic_vector(0 to 6);
            HEX4 : out std_logic_vector(0 to 6);
            HEX5 : out std_logic_vector(0 to 6);
            HEX6 : out std_logic_vector(0 to 6);
            HEX7 : out std_logic_vector(0 to 6)
        );
    end component;

    signal SW_i : std_logic_vector(0 downto 0);
    signal KEY_i : std_logic_vector(1 downto 0);
    signal HEX0_i : std_logic_vector(0 to 6);
    signal HEX1_i : std_logic_vector(0 to 6);
    signal HEX2_i : std_logic_vector(0 to 6);
    signal HEX3_i : std_logic_vector(0 to 6);
    signal HEX4_i : std_logic_vector(0 to 6);
    signal HEX5_i : std_logic_vector(0 to 6);
    signal HEX6_i : std_logic_vector(0 to 6);
    signal HEX7_i : std_logic_vector(0 to 6);

    alias CLK : std_logic is KEY_i(0);
    alias RST : std_logic is KEY_i(1);
    alias EN : std_logic is SW_i(0);

begin

    DUT : TASK4
    port map (
        SW  => SW_i,
        KEY  => KEY_i,
        HEX0  => HEX0_i,
        HEX1  => HEX1_i,
        HEX2  => HEX2_i,
        HEX3  => HEX3_i,
        HEX4  => HEX4_i,
        HEX5  => HEX5_i,
        HEX6  => HEX6_i,
        HEX7  => HEX7_i
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
        wait for 100 us;

        -- Enable shift register
        EN <= '1';

        -- Test enable behaviour
        wait for 500 us;

    end process;

    CLK_P : process is 
    begin 
        CLK <= '0';
        wait for 2.5 us;
        CLK <= '1';
        wait for 2.5 us;
    end process;

end TEST;
