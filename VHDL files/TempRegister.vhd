----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:20 05/17/2023 
-- Design Name: 
-- Module Name:    TempRegister - Behavioral 
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

entity TempRegister is
    Port ( clk 		: in  STD_LOGIC;
           rst 		: in  STD_LOGIC;
           input 		: in  STD_LOGIC_VECTOR (31 downto 0);
           output 	: out  STD_LOGIC_VECTOR (31 downto 0));
end TempRegister;

architecture Behavioral of TempRegister is

type registers is array (0 to 0) of std_logic_vector(31 downto 0);
signal data : registers := ((others => (others => '0')));
  
begin
	process(CLK)
	begin
		if rst = '0' then -- reset
			data(0) <= (others => '0');
		else if rising_edge(CLK) then
			data(0) <= input;
		end if;
		end if;
  end process;
  output <= data(0);
end Behavioral;

