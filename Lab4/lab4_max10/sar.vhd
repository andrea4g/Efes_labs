library ieee;
use ieee.std_logic_1164.all;

entity sar is
    port (
    clock, resetn: in std_logic;
    run: in std_logic;
    comp: in std_logic;
    nbit: in std_logic_vector(3 downto 0);
    dacout: out std_logic_vector(9 downto 0);
    done: out std_logic;
    adcout: out std_logic_vector(9 downto 0)
);
end entity sar;

architecture struct of sar is

    component datapath is
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
    end component datapath;

    component sarfsm is
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
    end component sarfsm;

    component counter8 is
        port (
        clock, resetn: in std_logic;
        init: in std_logic;
        enable: in std_logic;
        end_val: in std_logic_vector(7 downto 0);
        tc: out std_logic
    );
    end component counter8;

    signal init, shift_enable, reg_enable, final_enable, count_enable, tc: std_logic;
    signal slowclock, clkdiv_enable, clkdiv_init: std_logic;
    signal clkdivisor : std_logic_vector(7 downto 0);

begin

    clkdivisor <= (others => '1');
    clkdiv_enable <= '1';
    clkdiv_init <= '0';
    done <= final_enable;
    clkdiv: counter8 port map (clock, resetn, clkdiv_init, clkdiv_enable, clkdivisor, slowclock);
    dp: datapath port map (slowclock, resetn, init, shift_enable, reg_enable, final_enable, count_enable, comp, nbit, tc, dacout, adcout);
    fsm: sarfsm port map (slowclock, resetn, run, tc, init, shift_enable, reg_enable, final_enable, count_enable);

end struct;
