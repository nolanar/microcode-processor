library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity extend is
    Port ( DR : in  STD_LOGIC_VECTOR (2 downto 0);
           SA : in  STD_LOGIC_VECTOR (2 downto 0);
           SB : in  STD_LOGIC_VECTOR (2 downto 0);
           z : out  STD_LOGIC_VECTOR (15 downto 0));
end extend;

architecture Behavioral of extend is

begin
    
    z(2 downto 0) <= SB after 5 ns;
    z(5 downto 3) <= SA after 5 ns;
    z(8 downto 6) <= DR after 5 ns;
    
    -- append most significant bit to preserve 2s complement
    GEN: for i in 9 to 15 generate
        z(i) <= DR(2) after 5 ns;
    end generate GEN;

end Behavioral;

