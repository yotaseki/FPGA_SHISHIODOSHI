library ieee;
use ieee.std_logic_1164.all;

entity LEDDEC_HOSE is
	port (
		WATER	:in std_logic_vector(3 downto 0);
		LEDL	:out std_logic_vector(6 downto 0);
		LEDH	:out std_logic_vector(6 downto 0)
	);
end LEDDEC_HOSE;

architecture RTL of LEDDEC_HOSE is
begin
	process(WATER)
	begin
		if   (WATER = "0000")then
			LEDL <= "1000000";
			LEDH <= "1111111";
		elsif(WATER = "0001")then
			LEDL <= "1111001";
			LEDH <= "1111111";
		elsif(WATER = "0010")then
			LEDL <= "0100100";
			LEDH <= "1111111";
		elsif(WATER = "0011")then
			LEDL <= "0110000";
			LEDH <= "1111111";
		elsif(WATER = "0100")then
			LEDL <= "0011001";
			LEDH <= "1111111";
		elsif(WATER = "0101")then
			LEDL <= "0010010";
			LEDH <= "1111111";
		elsif(WATER = "0110")then
			LEDL <= "0000010";
			LEDH <= "1111111";
		elsif(WATER = "0111")then
			LEDL <= "1011000";
			LEDH <= "1111111";
		elsif(WATER = "1000")then
			LEDL <= "0000000";
			LEDH <= "1111111";
		elsif(WATER = "1001")then
			LEDL <= "0010000";
			LEDH <= "1111111";
		elsif(WATER = "1010")then
			LEDL <= "1000000";
			LEDH <= "1111001";
		else
			LEDL <= "0111111";
			LEDH <= "0111111";
		end if;
	end process;
end RTL;
