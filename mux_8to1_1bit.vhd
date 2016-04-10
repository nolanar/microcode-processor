library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8to1_1bit is
    Port ( s : in  STD_LOGIC_VECTOR (2 downto 0);
           in0 : in  STD_LOGIC;
           in1 : in  STD_LOGIC;
           in2 : in  STD_LOGIC;
           in3 : in  STD_LOGIC;
           in4 : in  STD_LOGIC;
           in5 : in  STD_LOGIC;
           in6 : in  STD_LOGIC;
           in7 : in  STD_LOGIC;
           z : out  STD_LOGIC);
end mux_8to1_1bit;

architecture Behavioral of mux_8to1_1bit is

begin
	z <= 	in0 after 5 ns when s = "000" else
			in1 after 5 ns when s = "001" else
			in2 after 5 ns when s = "010" else
			in3 after 5 ns when s = "011" else
			in4 after 5 ns when s = "100" else
			in5 after 5 ns when s = "101" else
			in6 after 5 ns when s = "110" else
			in7 after 5 ns when s = "111" else
			'0' after 5 ns;

end Behavioral;

