library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ONESHOT is
    port(
        CLK : in std_logic;
        RSTN : in std_logic;
        SWN : in std_logic;
        SWONEN : out std_logic
        );
end ONESHOT;

architecture RTL of ONESHOT is 
    signal SWBEFOREN : std_logic;
    signal DIVCOUNT : std_logic_vector(19 downto 0);
    signal ENABLE : std_logic;

begin
    process (CLK, RSTN) begin 
        if(RSTN = '0')then
            ENABLE <= '0';
            DIVCOUNT <= "00000000000000000000";
        elsif(CLK' event and CLK = '1')then
            if(DIVCOUNT = "00000000000000000000")then
                ENABLE <= '1';
            else
                ENABLE <= '0';
            end if;
		  end if;
    end process;

    ---- simuration
    -- ENABLE <= '1';

    -----One Shot

    process (CLK, RSTN) begin
        if(RSTN = '0')then
            SWONEN <= '1';
            SWBEFOREN <= '1';
        elsif(CLK' event and CLK = '1') then
            if(ENABLE = '1')then
                if(SWN = '0' and SWBEFOREN = '1')then
                    SWONEN <= '0';
                else
                    SWONEN <= '1';
                end if;
                SWBEFOREN <= SWN;
            else
                SWBEFOREN <= '1';
            end if;
        end if;
    end process;
end RTL;
