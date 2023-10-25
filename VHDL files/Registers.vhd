----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:47:40 05/17/2023 
-- Design Name: 
-- Module Name:    Registers - Behavioral 
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

entity Registers is
    Port ( clk 				: in  STD_LOGIC;
           rst 				: in  STD_LOGIC;
           read_register1 	: in  STD_LOGIC_VECTOR (4 downto 0);
           read_register2 	: in  STD_LOGIC_VECTOR (4 downto 0);
           write_register 	: in  STD_LOGIC_VECTOR (4 downto 0);
           write_data 		: in  STD_LOGIC_VECTOR (31 downto 0);
           RegWrite 			: in  STD_LOGIC;
           read_data1 		: out  STD_LOGIC_VECTOR (31 downto 0);
           read_data2 		: out  STD_LOGIC_VECTOR (31 downto 0));
end Registers;

architecture Behavioral of Registers is

type reg_type is array (0 to 31) of std_logic_vector(31 downto 0);
signal reg : reg_type;

begin

	process(clk)
	begin
		if rst = '0' then
			reg <= (others => (others => '0'));
		else if rising_edge(clk) and RegWrite = '1' then
			reg(to_integer(unsigned(write_register))) <= write_data;
		end if;
		end if;
	end process;
	
	read_data1 <= reg(to_integer(unsigned(read_register1)));
	read_data2 <= reg(to_integer(unsigned(read_register2)));
	
end Behavioral;

