library ieee;
use ieee.std_logic_1164.all;

entity testbenchsar is
end testbenchsar;

architecture behav of testbenchsar is

	component sar is
		port (
			clock, resetn: in std_logic;
			run: in std_logic;
			comp: in std_logic;
			nbit: in std_logic_vector(3 downto 0);
         bluein: in std_logic_vector(4 downto 0);
         clkdivisor: in std_logic_vector(7 downto 0);
			dacout: out std_logic_vector(9 downto 0);
         dacsync: out std_logic;
         dacblank: out std_logic;
         dacclk: out std_logic;
         dacgreen: out std_logic_vector(9 downto 0);
         dacblue: out std_logic_vector(9 downto 0);
         done: out std_logic;
			adcout: out std_logic_vector(9 downto 0)
		);
	end component sar;
	
	signal clock: std_logic := '0';
	signal resetn: std_logic := '1';
	signal run: std_logic := '0';
	signal comp: std_logic := '0';
	signal nbit: std_logic_vector(3 downto 0);
	signal clkdivisor: std_logic_vector(7 downto 0);
	signal dacout: std_logic_vector(9 downto 0);
	signal adcout: std_logic_vector(9 downto 0);
   signal bluein: std_logic_vector(4 downto 0) := "10101";
   signal dacsync, dacblank: std_logic;
   signal dacgreen: std_logic_vector(9 downto 0);
   signal dacblue: std_logic_vector(9 downto 0);
   signal done: std_logic;
   signal dacclk: std_logic;

	constant clk_period: time := 20 ns;
	
begin

	dut: sar port map (clock, resetn, run, comp, nbit, bluein, clkdivisor, dacout, dacsync, dacblank, dacclk, dacgreen, dacblue, done, adcout);
	
	nbit <= "1001";
	clkdivisor <= "00001110";
	
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
			run <= '1';
			wait for 290 ns;
			wait for 300 ns;
			wait for 200 ns;
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
			wait for 300 ns;
			wait for 300 ns;
			wait for 300 ns;
			wait for 300 ns;
			wait for 300 ns;
			wait for 300 ns;
			wait for 300 ns;

		end process;
		
end behav;