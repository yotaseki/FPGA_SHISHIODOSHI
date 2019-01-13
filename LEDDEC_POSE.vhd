library ieee;
use ieee.std_logic_1164.all;

entity LEDDEC_POSE is
	port (
		POSE_ID		: in std_logic_vector(1 downto 0);
		LED_POSE_L	: out std_logic_vector(6 downto 0);
		LED_POSE_M	: out std_logic_vector(6 downto 0);
		LED_POSE_R	: out std_logic_vector(6 downto 0)
	);
end LEDDEC_POSE;

architecture RTL of LEDDEC_POSE is
begin 
	process(POSE_ID)
	begin
		if(POSE_ID = "00")then
			LED_POSE_L <= "1111110";
			LED_POSE_M <= "0111111";
			LED_POSE_R <= "1110111";
		elsif(POSE_ID = "01")then
			LED_POSE_L <= "0111111";
			LED_POSE_M <= "0111111";
			LED_POSE_R <= "0111111";
		elsif(POSE_ID = "10")then
			LED_POSE_L <= "1110111";
			LED_POSE_M <= "0111111";
			LED_POSE_R <= "1111110";
		else
			LED_POSE_L <= "1111110";
			LED_POSE_M <= "0111111";
			LED_POSE_R <= "1110111";
		end if;
	end process;
end RTL;

