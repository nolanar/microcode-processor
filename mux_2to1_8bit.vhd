library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1_8bit is
	port ( 
		In0 : in std_logic_vector(7 downto 0);
		In1 : in std_logic_vector(7 downto 0);
		s : in std_logic;
		Z : out std_logic_vector(7 downto 0));
end mux_2to1_8bit;

architecture Behavioral of mux_2to1_8bit is
begin
	Z <= 	In0 after 5 ns when s='0' else
			In1 after 5 ns when s='1' else
			"00000000" after 5 ns;
end Behavioral;
