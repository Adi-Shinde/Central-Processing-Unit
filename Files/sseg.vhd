LIBRARY ieee;
USE ieee.std_logic_1164.all;
                                   
ENTITY sseg IS 
	PORT(bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  sign : IN STD_LOGIC;
		  leds, ledss : OUT STD_LOGIC_VECTOR (0 TO 6));
	END sseg;
	
ARCHITECTURE Behavior OF sseg IS
BEGIN
	PROCESS(bcd,sign)
		BEGIN
		IF sign = '1' THEN -- If Overflow from ASU is 1
            ledss <= not "0000001";  
        ELSE
            ledss <= "1111111";  -- All segments off under normal conditions.
        END IF;
		
		CASE bcd IS 
			   WHEN "0000" =>leds<="0000001";  --0
            WHEN "0001" =>leds<="1001111";  --1
            WHEN "0010" =>leds<="0010010";  --2
            WHEN "0011" =>leds<="0000110";  --3
            WHEN "0100" =>leds<="1001100";  --4
            WHEN "0101" =>leds<="0100100";  --5
            WHEN "0110" =>leds<="0100000";  --6
            WHEN "0111" =>leds<="0001111";  --7
            WHEN "1000" =>leds<="0000000";  --8
            WHEN "1001" =>leds<="0001100";  --9
            
				WHEN "1010" =>leds<="0001000";  --A
            WHEN "1011" =>leds<="1100000";  --b
            WHEN "1100" =>leds<="0110001";  --C
            WHEN "1101" =>leds<="1000010";  --d
            WHEN "1110" =>leds<="0110000";  --E
            WHEN "1111" =>leds<="0111000";  --F
            
				WHEN OTHERS =>leds<="1111111";
			END CASE;
	END PROCESS;
END Behavior;