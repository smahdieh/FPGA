----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:08:18 05/17/2023 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( a 				: in  STD_LOGIC_VECTOR (31 downto 0);
           b 				: in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_control 	: in  STD_LOGIC_VECTOR (3 downto 0);
           output 		: out  STD_LOGIC_VECTOR (31 downto 0);
           zero 			: out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
 signal temp : std_logic_vector(31 downto 0);

begin

  temp <=
    -- add
    std_logic_vector(unsigned(a) + unsigned(b)) when ALU_control = "0000" else
    -- sub
    std_logic_vector(unsigned(a) - unsigned(b)) when ALU_control = "0001" else
    -- AND
    a AND  b when ALU_control = "0010" else
    -- OR
    a OR   b when ALU_control = "0011" else
    -- NOR
    a NOR  b when ALU_control = "0100" else
    -- XOR
    a XOR b when ALU_control = "0101" else
	 -- set on less than
	 "00000000000000000000000000000001" when ALU_control = "0110" and (a < b) else
	 "00000000000000000000000000000000" when ALU_control = "0110" and (a >= b) else
	 -- lui
	 (b(15 downto 0) & "0000000000000000") when ALU_control = "0111" else
	 -- in other cases
    (others => '0');

  zero <= '1' when temp <= "00000000000000000000000000000000" else '0';
  output <= temp;

end Behavioral;

