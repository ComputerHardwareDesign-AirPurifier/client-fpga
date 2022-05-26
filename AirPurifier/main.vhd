

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:28:51 05/23/2022 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
  GENERIC(
 --pwm
      main_sys_clk         : INTEGER := 20_000_000; --system clock frequency in Hz
      pwm_pwm_freq        : INTEGER := 100;    --PWM switching frequency in Hz
      pwm_bits_resolution : INTEGER := 8;          --bits of resolution setting the duty cycle
      pwm_phases          : INTEGER := 1;         --number of output pwms and phases
 --uart
		uart_baud_rate :  INTEGER    := 19_200;      --data link baud rate in bits/second
		uart_os_rate   :  INTEGER    := 16;          --oversampling rate to find center of receive bits (in samples per baud period)
		uart_d_width   :  INTEGER    := 8;           --data bus width
		uart_parity    :  INTEGER    := 0;           --0 for no parity, 1 for parity
		uart_parity_eo :  STD_LOGIC  := '0');        --'0' for even, '1' for odd parity
  PORT(
 --pwm
      main_clk       : IN  STD_LOGIC;                                    --system clock
      pwm_reset_n   : IN  STD_LOGIC;                                    --asynchronous reset
      pwm_ena       : IN  STD_LOGIC;                                    --latches in new duty cycle
--    pwm_duty      : IN  STD_LOGIC_VECTOR(bits_resolution-1 DOWNTO 0); --duty cycle
      pwm_pwm_out   : OUT STD_LOGIC_VECTOR(pwm_phases-1 DOWNTO 0);          --pwm outputs
		pwm_pwm_n_out : OUT STD_LOGIC_VECTOR(pwm_phases-1 DOWNTO 0);         --pwm inverse outputs
 --uart
		uart_reset_n  :  IN   STD_LOGIC;                             --ascynchronous reset
		uart_tx_ena   :  IN   STD_LOGIC;                             --initiate transmission
		uart_tx_data  :  IN   STD_LOGIC_VECTOR(uart_d_width-1 DOWNTO 0);  --data to transmit
		uart_rx       :  IN   STD_LOGIC;                             --receive pin
		uart_rx_busy  :  OUT  STD_LOGIC;                             --data reception in progress
		uart_rx_error :  OUT  STD_LOGIC;                             --start, parity, or stop bit error detected
--		uart_rx_data  :  OUT  STD_LOGIC_VECTOR(uart_d_width-1 DOWNTO 0);  --data received
		uart_tx_busy  :  OUT  STD_LOGIC;                             --transmission in progress
		uart_tx       :  OUT  STD_LOGIC); 
end main;

architecture Behavioral of main is
	signal pwm_duty_rx:STD_LOGIC_VECTOR(uart_d_width-1 DOWNTO 0); 
	signal rx_to_decoder:STD_LOGIC_VECTOR(uart_d_width-1 DOWNTO 0);
	
component decoder8to8 is
 port(
 input_rx : in STD_LOGIC_VECTOR(7 downto 0);
 output_duty : out STD_LOGIC_VECTOR(7 downto 0)
 );
end component;

component pwm is
  GENERIC(
      sys_clk         : INTEGER ; --system clock frequency in Hz
      pwm_freq        : INTEGER ;    --PWM switching frequency in Hz
      bits_resolution : INTEGER ;          --bits of resolution setting the duty cycle
      phases          : INTEGER);         --number of output pwms and phases
  PORT(
      clk       : IN  STD_LOGIC;                                    --system clock
      reset_n   : IN  STD_LOGIC;                                    --asynchronous reset
      ena       : IN  STD_LOGIC;                                    --latches in new duty cycle
      duty      : IN  STD_LOGIC_VECTOR(bits_resolution-1 DOWNTO 0); --duty cycle
      pwm_out   : OUT STD_LOGIC_VECTOR(phases-1 DOWNTO 0);          --pwm outputs
      pwm_n_out : OUT STD_LOGIC_VECTOR(phases-1 DOWNTO 0));         --pwm inverse outputs
end component;

component uart is
  GENERIC(
    clk_freq  :  INTEGER;  --frequency of system clock in Hertz
    baud_rate :  INTEGER;      --data link baud rate in bits/second
    os_rate   :  INTEGER;          --oversampling rate to find center of receive bits (in samples per baud period)
    d_width   :  INTEGER;           --data bus width
    parity    :  INTEGER;           --0 for no parity, 1 for parity
    parity_eo :  STD_LOGIC);        --'0' for even, '1' for odd parity
  PORT(
    clk      :  IN   STD_LOGIC;                             --system clock
    reset_n  :  IN   STD_LOGIC;                             --ascynchronous reset
    tx_ena   :  IN   STD_LOGIC;                             --initiate transmission
    tx_data  :  IN   STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
    rx       :  IN   STD_LOGIC;                             --receive pin
    rx_busy  :  OUT  STD_LOGIC;                             --data reception in progress
    rx_error :  OUT  STD_LOGIC;                             --start, parity, or stop bit error detected
    rx_data  :  OUT  STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data received
    tx_busy  :  OUT  STD_LOGIC;                             --transmission in progress
    tx       :  OUT  STD_LOGIC);   
end component;
 
begin
 --pwm
	pwm_module: pwm
    generic map(
      sys_clk =>main_sys_clk  , --system clock frequency in Hz
      pwm_freq =>pwm_pwm_freq ,    --PWM switching frequency in Hz
      bits_resolution => pwm_bits_resolution,         --bits of resolution setting the duty cycle
      phases => pwm_phases
		)
    port map(
      clk => main_clk,           --system clock
      reset_n => pwm_reset_n,                                --asynchronous reset
      ena=> pwm_ena,                                      --latches in new duty cycle
      duty=>pwm_duty_rx,     --duty cycle
      pwm_out=>pwm_pwm_out,      --pwm outputs
		pwm_n_out =>pwm_pwm_n_out 
		);
 --uart
  uart_module : uart
    generic map(
    clk_freq =>main_sys_clk , --frequency of system clock in Hertz
    baud_rate=>uart_baud_rate,      --data link baud rate in bits/second
    os_rate =>uart_os_rate   ,    --oversampling rate to find center of receive bits (in samples per baud period)
    d_width =>uart_d_width    ,       --data bus width
    parity  =>uart_parity      ,     --0 for no parity, 1 for parity
    parity_eo=>uart_parity_eo
		)
    port map(
    clk  => main_clk,                            --system clock
    reset_n  =>uart_reset_n,                          --ascynchronous reset
    tx_ena  => uart_tx_ena,                     --initiate transmission
    tx_data => uart_tx_data, --data to transmit
    rx      => uart_rx ,                           --receive pin
    rx_busy =>uart_rx_busy ,                         --data reception in progress
    rx_error=>uart_rx_error,                        --start, parity, or stop bit error detected
    rx_data =>rx_to_decoder,  --data received
    tx_busy =>uart_tx_busy ,                       --transmission in progress
    tx      => uart_tx
		);

	decoder8to8_module: decoder8to8
	port map(
	input_rx=>rx_to_decoder,
	output_duty=>pwm_duty_rx
	);
		
	
end Behavioral;




