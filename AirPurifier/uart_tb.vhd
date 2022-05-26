--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:27:59 05/26/2022
-- Design Name:   
-- Module Name:   C:/Users/Phol/Documents/ComHardAssignment/AirPurifier/uart_tb.vhd
-- Project Name:  AirPurifier
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: uart
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
 
ENTITY uart_tb IS
END uart_tb;
 
ARCHITECTURE behavior OF uart_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uart
	   GENERIC(
 --uart
		clk_freq  : INTEGER := 20_000_000;  --frequency of system clock in Hertz
		baud_rate :  INTEGER    := 19_200;     --data link baud rate in bits/second
		os_rate   :  INTEGER    := 16;           --oversampling rate to find center of receive bits (in samples per baud period)
		d_width   :  INTEGER    := 8;           --data bus width
		parity    :  INTEGER    := 0;           --0 for no parity, 1 for parity
		parity_eo :  STD_LOGIC  := '0');        --'0' for even, '1' for odd parity
    PORT(
         clk : IN  std_logic;
         reset_n : IN  std_logic;
         tx_ena : IN  std_logic;
         tx_data : IN  std_logic_vector(7 downto 0);
         rx : IN  std_logic;
         rx_busy : OUT  std_logic;
         rx_error : OUT  std_logic;
         rx_data : OUT  std_logic_vector(7 downto 0);
         tx_busy : OUT  std_logic;
         tx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal tx_ena : std_logic := '0';
   signal tx_data : std_logic_vector(7 downto 0) := (others => '0');
   signal rx : std_logic := '0';

 	--Outputs
   signal rx_busy : std_logic;
   signal rx_error : std_logic;
   signal rx_data : std_logic_vector(7 downto 0);
   signal tx_busy : std_logic;
   signal tx : std_logic;
	signal test_receive: std_logic;

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut_tx : uart

	PORT MAP (
          clk => clk,
          reset_n => reset_n,
          tx_ena => tx_ena,
          tx_data => tx_data,
          rx => rx,
          rx_busy => rx_busy,
          rx_error => rx_error,
          rx_data => rx_data,
          tx_busy => tx_busy,
          tx => test_receive
        );
	uut_rx: uart
	PORT MAP (
          clk => clk,
          reset_n => reset_n,
          tx_ena => tx_ena,
          tx_data => tx_data,
          rx => test_receive,
          rx_busy => rx_busy,
          rx_error => rx_error,
          rx_data => rx_data,
          tx_busy => tx_busy,
          tx => tx
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
      wait for 100 ns;	
		reset_n<='0';
		wait for clk_period*10;
	
		reset_n <='1';
		wait for clk_period*10;
      -- insert stimulus here 
		
		tx_ena <='1';
		tx_data<="00110010";
		wait for clk_period*10;
		tx_ena<='0';
		wait until tx_busy = '0' ;
		wait for clk_period*10;

		
		
		tx_ena<='1';
		tx_data<="01001011";
		wait for clk_period*10;
		tx_ena<='0';
		wait until tx_busy = '0'  ;
		wait for clk_period*10;

		
		tx_ena<='1';
		tx_data<="01100100";
		wait for clk_period*10;
		tx_ena<='0';
		wait until tx_busy = '0';

		
      wait;
   end process;

END;
