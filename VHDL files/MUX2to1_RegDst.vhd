----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:51:14 05/16/2023 
-- Design Name: 
-- Module Name:    MUX2to1_RegDst - Behavioral 
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

entity MUX3to1_RegDst is
    Port ( a : in  STD_LOGIC_VECTOR (4 downto 0);
           b : in  STD_LOGIC_VECTOR (4 downto 0);
			  c : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX3to1_RegDst;

architecture Behavioral of MUX3to1_RegDst is

begin

	process(a, b, c, sel)
	begin
		if sel = '00' then
			output <= a;
		elsif sel = '01' then
			output <= b;
		elsif sel = '10' then
			output <= c;
		else
			output <= (others => '0');
		end if;
	end process;

end Behavioral;

