library ieee;
use ieee.std_logic_1164.all;

entity decode4to16 is
    port (
        w : in std_logic_vector (3 downto 0);
        en : in std_logic;
        y : out std_logic_vector (15 downto 0)
    );
end decode4to16;

architecture Behavior of decode4to16 is
    signal enw : std_logic_vector (4 downto 0);
begin
    enw <= en & w;
    with enw select
        y <= "0000000000000001" when "10000", --y0 = lsb
             "0000000000000010" when "10001",
             "0000000000000100" when "10010",
             "0000000000001000" when "10011",
             "0000000000010000" when "10100",
             "0000000000100000" when "10101",
             "0000000001000000" when "10110",
             "0000000010000000" when "10111",
             "0000000100000000" when "11000",
             "0000001000000000" when "11001",
             "0000010000000000" when "11010",
             "0000100000000000" when "11011",
             "0001000000000000" when "11100",
             "0010000000000000" when "11101",
             "0100000000000000" when "11110",
             "1000000000000000" when "11111",
             "0000000000000000" when others;
end Behavior;