library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zero_fill is
    Port ( value : in  STD_LOGIC_VECTOR (2 downto 0);
           padded : out  STD_LOGIC_VECTOR (15 downto 0));
end zero_fill;

architecture Behavioral of zero_fill is

begin

    padded(2 downto 0) <= value after 5 ns;
    padded(15 downto 3) <= "0000000000000" after 5 ns;

end Behavioral;

