library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sarfsm is
	port (
		clock, resetn: in std_logic;
		run: in std_logic;
		tc: in std_logic;
		init: out std_logic;
		shift_enable: out std_logic;
		reg_enable: out std_logic;
		final_enable: out std_logic;
		count_enable: out std_logic
	);

end entity sarfsm;

architecture behav of sarfsm is
	type state is (SARIDLE, SARINIT, SARCONVERT, SARLATCH);
	signal current_state, next_state: state;

begin
	fsmreg: process (clock, resetn)
	begin
		if (resetn = '0') then
			current_state <= SARIDLE;
		elsif (rising_edge(clock)) then
			current_state <= next_state;
		end if;
	end process;
	
	fsmlc: process (current_state, run, tc)
	begin
		shift_enable <= '0';
		reg_enable <= '0';
		final_enable <= '0';
		count_enable <= '0';
		init <= '0';
		case current_state is
			when SARIDLE =>
				shift_enable <= '0';
				reg_enable <= '0';
				final_enable <= '0';
				count_enable <= '0';
				init <= '0';
				if (run = '1') then
					next_state <= SARINIT;
				else
					next_state <= SARIDLE;
				end if;
			when SARINIT =>
				shift_enable <= '0';
				reg_enable <= '0';
				final_enable <= '0';
				count_enable <= '0';
				init <= '1';
				next_state <= SARCONVERT;
			when SARCONVERT =>
				shift_enable <= '1';
				reg_enable <= '1';
				final_enable <= '0';
				count_enable <= '1';
				init <= '0';
				if (tc = '0') then
					next_state <= SARCONVERT;
				else
					next_state <= SARLATCH;
				end if;
			when SARLATCH =>
				shift_enable <= '0';
				reg_enable <= '0';
				final_enable <= '1';
				count_enable <= '0';
				init <= '0';
				if (run = '1') then
					next_state <= SARINIT;
				else
					next_state <= SARIDLE;
				end if;
			when others =>
				next_state <= SARIDLE;
		end case;
	end process;

end architecture behav;