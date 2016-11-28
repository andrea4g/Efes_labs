library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HEX_7SEG_DECODER is
    port(ENC : in std_logic_vector(3 downto 0);
         DEC : out std_logic_vector(0 to 6));
end HEX_7SEG_DECODER; 

architecture BEHAVIOURAL of HEX_7SEG_DECODER is	
begin
    p1: process(ENC)
        variable TEMP : std_logic_vector(0 to 6);
    begin
        case ENC is
            when "0000" => TEMP := "1111110";
            when "0001" => TEMP := "0110000";
            when "0010" => TEMP := "1101101";
            when "0011" => TEMP := "1111001";
            when "0100" => TEMP := "0110011";
            when "0101" => TEMP := "1011011";
            when "0110" => TEMP := "1011111";
            when "0111" => TEMP := "1110000";
            when "1000" => TEMP := "1111111";
            when "1001" => TEMP := "1111011";
            when "1010" => TEMP := "1110111";
            when "1011" => TEMP := "0011111";
            when "1100" => TEMP := "1001110";
            when "1101" => TEMP := "0111101";
            when "1110" => TEMP := "1101111";
            when "1111" => TEMP := "1000111";
            when others => TEMP := "1111110";
        end case;
        DEC <= not TEMP;
    end process;
end BEHAVIOURAL;
