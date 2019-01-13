library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity HOSE is
	port(
	 CLK,RSTN	: in std_logic;
	 UPSWN		: in std_logic;
	 DOWNSWN	: in std_logic;
	 WATER		: out std_logic_vector(3 downto 0)
	);
end HOSE;

architecture RTL of HOSE is
	signal REG	: std_logic_vector(3 downto 0);
	constant MAXNUM	: std_logic_vector(3 downto 0) := "1010";
	constant MINNUM	: std_logic_vector(3 downto 0) := "0001";
begin
	process(CLK, RSTN)
	begin
		if(RSTN='0')then
			REG <= MAXNUM;
			WATER <= REG;
		elsif(CLK'event and CLK = '1')then
			--- UP / DOWN
			if(UPSWN = '0')then
				REG <= REG + 1;
			end if;
			if(DOWNSWN = '0')then
				REG <= REG - 1;
			end if;
			--- LIMIT
			if(MAXNUM < REG)then
				REG <= MAXNUM;
			elsif(REG < MINNUM)then
				REG <= MINNUM;
			end if;
			WATER <= REG;
		end if;
	end process;
end RTL;
