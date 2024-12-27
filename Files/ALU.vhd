Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED .ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
PORT (
		Clock: in std_logic;
		A,B : in unsigned (7 DOWNTO 0); --8 bit inputs from latches A and B
		student_id : in unsigned (3 downto 0); --4 bits student id from FSM
		OP: in unsigned (15 DOWNTO 0); --16 bits selector for Operation from Decoder
		Neg: out std_logic; 
		R1, R2 :out unsigned (3 downto 0)
		);
end ALU;

architecture calculation of ALU is
	signal Reg1,Reg2,Result	 : unsigned (7 downto 0):= (others => '0') ;
	signal Reg4 : unsigned (0 to 7);
	begin
	Reg1 <= A; --temporarily store A in Reg1
	Reg2 <= B; --store B in Reg2
	process (Clock, OP)
	begin
		if(rising_edge(Clock)) THEN --caclulation @ positive edge of clock cycle
			case OP is
			
				WHEN "0000000000000001" => 
					Result <= Reg1 + Reg2; --Addition for Reg1 and Reg2
					Neg <= '0';
				WHEN "0000000000000010" =>
					IF Reg1 > Reg2 THEN
						Result <= (Reg1 - Reg2);
						Neg <= '0';
				ELSE
						Result <= (Reg2 - Reg1);
						Neg <= '1';
				END IF;
				
				WHEN "0000000000000100" =>
					Result <= NOT (Reg1); --Inverse
					Neg <= '0';
					
				WHEN "0000000000001000" =>
					Result <= (Reg1 NAND Reg2); --NAND
					Neg <= '0';
					
				WHEN "0000000000010000" =>
					Result <= (Reg1 NOR Reg2);  --Do Boolean NOR
					Neg <= '0';
         
				WHEN "0000000000100000" =>
					Result <= (Reg1 AND Reg2);    --Do Boolean AND
					Neg <= '0';
         
				WHEN "0000000001000000" =>
					Result <= (Reg1 XOR Reg2);     --Do Boolean XOR
					Neg <= '0';
           
				WHEN "0000000010000000" =>    --Do Boolean OR
					Result <= (Reg1 OR Reg2);
					Neg <= '0';
           
				WHEN "0000000100000000" =>    --Do Boolean XNOR
					Result <= (Reg1 XNOR Reg2);
					Neg <= '0';
				
				WHEN OTHERS =>
					Result <= "00000000";     --Don't care, do nothing
					Neg <= '0';
          
		   end case;
	end if;
end process;
R1 <= Result(3 downto 0); --Since the output seven segments can
R2 <= Result(7 downto 4); -- only 4-bits, split the 8-bit to two 4-bits.
end calculation;		
				