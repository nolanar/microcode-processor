library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4to1 is
    Port ( s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           in0 : in  STD_LOGIC_VECTOR(15 downto 0);
           in1 : in  STD_LOGIC_VECTOR(15 downto 0);
           in2 : in  STD_LOGIC_VECTOR(15 downto 0);
           in3 : in  STD_LOGIC_VECTOR(15 downto 0);
           z : out  STD_LOGIC_VECTOR(15 downto 0));
end mux_4to1;

architecture Behavioral of mux_4to1 is
begin
	z <= 	in0 after 5 ns when s1='0' and s0='0' else
			in1 after 5 ns when s1='0' and s0='1' else
			in2 after 5 ns when s1='1' and s0='0' else
			in3 after 5 ns when s1='1' and s0='1' else
			"0000000000000000" after 5 ns;
end Behavioral;