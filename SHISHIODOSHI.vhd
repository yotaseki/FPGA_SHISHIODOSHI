library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SHISHIODOSHI is
	port (
		CLK,RSTN		: in std_logic;
		ENABLE_250MSEC	: in std_logic;
		WATER			: in std_logic_vector(3 downto 0);
		POSE_ID			: out std_logic_vector(1 downto 0);
		TANK_METER		: out std_logic_vector(1 downto 0)
	);
end SHISHIODOSHI;

architecture RTL of SHISHIODOSHI is
	signal COUNT_1SEC	: std_logic_vector(2 downto 0);
	constant MAXCOUNT	: std_logic_vector(2 downto 0) := "100"; -- 250 * 4 msec
	constant ZEROCOUNT	: std_logic_vector(2 downto 0) := "000";
	signal STATE		: std_logic_vector(2 downto 0); -- for Animation
	signal REG_TANK		: std_logic_vector(5 downto 0);
	constant TANK_FULL	: std_logic_vector(6 downto 0) := "0111100"; -- 60
	constant TANK_MID	: std_logic_vector(6 downto 0) := "0011110"; -- 30
	constant TANK_EMPTY : std_logic_vector(6 downto 0) := "0000000";
begin
	process (CLK,RSTN)begin
		if(RSTN = '0')then
			REG_TANK	<= TANK_EMPTY;
			COUNT_1SEC	<= ZEROCOUNT;
			STATE		<= "000";
			TANK_METER	<= "00";
			POSE_ID		<= "00";
		elsif(CLK'event and CLK = '1')then
			if(ENABLE_250MSEC = '1')then
				COUNT_1SEC <= COUNT_1SEC + 1;
				if(REG_TANK >= TANK_FULL)then
					if(STATE = "000")then		--1
						STATE	<= STATE + 1;
						POSE_ID		<= "00";
						TANK_METER	<= "11";
					elsif(STATE = "001")then	--2
						STATE	<= STATE + 1;
						POSE_ID		<= "01";
						TANK_METER	<= "11";
					elsif(STATE = "010")then	--3
						STATE	<= STATE + 1;
						POSE_ID		<= "10";
						TANK_METER	<= "10";
					elsif(STATE = "011")then	--3
						STATE	<= STATE + 1;
						POSE_ID		<= "10";
						TANK_METER	<= "01";
					elsif(STATE = "100")then	--2
						STATE	<= STATE + 1;
						POSE_ID		<= "01";
						TANK_METER	<= "00";
					elsif(STATE = "101")then	--1
						STATE	<= "000";
						POSE_ID		<= "00";
						TANK_METER	<= "00";
						REG_TANK	<= TANK_EMPTY;
					end if;
					COUNT_1SEC <= ZEROCOUNT;
				end if;
			end if;
			
			if(COUNT_1SEC = MAXCOUNT and REG_TANK < TANK_FULL)then
				COUNT_1SEC <= ZEROCOUNT;
				REG_TANK <= REG_TANK + ("000" & WATER);
				POSE_ID <= "00";
				if(REG_TANK < TANK_MID)then
					TANK_METER <= "01";
				elsif(REG_TANK < TANK_FULL)then
					TANK_METER <= "10";
				else
					TANK_METER <= "11";
				end if;
			end if;
		end if;
	end process;
end RTL;
			




