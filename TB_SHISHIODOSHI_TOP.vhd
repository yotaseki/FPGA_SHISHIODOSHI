library ieee;
use ieee.std_logic_1164.all;

entity TB_SHISHIODOSHI_TOP is
end TB_SHISHIODOSHI_TOP;

architecture TESTBENCH of TB_SHISHIODOSHI_TOP is
	component SHISHIODOSHI_TOP port (
		CLK,RSTN		: in std_logic;
		STARTN			: in std_logic;
		UPSWN, DOWNSWN	: in std_logic;
		LED_POSE_L		: out std_logic_vector(6 downto 0);
		LED_POSE_M		: out std_logic_vector(6 downto 0);
		LED_POSE_R		: out std_logic_vector(6 downto 0);
		LED_TANK		: out std_logic_vector(6 downto 0);
		LED_WATER_L		: out std_logic_vector(6 downto 0);
		LED_WATER_H		: out std_logic_vector(6 downto 0)
	);
	end component;

	signal TBCLK, TBSTARTN, TBRSTN, TBUPSWN, TBDOWNSWN	: std_logic;
	signal TBLED_POSE_L		: std_logic_vector(6 downto 0);
	signal TBLED_POSE_M		: std_logic_vector(6 downto 0);
	signal TBLED_POSE_R		: std_logic_vector(6 downto 0);
	signal TBLED_TANK		: std_logic_vector(6 downto 0);
	signal TBLED_WATER_L	: std_logic_vector(6 downto 0);
	signal TBLED_WATER_H	: std_logic_vector(6 downto 0);

begin
	U1	: SHISHIODOSHI_TOP port map(
		CLK=>TBCLK, RSTN=>TBRSTN, STARTN=>TBSTARTN,UPSWN=>TBUPSWN, DOWNSWN=>TBDOWNSWN
		,LED_POSE_L=>TBLED_POSE_L, LED_POSE_M=>TBLED_POSE_M, LED_POSE_R=>TBLED_POSE_R
		,LED_TANK=>TBLED_TANK, LED_WATER_L=>TBLED_WATER_L, LED_WATER_H=>TBLED_WATER_H
	);

	process begin
		TBCLK <= '1' ;wait for 50 ns;
		TBCLK <= '0' ;wait for 50 ns;
	end process;

	process begin
		TBRSTN <= '0' ;wait for 50 ns;
		TBRSTN <= '1' ;wait;
	end process;

	process begin
		TBSTARTN <= '1' ; wait for 1050 ns;
		TBSTARTN <= '0' ; wait;
	end process;
end TESTBENCH;

configuration CFG_TB_SHISHIODOSHI_TOP of TB_SHISHIODOSHI_TOP is
	for TESTBENCH
		for U1: SHISHIODOSHI_TOP
		end for;
	end for;
end;
		
