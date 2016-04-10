library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reg_16bit is
    port (
        D     : in STD_LOGIC_VECTOR(15 downto 0);
        load  : in STD_LOGIC;
        clk   : in STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(15 downto 0)
    );
end reg_16bit;

architecture Behavioral of reg_16bit is
begin
    process (clk)
    begin
        if rising_edge(clk) and load = '1' then
            Q <= D after 5 ns;
        end if;
    end process;
end Behavioral;