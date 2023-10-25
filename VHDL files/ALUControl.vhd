----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:24:47 05/17/2023 
-- Design Name: 
-- Module Name:    ALUControl - Behavioral 
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

entity ALUControl is
    Port ( instruction 	: in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOp 			: in  STD_LOGIC_VECTOR (2 downto 0);
           output 		: out STD_LOGIC_VECTOR (3 downto 0));
end ALUControl;

architecture Behavioral of ALUControl is
signal temp, operation, operation_i : std_logic_vector(3 downto 0) := "1111";

begin
	  with ALUOp select
    temp <= "0000"      when "000",    -- addi for LW
            "0101"      when "001",    -- xori / Branch
            operation   when "010",    -- R-type
				"0110"      when "011",    -- slti
				"0010"      when "100",    -- andi
				"0011"      when "101",    -- ori
				"0111"      when "110",    -- lui
            "1111"      when others;   -- in other cases

  with instruction select
    operation <= "0000" when "100000", -- add
                 "0001" when "100010", -- sub
                 "0010" when "100100", -- AND
                 "0011" when "100101", -- OR
                 "0100" when "100111", -- NOR
                 "0101" when "100110", -- XOR
                 "0110" when "101010", -- set on less than
                 "1111" when others;
  output <= temp;
end Behavioral;

