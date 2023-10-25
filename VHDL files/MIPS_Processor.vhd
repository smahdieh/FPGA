----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:59:26 05/16/2023 
-- Design Name: 
-- Module Name:    MIPS_Processor - Behavioral 
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

entity MIPS_Processor is
    Port ( CLKmain, RSTMain : in  STD_LOGIC;
				output_top : out STD_LOGIC);
end MIPS_Processor;

architecture Behavioral of MIPS_Processor is

COMPONENT PC
    Port ( CLK       : in  STD_LOGIC;
           EN        : in  STD_LOGIC;
           PC_input  : in  STD_LOGIC_VECTOR(31 downto 0);
			  RST       : in  STD_LOGIC;
           PC_output : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end COMPONENT;

COMPONENT MUX2to1
    Port ( a        	: in  STD_LOGIC_VECTOR (31 downto 0);
           b        	: in  STD_LOGIC_VECTOR (31 downto 0);
           sel      	: in  STD_LOGIC;
           output   	: out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT MUX3to1
    Port ( a 			: in  STD_LOGIC_VECTOR (31 downto 0);
           b 			: in  STD_LOGIC_VECTOR (31 downto 0);
           c 			: in  STD_LOGIC_VECTOR (31 downto 0);
           sel 		: in  STD_LOGIC_VECTOR (1 downto 0);
           output 	: out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT MUX4to1
    Port ( a 			: in  STD_LOGIC_VECTOR (31 downto 0);
           b 			: in  STD_LOGIC_VECTOR (31 downto 0);
           c 			: in  STD_LOGIC_VECTOR (31 downto 0);
           d 			: in  STD_LOGIC_VECTOR (31 downto 0);
           sel 		: in  STD_LOGIC_VECTOR (1 downto 0);
           output 	: out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT MUX3to1_RegDst
    Port ( a 			: in  STD_LOGIC_VECTOR (4 downto 0);
           b 			: in  STD_LOGIC_VECTOR (4 downto 0);
           c 			: in  STD_LOGIC_VECTOR (4 downto 0);
           sel 		: in  STD_LOGIC_VECTOR (1 downto 0);
           output 	: out STD_LOGIC_VECTOR (4 downto 0));
end COMPONENT;

COMPONENT ShiftLeft2_32
    Port ( input 		: in  STD_LOGIC_VECTOR (31 downto 0);
           output 	: out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT ShiftLeft2_26
    Port ( input 		: in  STD_LOGIC_VECTOR (25 downto 0);
           output 	: out STD_LOGIC_VECTOR (27 downto 0));
end COMPONENT;

COMPONENT Sign_Extended
    Port ( input 		: in  STD_LOGIC_VECTOR (15 downto 0);
           output 	: out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT Memory
    Port ( memory_read 	: in  STD_LOGIC;
           memory_write : in  STD_LOGIC;
           address 		: in  STD_LOGIC_VECTOR (31 downto 0);
           write_data 	: in  STD_LOGIC_VECTOR (31 downto 0);
           clk 			: in  STD_LOGIC;
			  rst				: in  STD_LOGIC;
           memory_data 	: out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT InstructionRegister
    Port ( clk 					: in  STD_LOGIC;
           rst 					: in  STD_LOGIC;
           IRWrite 				: in  STD_LOGIC;
           input_instruction 	: in  STD_LOGIC_VECTOR (31 downto 0);
           output_instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT MemoryDataRegister
    Port ( clk 					: in  STD_LOGIC;
           rst 					: in  STD_LOGIC;
           mem_input 			: in  STD_LOGIC_VECTOR (31 downto 0);
           mem_output 			: out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT Registers
    Port ( clk 					: in  STD_LOGIC;
           rst 					: in  STD_LOGIC;
           read_register1 		: in  STD_LOGIC_VECTOR (4 downto 0);
           read_register2 		: in  STD_LOGIC_VECTOR (4 downto 0);
           write_register 		: in  STD_LOGIC_VECTOR (4 downto 0);
           write_data 			: in  STD_LOGIC_VECTOR (31 downto 0);
           RegWrite 				: in  STD_LOGIC;
           read_data1 			: out  STD_LOGIC_VECTOR (31 downto 0);
           read_data2 			: out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT ALU
    Port ( a 				: in  STD_LOGIC_VECTOR (31 downto 0);
           b 				: in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_control 	: in  STD_LOGIC_VECTOR (3 downto 0);
           output 		: out  STD_LOGIC_VECTOR (31 downto 0);
           zero 			: out  STD_LOGIC);
end COMPONENT;

COMPONENT ALUControl
    Port ( instruction 	: in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOp 		   : in  STD_LOGIC_VECTOR (2 downto 0);
           output 		: out  STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

COMPONENT ControlUnit
    Port ( clk  				: in  STD_LOGIC;
           rst  				: in  STD_LOGIC;
           Op   				: in  STD_LOGIC_VECTOR (5 downto 0);
			  Func 				: in  STD_LOGIC_VECTOR (5 downto 0);
           PCWriteCond_beq : out std_logic;
			  PCWriteCond_bne : out std_logic;
			  PCWrite     		: out std_logic;
			  IorD        		: out std_logic;
			  MemRead     		: out std_logic;
			  MemWrite    		: out std_logic;
			  MemToReg    		: out std_logic_vector(1 downto 0);
			  IRWrite     		: out std_logic;
			  PCSource    		: out std_logic_vector(1 downto 0);
			  ALUOp       		: out std_logic_vector(2 downto 0);
			  ALUSrcB     		: out std_logic_vector(1 downto 0);
			  ALUSrcA     		: out std_logic;
			  RegWrite    		: out std_logic;
			  RegDst      		: out std_logic_vector(1 downto 0));
end COMPONENT;

COMPONENT TempRegister
    Port ( clk 		: in  STD_LOGIC;
           rst 		: in  STD_LOGIC;
           input 		: in  STD_LOGIC_VECTOR (31 downto 0);
           output 	: out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

--constant
constant PC_increment : std_logic_vector(31 downto 0) := "00000000000000000000000000000100"; --4
constant Register_31 : std_logic_vector(4 downto 0) := "11111"; --31

-- signals
signal MUX_to_PC, PC_out, ALUOut_to_MUX, MUX_to_Memory, RegB_out, Memory_out, Instruction_Register_out, 
		 Memory_Data_Register_out, MUX3_to_Register, Registers_to_A, Registers_to_B, Sign_Extend_out, 
		 Shift_Left2_32_to_MUX5, RegA_to_MUX, MUX4_to_ALU, MUX5_to_ALU, 
		 Alu_Out, Jump_Address  					: std_logic_vector(31 downto 0);
		 
signal MUX2_to_Register  							: std_logic_vector(4 downto 0);

signal ALUControl_to_ALU 							: std_logic_vector(3 downto 0);

signal ALUOp 											: std_logic_vector(2 downto 0);

signal PCsource, ALUSrcB, MemToReg, RegDst 	: std_logic_vector(1 downto 0);

signal IorD, MemRead, MemWrite, IRWrite, RegWrite, ALU_Zero, PCWriteCond_beq, 
		 PCWriteCond_bne, PCWrite, ALUSrcA, 
       AND_to_OR2, AND_to_OR1, OR_to_PC  		: std_logic;

begin
	
	AND_to_OR1 <= ALU_Zero and PCWriteCond_beq;
	AND_to_OR2 <= (not ALU_Zero) and PCWriteCond_bne;
	OR_to_PC <= AND_to_OR1 or PCWrite or AND_to_OR2;
	Jump_Address(31 downto 28) <= PC_out(31 downto 28);
	
	
	ALU_inst 		   : ALU                     port map(MUX4_to_ALU, MUX5_to_ALU, ALUControl_to_ALU, Alu_Out, ALU_Zero);
	ALU_Control  		: ALUControl              port map(Instruction_Register_out(5 downto 0), ALUOp, ALUControl_to_ALU);
	Control_Unit      : ControlUnit             port map(CLKMain, RSTMain, Instruction_Register_out(31 downto 26), Instruction_Register_out(5 downto 0), PCWriteCond_beq, PCWriteCond_bne, PCWrite, IorD, MemRead, MemWrite, MemToReg, IRWrite, PCsource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst);
	Inst_Reg    		: InstructionRegister 	  port map(CLKMain, RSTMain, IRWrite, Memory_out, Instruction_Register_out);
	Memory_inst     	: Memory              	  port map(MemRead, MemWrite, MUX_to_Memory, RegB_out, CLKMain, RSTMain, Memory_out);
	MEM_DATA_REG 		: MemoryDataRegister  	  port map(CLKMain, RSTMain, Memory_out, Memory_Data_Register_out);
	MUX_1        		: MUX2to1                 port map(PC_out, ALUOut_to_MUX, IorD, MUX_to_Memory);
	MUX_2        		: MUX3to1_RegDst          port map(Instruction_Register_out(20 downto 16), Instruction_Register_out(15 downto 11), Register_31, RegDst, MUX2_to_Register);
	MUX_3        		: MUX3to1                 port map(ALUOut_to_MUX, Memory_Data_Register_out, PC_out, MemToReg, MUX3_to_Register);
	MUX_4        		: MUX2to1                 port map(PC_out, RegA_to_MUX, ALUSrcA, MUX4_to_ALU);
	MUX_5        		: MUX4to1                 port map(RegB_out, PC_increment, Sign_Extend_out, Shift_Left2_32_to_MUX5, ALUSrcB, MUX5_to_ALU);
	MUX_6        		: MUX4to1                 port map(Alu_Out, ALUOut_to_MUX, Jump_Address, RegA_to_MUX, PCsource, MUX_to_PC);
	Program_Counter 	: PC      					  port map(CLKMain, OR_to_PC, MUX_to_PC, RSTMain, PC_out);
	Registers_inst    : Registers           	  port map(CLKMain, RSTMain, Instruction_Register_out(25 downto 21), Instruction_Register_out(20 downto 16), MUX2_to_Register, MUX3_to_Register, RegWrite, Registers_to_A, Registers_to_B);
	Sign_Extend       : Sign_Extended           port map(Instruction_Register_out(15 downto 0), Sign_Extend_out);
	Shift_Left2_1     : ShiftLeft2_32           port map(Sign_Extend_out, Shift_Left2_32_to_MUX5);
	Shift_Left2_2     : ShiftLeft2_26           port map(Instruction_Register_out(25 downto 0), Jump_Address(27 downto 0));
	Reg_A     		   : TempRegister            port map(CLKMain, RSTMain, Registers_to_A, RegA_to_MUX);
	Reg_B     		   : TempRegister            port map(CLKMain, RSTMain, Registers_to_B, RegB_out);
	Reg_ALUOut     	: TempRegister			     port map(CLKMain, RSTMain, Alu_Out, ALUOut_to_MUX);
	
	output_top <= AND_to_OR1;
end Behavioral;

