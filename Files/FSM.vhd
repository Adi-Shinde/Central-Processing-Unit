library ieee;
USE ieee.std_logic_1164.all;

entity FSM is
port(
	clk :in std_logic;
	data_in :in std_logic;
	reset :in std_logic;
	current_state: out std_logic_vector (3 downto 0);
	student_id :out std_logic_vector(3 downto 0)
);
end FSM;

architecture fsm of FSM is
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
	signal yfsm: state_type;

begin
	process (clk, reset)	
	begin
if reset = '1' then
yfsm <= s0;
elsif (clk'EVENT AND clk = '1') then
--HERE
case yfsm is
when s0 =>
case data_in is
when '0' => yfsm <= s0;
when '1' => yfsm <= s1;
when others => yfsm <= s0;
end case;

when s1=>
case data_in is
when '0' => yfsm <= s1;
when '1' => yfsm <= s2;
when others => yfsm <= s1;
end case;

when s2=>
case data_in is
when '0' => yfsm <= 
s2;
when '1' => yfsm <= s3;
when others => yfsm <= s2;
end case;

when s3 =>
case data_in is
when '0' => yfsm <= s3;
when '1' => yfsm <= s4;
when others => yfsm <= s3;
end case;

when s4 =>
case data_in is
when '0' => yfsm <= s4;
when '1' => yfsm <= s5;
when others => yfsm <= s4;
end case;

when s5 =>
case data_in is
when '0' => yfsm <= s5;
when '1' => yfsm <= s6;
when others => yfsm <= s5;
end case;

when s6 =>
case data_in is
when '0' => yfsm <= s6;
when '1' => yfsm <= s7;
when others => yfsm <= s6;
end case;

when s7=>
case data_in is
when '0' => yfsm <= s7;
when '1' => yfsm <= s8;
when others => yfsm <= s7;
end case;

when s8=>
case data_in is
when '0' => yfsm <= s8;
when '1' => yfsm <= s0;
when others => yfsm <= s8;
end case;
end case;
end if;
end process;

process (yfsm, data_in)
begin
case yfsm is
when s0 =>
student_id <= X"5";
current_state <=X"0";
when s1 =>
student_id <= X"0";
current_state <=X"1";
when s2 =>
student_id <= X"1";
current_state <=X"2";
when s3 =>
student_id <= X"1";
current_state <=X"3";
when s4 =>
student_id <= X"7";
current_state <=X"4";
when s5 =>
student_id <= X"5";
current_state <=X"5";
when s6 =>
student_id <= X"8";
current_state <=X"6";
when s7 =>
student_id <= X"1";
current_state <=X"7";
when s8 =>
student_id <= X"9";
current_state <=X"8";
when others =>
student_id <= X"E";
current_state <= X"E";
end case;
end process;
end fsm;

