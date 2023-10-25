----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:01:13 05/17/2023 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is
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
end ControlUnit;

architecture Behavioral of ControlUnit is
type state is(   Start,
					  InstructionFetch,
					  InstructionFetch1,
					  InstructionFetch2,
                 InstructionDecode,
                 MemoryAddressComp,
					  JR_Execution,
					  JAL_Execution,
					  JAL_Completion,
					  JALR_Execution,
					  JALR_Completion,
                 Execution,
                 Execution_addi,
					  Execution_slti,
					  Execution_andi,
					  Execution_ori,
					  Execution_xori,
					  Execution_lui,
                 BranchCompletion_beq,
					  BranchCompletion_bne,
                 JumpCompletion,
                 MemoryAccessLoad,
                 MemoryAccessStore,
                 RTypeCompletion,
                 RTypeCompletion_I,
                 MemoryReadCompletionStep );

 signal current_state, next_state : state := Start;
 signal ctrl_state : std_logic_vector(19 downto 0) := (others => '0');
  
begin

process(clk, rst, Op)
  begin
    if rst = '0' then
      current_state <= Start;
    elsif rising_edge(clk) then
      current_state <= next_state;
    end if;

    case current_state is
		
		when Start             => next_state <= InstructionFetch;     
      when InstructionFetch  => next_state <= InstructionFetch1;
		when InstructionFetch1  => next_state <= InstructionFetch2;
		when InstructionFetch2  => next_state <= InstructionDecode;

      when InstructionDecode => if Op = "100011" then -- lw
                                  next_state <= MemoryAddressComp;
                                elsif Op = "101011" then -- sw
                                  next_state <= MemoryAddressComp;
										  elsif Op = "000000" and Func = "001000" then -- R-type JR
                                  next_state <= JR_Execution;
										  elsif Op = "000000" and Func = "001001" then -- R-type JALR
                                  next_state <= JALR_Execution;
                                elsif Op = "000000" then -- R-type
                                  next_state <= Execution;
											 
                                elsif Op = "001000" then -- addi
                                  next_state <= Execution_addi;
										  elsif Op = "001010" then -- slti
                                  next_state <= Execution_slti;
										  elsif Op = "001101" then -- ori
                                  next_state <= Execution_ori;
										  elsif Op = "001100" then -- andi
                                  next_state <= Execution_andi;
										  elsif Op = "001110" then -- xori
                                  next_state <= Execution_xori;
										  elsif Op = "001111" then -- lui
                                  next_state <= Execution_lui;
											 
                                elsif Op = "000100" then -- BEQ
                                  next_state <= BranchCompletion_beq;
										  elsif Op = "000101" then -- BNE
                                  next_state <= BranchCompletion_bne;
                                elsif Op = "000010" then -- Jump
                                  next_state <= JumpCompletion;
										  elsif Op = "000011" then -- JAL
                                  next_state <= JAL_Execution;
                                end if;

      when MemoryAddressComp => if Op = "100011" then -- lw
                                  next_state <= MemoryAccessLoad;
                                else  -- sw
                                  next_state <= MemoryAccessStore;
                                end if;
										  
		when JR_Execution    		=> next_state <= InstructionFetch;
		
		when JAL_Execution    		=> next_state <= JAL_Completion;
		
		when JAL_Completion    		=> next_state <= InstructionFetch;
		
		when JALR_Execution    		=> next_state <= JALR_Completion;
		
		when JALR_Completion    	=> next_state <= InstructionFetch;
		
      when Execution         		=> next_state <= RTypeCompletion;

      when Execution_addi       	=> next_state <= RTypeCompletion_I;
		
		when Execution_slti       	=> next_state <= RTypeCompletion_I;
		
		when Execution_andi       	=> next_state <= RTypeCompletion_I;
		
		when Execution_ori       	=> next_state <= RTypeCompletion_I;
		
		when Execution_xori       	=> next_state <= RTypeCompletion_I;
		
		when Execution_lui       	=> next_state <= RTypeCompletion_I;

      when MemoryAccessLoad  		=> next_state <= MemoryReadCompletionStep;

      when MemoryAccessStore 		=> next_state <= InstructionFetch;

      when BranchCompletion_beq  => next_state <= InstructionFetch;
		
		when BranchCompletion_bne  => next_state <= InstructionFetch;

      when JumpCompletion    		=> next_state <= InstructionFetch;

      when RTypeCompletion   		=> next_state <= InstructionFetch;

      when others            		=> next_state <= InstructionFetch;

    end case;
  end process;

  with current_state select
    ctrl_state <= "00000000000XXX000000" when Start,
						"00001000100000010000" when InstructionFetch,
						"00001000100000010000" when InstructionFetch1,
						"10001000100000010000" when InstructionFetch2,
						
                  "00000000000000110000" when InstructionDecode,
                  "00000000000000101000" when MemoryAddressComp,
                  "00000000000010001000" when Execution,
						
                  "00000000000000101000" when Execution_addi,
						"00000000000011101000" when Execution_slti,
						"00000000000100101000" when Execution_andi,
						"00000000000101101000" when Execution_ori,
						"00000000000001101000" when Execution_xori,
						"00000000000110101000" when Execution_lui,
						
                  "00100000001001001000" when BranchCompletion_beq,
						
						"01000000001001001000" when BranchCompletion_bne,
						
						"10000000011000000000" when JR_Execution,
                  "10000000010000000000" when JumpCompletion,
						
						"00000010000000110010" when JAL_Execution,
						"10000010010000110110" when JAL_Completion,
						
						"00000010000000110001" when JALR_Execution,
						"10000010011000110101" when JALR_Completion,
						
                  "00011000000000000000" when MemoryAccessLoad,
                  "00010100000000000000" when MemoryAccessStore,
                  "00000000000000000101" when RTypeCompletion,
                  "00000000000000000100" when RTypeCompletion_I,
                  "00000001000000000100" when MemoryReadCompletionStep,
                  "00000000000000000000" when others;

  PCWrite     		<= ctrl_state(19);
  PCWriteCond_bne <= ctrl_state(18);
  PCWriteCond_beq <= ctrl_state(17);
  IorD        		<= ctrl_state(16);
  MemRead     		<= ctrl_state(15);
  MemWrite    		<= ctrl_state(14);
  MemToReg    		<= ctrl_state(13 downto 12);
  IRWrite     		<= ctrl_state(11);
  PCSource    		<= ctrl_state(10 downto 9);
  ALUOp       		<= ctrl_state(8 downto 6);
  ALUSrcB     		<= ctrl_state(5 downto 4);
  ALUSrcA     		<= ctrl_state(3);
  RegWrite    		<= ctrl_state(2);
  RegDst      		<= ctrl_state(1 downto 0);

end Behavioral;

