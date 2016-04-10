library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           C_in : in  STD_LOGIC;
		   C_out : out STD_LOGIC;
           S : out  STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

begin
	-- 2 ns as it passes through 2 levels of gates
	S <= X XOR Y XOR C_in after 2 ns;
	C_out <= (X AND Y) OR (X AND C_in) OR (Y AND C_in) after 2 ns;

end Behavioral;

