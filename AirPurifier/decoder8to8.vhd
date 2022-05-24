library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity decoder8to8 is
 port(
 input_rx : in STD_LOGIC_VECTOR(7 downto 0);
 output_duty : out STD_LOGIC_VECTOR(7 downto 0)
 );
end decoder8to8;
 
architecture bhv of decoder8to8 is
begin
 
process(input_rx)
begin

 if (input_rx="00110010") then --50%--
 output_duty <= "10000000";
 elsif (input_rx="01001011") then --75%--
 output_duty <= "10111111";
 elsif (input_rx="01100100") then --100%--
 output_duty <= "11111111";
 else
 output_duty <= "00000000";
 end if;
end process;
 
end bhv;