library ieee;
use ieee.std_logic_1164.all; 

entity SIPO_GEN is
    generic(NBIT: integer);
    port (D_in: in std_logic;
          CLK: in std_logic;
          RST: in std_logic;
          EN : in std_logic;
          D_out: out std_logic_vector(NBIT-1 downto 0));
end SIPO_GEN;

architecture STRUCTURAL of SIPO_GEN is

    -- D flip-flop
    component FF is
        port (D: in std_logic;
              CLK: in std_logic;
              RST: in std_logic;
              EN : in std_logic;
              Q: out std_logic);
    end component;

    -- Internal D bus
    signal D_i : std_logic_vector(NBIT downto 0);

begin

    D_i(0) <= D_in;

    FF_GEN : for I in 0 to NBIT-1 generate
        FF_I : FF
        port map (
            D => D_i(I),
            CLK => CLK,
            RST => RST,
            EN  => EN,
            Q => D_i(I+1));
    end generate;

    D_out <= D_i(NBIT downto 1);
end STRUCTURAL;

