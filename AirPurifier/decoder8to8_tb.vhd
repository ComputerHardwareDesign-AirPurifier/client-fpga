--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:10:47 05/26/2022
-- Design Name:   
-- Module Name:   C:/Users/Phol/Documents/ComHardAssignment/AirPurifier/decoder8to8_tb.vhd
-- Project Name:  AirPurifier
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decoder8to8
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY decoder8to8_tb IS
END decoder8to8_tb;
 
ARCHITECTURE behavior OF decoder8to8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder8to8
    PORT(
         input_rx : IN  std_logic_vector(7 downto 0);
         output_duty : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input_rx : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal output_duty : std_logic_vector(7 downto 0);
   -- No clks detected in port list. Replace <clk> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder8to8 PORT MAP (
          input_rx => input_rx,
          output_duty => output_duty
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		input_rx<="00110010";
		wait for clk_period*30;
		input_rx<="01001011";
		wait for clk_period*30;
		input_rx<="01100100";
      wait;
   end process;

END;
