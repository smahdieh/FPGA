----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:37:31 05/17/2023 
-- Design Name: 
-- Module Name:    MemoryDataRegister - Behavioral 
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

entity MemoryDataRegister is
    Port ( clk 			: in  STD_LOGIC;
           rst 			: in  STD_LOGIC;
           mem_input 	: in  STD_LOGIC_VECTOR (31 downto 0);
           mem_output 	: out  STD_LOGIC_VECTOR (31 downto 0));
end MemoryDataRegister;

architecture Behavioral of MemoryDataRegister is

type mem_data_type is array (0 downto 0) of std_logic_vector(31 downto 0);
signal MemDataReg: mem_data_type := ((others => (others => '0')));

begin

	process(clk)
	begin
		if rst = '0' then
			MemDataReg(0) <= (others => '0');
		else if rising_edge(clk) then
			MemDataReg(0) <= mem_input;
		end if;
		end if;
	end process;
	mem_output <= MemDataReg(0);
	
end Behavioral;

