library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_3to1_1bit is
    Port ( in0 : in  STD_LOGIC;
           in1 : in  STD_LOGIC;
           in2 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           z : out  STD_LOGIC);
end mux_3to1_1bit;

architecture Behavioral of mux_3to1_1bit is

begin

	z <= (in0 AND NOT s0 AND NOT s1) OR
		 (in1 AND s0 AND NOT s1) OR
		 (in2 AND NOT s0 AND s1) after 3 ns;

end Behavioral;

