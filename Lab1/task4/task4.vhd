library ieee;
use ieee.std_logic_1164.all; 

entity TASK4 is 
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
end TASK4;

architecture STRUCTURAL of TASK4 is

    alias EN : std_logic is SW(0);

    component COUNTER_GEN is 
        generic(NBIT: integer);
        port (CLK: in std_logic;
              RST: in std_logic;
              EN: in std_logic;
              D: out std_logic_vector(NBIT-1 downto 0));
    end component; 

    component HEX_7SEG_DECODER is
        port(ENC : in std_logic_vector(3 downto 0);
             DEC : out std_logic_vector(0 to 6));
    end component; 

    type DISPLAY_t is array(0 to 7) of std_logic_vector(3 downto 0);

    signal CLK_i : std_logic;
    signal RST_i : std_logic;
    signal D_i : std_logic_vector(31 downto 0);
    signal DISPLAY_i : DISPLAY_t;


begin

    CLK_i <= not KEY(0);
    RST_i <= KEY(1);

    COUNTER_GEN_0 : COUNTER_GEN
    generic map (
        NBIT => 32 )
    port map (
        CLK => CLK_i,
        RST => RST_i,
        EN => EN,
        D => D_i);

    WIRE : for I in 0 to 7 generate
        DISPLAY_i(I) <= D_i((I+1)*4-1 downto I*4);
    end generate;

    HEX_7SEG_DECODER_0 : HEX_7SEG_DECODER
    port map (
        ENC  => DISPLAY_i(0),
        DEC  => HEX0 );
    
    HEX_7SEG_DECODER_1 : HEX_7SEG_DECODER
    port map (
        ENC  => DISPLAY_i(1),
        DEC  => HEX1 );
    
    HEX_7SEG_DECODER_2 : HEX_7SEG_DECODER
    port map (
        ENC  => DISPLAY_i(2),
        DEC  => HEX2 );

    HEX_7SEG_DECODER_3 : HEX_7SEG_DECODER
    port map (
        ENC  => DISPLAY_i(3),
        DEC  => HEX3 );

    HEX_7SEG_DECODER_4 : HEX_7SEG_DECODER
    port map (
        ENC  => DISPLAY_i(4),
        DEC  => HEX4 );
    
    HEX_7SEG_DECODER_5 : HEX_7SEG_DECODER
    port map (
        ENC  => DISPLAY_i(5),
        DEC  => HEX5 );
    
    HEX_7SEG_DECODER_6 : HEX_7SEG_DECODER
    port map (
        ENC  => DISPLAY_i(6),
        DEC  => HEX6 );
    
    HEX_7SEG_DECODER_7 : HEX_7SEG_DECODER
    port map (
        ENC  => DISPLAY_i(7),
        DEC  => HEX7 );
    



end STRUCTURAL;
