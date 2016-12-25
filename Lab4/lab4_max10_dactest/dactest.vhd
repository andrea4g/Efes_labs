library ieee;
use ieee.std_logic_1164.all;

entity DACTEST is
    port(
    SW : in std_logic_vector(3 downto 0);
    VGA_R : out std_logic_vector(3 downto 0));
end entity DACTEST;

architecture STRUCTURAL of DACTEST is
begin
    VGA_R <= SW;
end architecture STRUCTURAL;
