library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity TESTBENCH is 
    end TESTBENCH; 

architecture TEST of TESTBENCH is

    constant VALUE : integer := 4;

    component TASK2 is 
        generic(NBIT: integer);
        port ( 
            OP1 : in std_logic_vector(NBIT-1 downto 0);
            OP2 : in std_logic_vector(NBIT-1 downto 0);
            CLK : in std_logic;
            RST : in std_logic;
            C_in : in std_logic;
            C_out : out std_logic;
            SUM : out std_logic_vector(NBIT-1 downto 0);
            HEX : out std_logic_vector(0 to (NBIT/4)*7-1)); -- Must be multiple of 4
    end component; 

    signal OP1_i : std_logic_vector(VALUE-1 downto 0);
    signal OP2_i : std_logic_vector(VALUE-1 downto 0);
    signal CLK_i : std_logic;
    signal RST_i : std_logic;
    signal C_in_i : std_logic;
    signal C_out_i : std_logic;
    signal SUM_i : std_logic_vector(VALUE-1 downto 0);
    signal HEX_i : std_logic_vector(0 to (VALUE/4)*7-1);

begin

    DUT : TASK2
    generic map (
        NBIT => VALUE )
    port map (
        OP1  => OP1_i,
        OP2  => OP2_i,
        CLK  => CLK_i,
        RST  => RST_i,
        C_in  => C_in_i,
        C_out  => C_out_i,
        SUM  => SUM_i,
        HEX => HEX_i);

    TEST_P : process is
    begin
        RST_i <= '0';
        wait for 20 ns;
        RST_i <= '1';
        wait for 5 ns;

        for I in 0 to 31 loop
            for J in 0 to 31 loop
                OP1_i <= std_logic_vector(to_unsigned(I, OP1_i'length));
                OP2_i <= std_logic_vector(to_unsigned(J, OP2_i'length));
                wait for 20 ns;
            end loop;
        end loop;
    end process;

    C_P : process is 
    begin 
        C_in_i <= '0';
        wait for 20 ns;
        C_in_i <= '1';
        wait for 20 ns;
    end process;

    CLK_P : process is 
    begin 
        CLK_i <= '0';
        wait for 10 ns;
        CLK_i <= '1';
        wait for 10 ns;
    end process;

end TEST;
