library ieee;
use ieee.std_logic_1164.all;

entity LEDDEC_TANK is
	port (
		TANK_METER	: in std_logic_vector(1 downto 0);
		LED_TANK	: out std_logic_vector(6 downto 0)
	);
end LEDDEC_TANK;

architecture RTL of LEDDEC_TANK is
begin 
	process(TANK_METER)
	begin
		if(TANK_METER = "00")then
			LED_TANK <= "1111111";
		elsif(TANK_METER = "01")then
			LED_TANK <= "1110111";
		elsif(TANK_METER = "10")then
			LED_TANK <= "0110111";
		elsif(TANK_METER = "11")then
			LED_TANK <= "0110110";
		else
			LED_TANK <= "0110110";
		end if;
	end process;
end RTL;

