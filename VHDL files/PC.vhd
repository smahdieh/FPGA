----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:01 05/16/2023 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( CLK 		: in  STD_LOGIC;
           EN 			: in  STD_LOGIC;
           PC_input 	: in  STD_LOGIC_VECTOR(31 downto 0);
			  RST			: in  STD_LOGIC;
           PC_output : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end PC;

architecture Behavioral of PC is

begin
	
	process(CLK)
	begin
		if(RST = '0') then 
				PC_output <= (others => '0');
		elsif(rising_edge(CLK)) then
			if(EN = '1') then 
				PC_output <= PC_input;
			end if;
		end if;
	end process;

end Behavioral;

