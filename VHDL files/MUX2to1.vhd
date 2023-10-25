----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:38:13 05/16/2023 
-- Design Name: 
-- Module Name:    MUX2to1 - Behavioral 
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

entity MUX2to1 is
    Port ( a 		: in  STD_LOGIC_VECTOR (31 downto 0);
           b 		: in  STD_LOGIC_VECTOR (31 downto 0);
           sel 	: in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX2to1;

architecture Behavioral of MUX2to1 is

begin

	process(a,b,sel)
	begin
		if sel = '0' then
			output <= a;
		elsif sel = '1' then
			output <= b;
		end if;
	end process;

end Behavioral;

