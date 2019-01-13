library ieee;
use ieee.std_logic_1164.all;

entity SHISHIODOSHI_TOP is
	port (
		CLK, RSTN		: in std_logic;
		STARTN			: in std_logic;
		UPSWN, DOWNSWN	: in std_logic;
		LED_POSE_L		: out std_logic_vector(6 downto 0);
		LED_POSE_M		: out std_logic_vector(6 downto 0);
		LED_POSE_R		: out std_logic_vector(6 downto 0);
		LED_TANK		: out std_logic_vector(6 downto 0);
		LED_WATER_L		: out std_logic_vector(6 downto 0);
		LED_WATER_H		: out std_logic_vector(6 downto 0)
	);
end SHISHIODOSHI_TOP;

architecture RTL of SHISHIODOSHI_TOP is
	signal TSTARTN			: std_logic;
	signal TCOUNTING		: std_logic;
	signal TUPSWN, TDOWNSWN	: std_logic;
	signal TENABLE			: std_logic;
	signal TWATER			: std_logic_vector(3 downto 0);
	signal TPOSE_ID			: std_logic_vector(1 downto 0);
	signal TTANK_METER		: std_logic_vector(1 downto 0);

	component STARTSTOP port(
		CLK, RSTN		: in std_logic;
		STARTN			: in std_logic;
		COUNTING		: out std_logic
	);
	end component;
	component ONESHOT port(
		CLK,RSTN	: in std_logic;
		SWN			: in std_logic;
		SWONEN		: out std_logic
	);
	end component;
	component CLKDOWN port(
		CLK,RSTN	: in std_logic;
		COUNTING	: in std_logic;
		ENABLE		: out std_logic
	);
	end component;
	component HOSE port(
		CLK,RSTN		: in std_logic;
		UPSWN,DOWNSWN	: in std_logic;
		WATER			: out std_logic_vector(3 downto 0)
	);
	end component;
	component SHISHIODOSHI port(
		CLK, RSTN		: in std_logic;
		ENABLE_250MSEC	: in std_logic;
		WATER			: in std_logic_vector(3 downto 0);
		POSE_ID			: out std_logic_vector(1 downto 0);
		TANK_METER		: out std_logic_vector(1 downto 0)
	);
	end component;
	component LEDDEC_POSE port(
		POSE_ID		: in std_logic_vector(1 downto 0);
		LED_POSE_L	: out std_logic_vector(6 downto 0);
		LED_POSE_M	: out std_logic_vector(6 downto 0);
		LED_POSE_R	: out std_logic_vector(6 downto 0)
	);
	end component;
	component LEDDEC_TANK port(
		TANK_METER	: in std_logic_vector(1 downto 0);
		LED_TANK	: out std_logic_vector(6 downto 0)
	);
	end component;
	component LEDDEC_HOSE port(
		WATER	: in std_logic_vector(3 downto 0);
		LEDL	: out std_logic_vector(6 downto 0);
		LEDH	: out std_logic_vector(6 downto 0)
	);
	end component;
begin
	U0:	ONESHOT port map(
		CLK=>CLK, RSTN=>RSTN, SWN=>STARTN, SWONEN=>TSTARTN 
	);
	U1: STARTSTOP port map(
		CLK=>CLK, RSTN=>RSTN, STARTN=>TSTARTN, COUNTING=>TCOUNTING
	);
	U2:	ONESHOT port map(
		CLK=>CLK, RSTN=>RSTN, SWN=>UPSWN, SWONEN=>TUPSWN 
	);
	U3:	ONESHOT port map(
		CLK=>CLK, RSTN=>RSTN, SWN=>DOWNSWN, SWONEN=>TDOWNSWN 
	);
	U4: CLKDOWN port map(
		CLK=>CLK, RSTN=>RSTN, COUNTING=>TCOUNTING, ENABLE=>TENABLE
	);
	U5: HOSE port map(
		CLK=>CLK, RSTN=>RSTN, UPSWN=>TUPSWN, DOWNSWN=>TDOWNSWN, WATER=>TWATER
	);
	U6: SHISHIODOSHI port map(
		CLK=>CLK, RSTN=>RSTN, ENABLE_250MSEC=>TENABLE, WATER=>TWATER, POSE_ID=>TPOSE_ID, TANK_METER=>TTANK_METER
	);
	U7: LEDDEC_POSE port map(
		POSE_ID=>TPOSE_ID, LED_POSE_L=>LED_POSE_L, LED_POSE_M=>LED_POSE_M, LED_POSE_R=>LED_POSE_R
	);
	U8: LEDDEC_TANK port map(
		TANK_METER=>TTANK_METER, LED_TANK=>LED_TANK
	);
	U9: LEDDEC_HOSE port map(
		WATER=>TWATER, LEDL=>LED_WATER_L, LEDH=>LED_WATER_H
	);
end RTL;
