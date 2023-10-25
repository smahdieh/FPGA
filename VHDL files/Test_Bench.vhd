--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:29:15 05/17/2023
-- Design Name:   
-- Module Name:   C:/Users/IS PC/Desktop/MultiCycleMIPS/test_bench.vhd
-- Project Name:  MultiCycleMIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MIPS_Processor
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
 
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPS_Processor
    PORT(
         CLKmain 		: IN  std_logic;
         RSTMain 		: IN  std_logic;
         output_top 	: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLKmain : std_logic := '0';
   signal RSTMain : std_logic := '0';

 	--Outputs
   signal output_top : std_logic;

   -- Clock period definitions
   constant CLKmain_period : time := 2.5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPS_Processor PORT MAP (
          CLKmain 	=> CLKmain,
          RSTMain 	=> RSTMain,
          output_top => output_top
        );
	reset_process: process
   begin
		RSTMain <= '0';
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		RSTMain <= '1';
      wait;
   end process reset_process;
	
   -- Clock process definitions
   CLKmain_process :process
   begin
		CLKmain <= '0';
		wait for CLKmain_period/2;
		CLKmain <= '1';
		wait for CLKmain_period/2;
   end process CLKmain_process;

END;
