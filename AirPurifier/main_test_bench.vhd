--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:39:58 05/24/2022
-- Design Name:   
-- Module Name:   C:/Users/Phol/Documents/ComHardAssignment/AirPurifier/main_test_bench.vhd
-- Project Name:  AirPurifier
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main
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
 
ENTITY main_test_bench IS
END main_test_bench;
 
ARCHITECTURE behavior OF main_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         main_clk : IN  std_logic;
         pwm_reset_n : IN  std_logic;
         pwm_ena : IN  std_logic;
         pwm_pwm_out : OUT  std_logic_vector(0 downto 0);
         pwm_pwm_n_out : OUT  std_logic_vector(0 downto 0);
         uart_reset_n : IN  std_logic;
         uart_tx_ena : IN  std_logic;
         uart_tx_data : IN  std_logic_vector(7 downto 0);
         uart_rx : IN  std_logic;
         uart_rx_busy : OUT  std_logic;
         uart_rx_error : OUT  std_logic;
         uart_tx_busy : OUT  std_logic;
         uart_tx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal main_clk : std_logic := '0';
   signal pwm_reset_n : std_logic := '0';
   signal pwm_ena : std_logic := '0';
   signal uart_reset_n : std_logic := '0';
   signal uart_tx_ena : std_logic := '0';
   signal uart_tx_data : std_logic_vector(7 downto 0) := (others => '0');
   signal uart_rx : std_logic := '0';

 	--Outputs
   signal pwm_pwm_out : std_logic_vector(0 downto 0);
   signal pwm_pwm_n_out : std_logic_vector(0 downto 0);
   signal uart_rx_busy : std_logic;
   signal uart_rx_error : std_logic;
   signal uart_tx_busy : std_logic;
   signal uart_tx : std_logic;

   -- Clock period definitions
   constant main_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          main_clk => main_clk,
          pwm_reset_n => pwm_reset_n,
          pwm_ena => pwm_ena,
          pwm_pwm_out => pwm_pwm_out,
          pwm_pwm_n_out => pwm_pwm_n_out,
          uart_reset_n => uart_reset_n,
          uart_tx_ena => uart_tx_ena,
          uart_tx_data => uart_tx_data,
          uart_rx => uart_rx,
          uart_rx_busy => uart_rx_busy,
          uart_rx_error => uart_rx_error,
          uart_tx_busy => uart_tx_busy,
          uart_tx => uart_tx
        );

   -- Clock process definitions
   main_clk_process :process
   begin
		main_clk <= '0';
		wait for main_clk_period/2;
		main_clk <= '1';
		wait for main_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		pwm_reset_n<='1';
		pwm_ena<='1';
      wait for main_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
