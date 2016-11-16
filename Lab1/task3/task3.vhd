library ieee;
use ieee.std_logic_1164.all; 

entity TASK3 is 
    port(
        SW : in std_logic_vector(1 downto 0);
        KEY : in std_logic_vector(1 downto 0);
        LEDR : out std_logic_vector(3 downto 0);
        LEDG : out std_logic_vector(0 downto 0)
    );
end TASK3;

architecture STRUCTURAL of TASK3 is

    alias D_in : std_logic is SW(0);
    alias EN : std_logic is SW(1);

    component SIPO_GEN is
        generic(NBIT: integer);
        port (D_in: in std_logic;
              CLK: in std_logic;
              RST: in std_logic;
              EN : in std_logic;
              D_out: out std_logic_vector(NBIT-1 downto 0));
    end component;

    signal CLK_i : std_logic;
    signal RST_i : std_logic;

begin

    CLK_i <= not KEY(0);
    RST_i <= not KEY(1);
    LEDG(0) <= D_in;

    SIPO_GEN_0 : SIPO_GEN
    generic map (
        NBIT => 4 )
    port map (
        D_in => D_in,
        CLK => CLK_i,
        RST => RST_i,
        EN => EN,
        D_out => LEDR );
end STRUCTURAL;
