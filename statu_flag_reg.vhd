library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity status_flag_reg is
    Port ( V_in : in  STD_LOGIC;
           C_in : in  STD_LOGIC;
           N_in : in  STD_LOGIC;
           Z_in : in  STD_LOGIC;
           load : in STD_LOGIC;
           clk : in STD_LOGIC;
           V_out : out  STD_LOGIC;
           C_out : out  STD_LOGIC;
           N_out : out  STD_LOGIC;
           Z_out : out  STD_LOGIC);
end status_flag_reg;

architecture Behavioral of status_flag_reg is

begin
    process (clk)
    begin
        if rising_edge(clk) and load = '1' then
            V_out <= V_in after 5 ns;
            C_out <= C_in after 5 ns;
            N_out <= N_in after 5 ns;
            Z_out <= Z_in after 5 ns;            
        end if;
    end process;
end Behavioral;

