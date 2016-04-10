library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arithmetic_logic_unit_tb is
end arithmetic_logic_unit_tb;

architecture behavior of arithmetic_logic_unit_tb is

    -- component Declaration for the Unit Under Test (UUT)

    component arithmetic_logic_unit
        port (
            A : in std_logic_vector(15 downto 0);
            B : in std_logic_vector(15 downto 0);
            G_sel : in std_logic_vector(3 downto 0);
            G : out std_logic_vector(15 downto 0);
            C : out std_logic
        );
    end component;
 

    --Inputs
    signal A : std_logic_vector(15 downto 0) := (others => '0');
    signal B : std_logic_vector(15 downto 0) := (others => '0');
    signal G_sel : std_logic_vector(3 downto 0) := (others => '0');

    --Outputs
    signal G : std_logic_vector(15 downto 0);
    signal C : std_logic;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut : arithmetic_logic_unit
    port map(
        A => A, 
        B => B, 
        G_sel => G_sel, 
        G => G, 
        C => C
    );

    -- Stimulus process
    stim_proc : process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns; 

        -- test values
        A <= "1000000000000011";
        B <= "1000000000000010";

        -- loop over all ALU operations
        -- i.e. 0000 to 1011
        TEST_VALUES : for i in 0 to 11 loop
            G_sel <= std_logic_vector(to_unsigned(i, G_sel'LENGTH));
            wait for 100 ns;
        end loop TEST_VALUES;

        wait;
    end process;

end;