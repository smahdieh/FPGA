----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:35:59 05/16/2023 
-- Design Name: 
-- Module Name:    Sign_Extended - Behavioral 
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

entity Sign_Extended is
    Port ( input 	: in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Sign_Extended;

architecture Behavioral of Sign_Extended is

begin

	process(input)
	begin
		if input(15)='0' then
			output(15 downto 0) <= input;
			output(31 downto 16) <= "0000000000000000";
		else
			output(15 downto 0) <= input;
			output(31 downto 16) <= "1111111111111111";
		end if;
	end process;

end Behavioral;

