library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ALU2 is
port( Clk : in std_logic; --input clock signal
     A,B : in unsigned(7 downto 0); --8-bit inputs from latches A and B
     student_id : in unsigned(3 downto 0); --4 bit student id from FSM
     OP : in unsigned(0 to 15); --16-bit selector for Operation from Decoder
     Neg: out std_logic; --is the result negative ? Set-for 8-bit result Output
     R1 : out unsigned(3 downto 0); -- lower 4-bits of 8-bit Result Output
     R2 : out unsigned(3 downto 0)); -- higher 4-bits of 8-bit Result Output
end ALU2;
architecture calculation of ALU2 is--temporary signal declarations.
signal Reg1,Reg2,Result : unsigned(7 downto 0):= (others => '0') ;
signal Reg4 : unsigned (0 to 7);
begin
Reg1 <= A; --temporarily store A in Reg1 local variable
Reg2 <= B; --temporarily store B in Reg2 local variable
process(Clk, OP)
begin
if(rising_edge(Clk)) THEN --Do the calculation @ positive edge of clock cycle.
   case OP is
        WHEN "1000000000000000" =>
            --Do Addition for Reg1 and Reg2
				    Result <= Reg1 + Reg2;
        WHEN "0100000000000000" =>
       Result <= (Reg1 - Reg2);
					if (Reg2 < Reg1) then
					
                        Neg <= '1';
                    else
                        Neg <= '0';
                    end if;
            --Do Subtraction
            --"Neg" bit set if required.
        WHEN "0010000000000000" =>     
		  Result <= not Reg1;
            --Do Inverse
        WHEN "0001000000000000" =>
		  Result <= (not(Reg1 and Reg2));
            --Do Boolean NAND
        WHEN "0000100000000000" =>
		   Result <= (not (Reg1 or Reg2));
            --Do Boolean NOR
        WHEN "0000010000000000" =>
		   Result <= Reg1 and Reg2;
            --Do Boolean AND
        WHEN "0000001000000000" =>
		   Result <= Reg1 or Reg2;
            --Do Boolean OR
        WHEN "0000000100000000" =>
		   Result <= Reg1 xor Reg2;
            --Do Boolean XOR
        WHEN "0000000010000000" =>
		   Result <= Reg1 xnor Reg2;
            --Do Boolean XNOR
        WHEN OTHERS =>
		   Result <= "--------";
            --Don't care, do nothing
   end case;
end if;
end process;
R1 <= Result(3 downto 0); --Since the output seven segments can
R2 <= Result(7 downto 4); -- only 4-bits, split the 8-bit to two 4-bits.
end calculation;