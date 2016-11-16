library ieee; 
use ieee.std_logic_1164.all; 

entity TASK2 is 
    generic(NBIT: integer:= 4);
    port ( 
        OP1 : in std_logic_vector(NBIT-1 downto 0);
        OP2 : in std_logic_vector(NBIT-1 downto 0);
        CLK : in std_logic;
        RST : in std_logic;
        C_in : in std_logic;
        C_out : out std_logic;
        SUM : out std_logic_vector(NBIT-1 downto 0);
        HEX : out std_logic_vector(0 to (NBIT/4)*7-1)); -- Must be multiple of 4
end TASK2; 

architecture BEHAVIORAL of TASK2 is

    component RCA_GEN is 
        generic(NBIT: integer);
        port (A: in std_logic_vector(NBIT-1 downto 0);
              B: in std_logic_vector(NBIT-1 downto 0);
              C_in: in std_logic;
              S: out std_logic_vector(NBIT-1 downto 0);
              C_out: out std_logic);
    end component;

    component GPR_GEN is
        generic(NBIT: integer);
        port (D: in std_logic_vector(NBIT-1 downto 0);
              CLK: in std_logic;
              RESET: in std_logic;
              EN : in std_logic;
              Q: out std_logic_vector(NBIT-1 downto 0));
    end component;

    component HEX_7SEG_DECODER is
        port(ENC : in std_logic_vector(3 downto 0);
             DEC : out std_logic_vector(0 to 6));
    end component;

    signal OP1_i : std_logic_vector(NBIT-1 downto 0);
    signal OP2_i : std_logic_vector(NBIT-1 downto 0);
    signal SUM_in_i : std_logic_vector(NBIT-1 downto 0);
    signal SUM_out_i : std_logic_vector(NBIT-1 downto 0);
    signal C_in_i : std_logic;
    signal C_out_i : std_logic;

begin

    RCA_GEN_0 : RCA_GEN
    generic map (
        NBIT => NBIT )
    port map (
        A => OP1,
        B => OP2,
        C_in => C_in_i,
        S => SUM_in_i,
        C_out => C_out_i );

    GPR_GEN_OP1 : GPR_GEN
    generic map (
        NBIT => NBIT)
    port map (
        D => OP1,
        CLK => CLK,
        RESET => RST,
        EN  => '1',
        Q => OP1_i );

    GPR_GEN_OP2 : GPR_GEN
    generic map (
        NBIT => NBIT)
    port map (
        D => OP2,
        CLK => CLK,
        RESET => RST,
        EN  => '1',
        Q => OP2_i );

    GPR_GEN_OUT : GPR_GEN
    generic map (
        NBIT => NBIT )
    port map (
        D => SUM_in_i,
        CLK => CLK,
        RESET => RST,
        EN  => '1',
        Q => SUM_out_i);

    SUM <= SUM_out_i;

    GPR_GEN_CIN : GPR_GEN
    generic map (
        NBIT => 1)
    port map (
        D(0) => C_in,
        CLK => CLK,
        RESET => RST,
        EN  => '1',
        Q(0) => C_in_i );

    GPR_GEN_COUT : GPR_GEN
    generic map (
        NBIT => 1)
    port map (
        D(0) => C_out_i,
        CLK => CLK,
        RESET => RST,
        EN  => '1',
        Q(0) => C_out);

    HEX_I : for I in 0 to NBIT/4-1 generate
        HEX_7SEG_DECODER_0 : HEX_7SEG_DECODER
        port map (
            ENC  => SUM_out_i(4*(I+1)-1 downto I*4),
            DEC  => HEX(I*7 to 7*(I+1)-1));
    end generate;

end BEHAVIORAL;
