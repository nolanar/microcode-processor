library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_input_logic is
    Port ( B : in  STD_LOGIC;
           Y : out  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC);
end adder_input_logic;

architecture Behavioral of adder_input_logic is

begin

	-- three levels of gates so 3 ns propagation
	Y <= (B AND s0) OR ((NOT B) AND s1) after 3 ns;

end Behavioral;
