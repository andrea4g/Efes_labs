library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity datapath is
    port (
        clock: in std_logic;
        resetn: in std_logic;
        init: in std_logic;
        shift_enable: in std_logic;
        reg_enable: in std_logic;
        final_enable: in std_logic;
        count_enable: in std_logic;
        comp: in std_logic;
        nbit: in std_logic_vector(3 downto 0);
        tc: out std_logic;
        dacout: out std_logic_vector(9 downto 0);
        digital10: out std_logic_vector(9 downto 0)
    );
end datapath;

architecture rtl of datapath is

    component sr10 is
        port (
        clock, resetn: in std_logic;
        init: in std_logic;
        enable: in std_logic;
        data: out std_logic_vector(9 downto 0)
    );
    end component sr10;

    component reg10 is
        port (
        clock, resetn: in std_logic;
        init: in std_logic;
        enable: in std_logic;
        datain: in std_logic_vector(9 downto 0);
        dataout: out std_logic_vector(9 downto 0)
    );
    end component reg10;

    component counter4 is
        port (
        clock, resetn: in std_logic;
        init: in std_logic;
        enable: in std_logic;
        end_val: in std_logic_vector(3 downto 0);
        tc: out std_logic
    );
    end component counter4;

    signal sar10: std_logic_vector(9 downto 0);
    signal data10: std_logic_vector(9 downto 0);
    signal thr10: std_logic_vector(9 downto 0);
    signal comp10: std_logic_vector(9 downto 0);
    signal iter10: std_logic_vector(9 downto 0);
    signal final10: std_logic_vector(9 downto 0);
    signal final_init: std_logic;

begin

    final_init <= '0';
	
    shiftreg10: sr10 port map (clock, resetn, init, shift_enable, sar10);
    datareg10: reg10 port map (clock, resetn, init, reg_enable, iter10, data10);
    finalreg10: reg10 port map (clock, resetn, final_init, final_enable, final10, digital10);
    cnt4: counter4 port map (clock, resetn, init, count_enable, nbit, tc);

    thr10 <= sar10 or data10;
        
    comp10(0) <= sar10(0) and comp;
    comp10(1) <= sar10(1) and comp;
    comp10(2) <= sar10(2) and comp;
    comp10(3) <= sar10(3) and comp;
    comp10(4) <= sar10(4) and comp;
    comp10(5) <= sar10(5) and comp;
    comp10(6) <= sar10(6) and comp;
    comp10(7) <= sar10(7) and comp;
    comp10(8) <= sar10(8) and comp;
    comp10(9) <= sar10(9) and comp;
    iter10 <= data10 or comp10;
    dacout <= thr10;
    final10 <= data10;
	
end rtl;
