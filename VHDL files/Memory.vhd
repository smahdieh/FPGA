----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:08:48 05/16/2023 
-- Design Name: 
-- Module Name:    Memory - Behavioral 
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

entity Memory is
    Port ( memory_read 	: in  STD_LOGIC;
           memory_write : in  STD_LOGIC;
           address 		: in  STD_LOGIC_VECTOR (31 downto 0);
           write_data 	: in  STD_LOGIC_VECTOR (31 downto 0);
           clk 			: in  STD_LOGIC;
			  rst				: in  STD_LOGIC;
           memory_data 	: out  STD_LOGIC_VECTOR (31 downto 0));
end Memory;

architecture Behavioral of Memory is

type A is  array ( 0 to 63) of STD_LOGIC_VECTOR(7 downto 0);
signal mem: A := (
-- auto generated
-- lw $R0,47($R20)
0 => "10001110",
1 => "10000000",
2 => "00000000",
3 => "00101111",

-- addi $R1,$R3,50
4 => "00100000",
5 => "01100001",
6 => "00000000",
7 => "00110010",

-- addi $R2,$R3,48
8 => "00100000",
9 => "01100010",
10 => "00000000",
11 => "00110000",

-- add $R2,$R2,$R0
12 => "00000000",
13 => "01000000",
14 => "00010000",
15 => "00100000",

-- beq $R1,$R2,1
16 => "00010000",
17 => "00100010",
18 => "00000000",
19 => "00000001",

-- j 3
20 => "00001000",
21 => "00000000",
22 => "00000000",
23 => "00000011",

-- add $R0,$R1,$R2
24 => "00000000",
25 => "00100010",
26 => "00000000",
27 => "00100000",

-- lw $R10,47($R20)
28 => "10001110",
29 => "10001010",
30 => "00000000",
31 => "00101111",

50 => "00000001",

others => "00000000" );

begin

	process(clk, rst)
	begin
		---if rst = '0' then
		---	mem <= (others => (others => '0'));
		---end if;
		if rising_edge(clk) and memory_write = '1' then
			mem(to_integer(unsigned(address)))     <= write_data(31 downto 24);
			mem(to_integer(unsigned(address) + 1)) <= write_data(23 downto 16);
			mem(to_integer(unsigned(address) + 2)) <= write_data(15 downto 8);
			mem(to_integer(unsigned(address) + 3)) <= write_data(7 downto 0);
		end if;
	end process;
	
	memory_data <= mem(to_integer(unsigned(address))) &
						mem(to_integer(unsigned(address) + 1)) &
						mem(to_integer(unsigned(address) + 2)) &
						mem(to_integer(unsigned(address) + 3)) when memory_read = '1';
end Behavioral;

