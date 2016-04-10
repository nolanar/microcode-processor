library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_addr_reg is
    Port ( CAR_in : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           reset_value : in  STD_LOGIC_VECTOR (7 downto 0);
           CAR_out : out  STD_LOGIC_VECTOR (7 downto 0));
end control_addr_reg;

architecture Behavioral of control_addr_reg is

    signal stored : STD_LOGIC_VECTOR (7 downto 0) := X"00";

begin

    process(clk, reset)
    begin
        if reset = '1' then
            stored <= reset_value;
            CAR_out <= stored;
        elsif rising_edge(clk) then
            if sel = '1' then
                stored <= CAR_in;
            else
                stored <= std_logic_vector(unsigned(stored) + 1);
            end if;
            CAR_out <= stored;            
        end if;
    end process;

end Behavioral;

