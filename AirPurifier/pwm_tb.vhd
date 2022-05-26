--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:45:04 05/24/2022
-- Design Name:   
-- Module Name:   C:/Users/Phol/Documents/ComHardAssignment/AirPurifier/pwm_tb.vhd
-- Project Name:  AirPurifier
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pwm
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
 
ENTITY pwm_tb IS
END pwm_tb;
 
ARCHITECTURE behavior OF pwm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pwm
	   GENERIC(
      sys_clk         : INTEGER := 20_000_000; --system clock frequency in Hz
      pwm_freq        : INTEGER := 100;    --PWM switching frequency in Hz
      bits_resolution : INTEGER := 8;          --bits of resolution setting the duty cycle
      phases          : INTEGER := 1);         --number of output pwms and phases
    PORT(
      clk       : IN  STD_LOGIC;                                    --system clock
      reset_n   : IN  STD_LOGIC;                                    --asynchronous reset
      ena       : IN  STD_LOGIC;                                    --latches in new duty cycle
      duty      : IN  STD_LOGIC_VECTOR(bits_resolution-1 DOWNTO 0); --duty cycle
      pwm_out   : OUT STD_LOGIC_VECTOR(phases-1 DOWNTO 0);          --pwm outputs
      pwm_n_out : OUT STD_LOGIC_VECTOR(phases-1 DOWNTO 0));         --pwm inverse outputs
    END COMPONENT;
    

   --Inputs
	constant bits_resolution: INTEGER := 8;
   signal clk : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal ena : std_logic := '0';
   signal duty : std_logic_vector(bits_resolution-1 DOWNTO 0) := (others => '0');

 	--Outputs
	constant phases: INTEGER := 1;
   signal pwm_out : std_logic_vector(phases-1 DOWNTO 0);
   signal pwm_n_out : std_logic_vector(phases-1 DOWNTO 0);

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pwm PORT MAP (
          clk => clk,
          reset_n => reset_n,
          ena => ena,
          duty => duty,
          pwm_out => pwm_out,
          pwm_n_out => pwm_n_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
      -- hold reset state for 100 ns.
		reset_n<='0';
		wait for 100 ns;
		reset_n<='1';
		ena<='1';
      -- insert stimulus here 

		wait for 100 ns;
		duty<="10000000";
		wait for 50 ms;
		duty<="10111111";
		wait for 50 ms;
		duty<="11111111";

		wait;
   end process;

END;
