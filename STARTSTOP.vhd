library ieee;
use ieee.std_logic_1164.all;

entity STARTSTOP is
    port(
        CLK : in std_logic;
        RSTN : in std_logic;
        STARTN : in std_logic;
        COUNTING : out std_logic);
end STARTSTOP;

architecture RTL of STARTSTOP is
    signal COUNTING_FF : std_logic;

    begin
        COUNTING <= COUNTING_FF;

    process(CLK, RSTN) begin
        if(RSTN = '0') then
            COUNTING_FF <= '0';
        elsif(CLK' event and CLK = '1') then
            if(STARTN = '0') then
                COUNTING_FF <= not COUNTING_FF;
            end if;
        end if;
    end process;
end RTL;

