library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sr10 is
	port (
		clock, resetn: in std_logic;
		init: in std_logic;
		enable: in std_logic;
		data: out std_logic_vector(9 downto 0)
	);
end entity sr10;

architecture rtl of sr10 is
	signal sr: std_logic_vector(9 downto 0);
begin
	process (clock, resetn)
	begin
		if (resetn = '0') then
			sr <= (others => '0');
		elsif (rising_edge(clock)) then
			if (init = '1') then
				sr <= "1000000000";
			elsif (enable = '1') then
				sr (8 downto 0) <= sr(9 downto 1);
				sr(9) <= '0';
			end if;
		end if;
	end process;
	data <= sr;
end architecture rtl;