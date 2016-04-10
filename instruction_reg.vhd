library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruction_reg is
    Port ( IR : in  STD_LOGIC_VECTOR (15 downto 0);
           IL : in  STD_LOGIC;
           opcode : out  STD_LOGIC_VECTOR (7 downto 0);
           DR : out  STD_LOGIC_VECTOR (2 downto 0);
           SA : out  STD_LOGIC_VECTOR (2 downto 0);
           SB : out  STD_LOGIC_VECTOR (2 downto 0));
end instruction_reg;

architecture Behavioral of instruction_reg is

begin

    process(IL, IR)
    begin
        if IL = '1' then
            opcode(7) <= '0' after 5 ns;
            opcode(6 downto 0) <= IR(15 downto 9) after 5 ns;
            DR <= IR(8 downto 6) after 5 ns;
            SA <= IR(5 downto 3) after 5 ns;
            SB <= IR(2 downto 0) after 5 ns;
        end if;
    end process;

end Behavioral;

