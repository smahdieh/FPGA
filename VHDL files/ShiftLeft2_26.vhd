----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:17:46 05/17/2023 
-- Design Name: 
-- Module Name:    ShiftLeft2_26 - Behavioral 
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

entity ShiftLeft2_26 is
    Port ( input 	: in  STD_LOGIC_VECTOR (25 downto 0);
           output : out  STD_LOGIC_VECTOR (27 downto 0));
end ShiftLeft2_26;

architecture Behavioral of ShiftLeft2_26 is

begin
	output <= input & "00";

end Behavioral;

