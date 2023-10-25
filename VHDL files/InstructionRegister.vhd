----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:20:28 05/17/2023 
-- Design Name: 
-- Module Name:    InstructionRegister - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionRegister is
    Port ( clk 						: in  STD_LOGIC;
           rst 						: in  STD_LOGIC;
           IRWrite				 	: in  STD_LOGIC;
           input_instruction 		: in  STD_LOGIC_VECTOR (31 downto 0);
           output_instruction 	: out  STD_LOGIC_VECTOR (31 downto 0));
end InstructionRegister;

architecture Behavioral of InstructionRegister is
type instr_reg_type is array (0 to 0) of std_logic_vector(31 downto 0);
signal instr_reg : instr_reg_type := ((others => (others => '0')));

begin

	process(clk)
	begin
		if rst = '0' then
			instr_reg(0) <= (others => '0');
		else if rising_edge(clk) and IRWrite = '1' then
			instr_reg(0) <= input_instruction;
		end if;
		end if;
	end process;
	output_instruction <= instr_reg(0);
end Behavioral;

