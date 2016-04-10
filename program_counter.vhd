library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity program_counter is
    Port ( addr_offset : in  STD_LOGIC_VECTOR (15 downto 0);
           PL : in  STD_LOGIC;
           PI : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           reset_value : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           z : out  STD_LOGIC_VECTOR (15 downto 0));
end program_counter;

architecture Behavioral of program_counter is

    signal stored : STD_LOGIC_VECTOR (15 downto 0) := X"0000";

begin

    process(clk, reset)
    begin
        if reset = '1' then
            stored <= reset_value;
            z <= stored;
        elsif rising_edge(clk) then
            if PL = '1' then
                stored <= std_logic_vector(unsigned(stored) + unsigned(addr_offset));
                z <= stored;
            elsif PI = '1' then
                stored <= std_logic_vector(unsigned(stored) + 1);
                z <= stored;
            end if;
        end if;
    end process;

end Behavioral;

