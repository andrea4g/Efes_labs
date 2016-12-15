library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture behav of testbench is

	component datapath is
		port (
			clock: in std_logic;
			resetn: in std_logic;
			init: in std_logic;
			shift_enable: in std_logic;
			reg_enable: in std_logic;
			final_enable: in std_logic;
			comp: in std_logic;
			dacout: out std_logic_vector(9 downto 0);
			digital10: out std_logic_vector(9 downto 0)
		);
	end component datapath;
	
	signal clock: std_logic := '1';
	signal resetn: std_logic := '1';
	signal init: std_logic := '0';
	signal shift_enable: std_logic := '0';
	signal reg_enable: std_logic := '0';
	signal final_enable: std_logic := '0';
	signal comp: std_logic := '0';
	signal dacout, digital10: std_logic_vector(9 downto 0);
	
	constant clk_period: time := 300 ns;

begin

	dut: datapath port map (clock, resetn, init, shift_enable, reg_enable, final_enable, comp, dacout, digital10);
	
	myclock: process is
		begin
			clock <= '1';
			wait for clk_period/2;
			clock <= '0';
			wait for clk_period/2;
		end process myclock;

	stimuli: process is
		begin
			wait for 1 us;
			resetn <= '0';
			wait for 1 us;
			resetn <= '1';
			wait for 1.01 us;
			init <= '1';
			wait for 290 ns;
			wait for 10 ns;
			shift_enable <= '1';
			reg_enable <= '1';
			init <= '0';
			wait for 190 ns;
			comp <= '1';
			wait for 100 ns;
			wait for 300 ns;
			wait for 200 ns;
			comp <= '0';
			wait for 100 ns;
			wait for 300 ns;
			wait for 200 ns;
			comp <= '1';
			wait for 100 ns;
			wait for 200 ns;
			comp <= '0';
			wait for 100 ns;
			wait for 300 ns;
		end process;
		
end behav;
			