library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity function_unit_tb is
end function_unit_tb;

architecture behavior of function_unit_tb is

    -- component Declaration for the Unit Under Test (UUT)

    component function_unit
        port (
            A : in std_logic_vector(15 downto 0);
            B : in std_logic_vector(15 downto 0);
            FS : in std_logic_vector(3 downto 0);
            V : out std_logic;
            C : out std_logic;
            N : out std_logic;
            Z : out std_logic;
            F : out std_logic_vector(15 downto 0)
        );
    end component;
 

    --Inputs
    signal A : std_logic_vector(15 downto 0) := (others => '0');
    signal B : std_logic_vector(15 downto 0) := (others => '0');
    signal FS : std_logic_vector(3 downto 0) := (others => '0');

    --Outputs
    signal V : std_logic;
    signal C : std_logic;
    signal N : std_logic;
    signal Z : std_logic;
    signal F : std_logic_vector(15 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut : function_unit
    port map(
        A => A, 
        B => B, 
        FS => FS, 
        V => V, 
        C => C, 
        N => N, 
        Z => Z, 
        F => F
    );

    -- Stimulus process
    stim_proc : process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns; 

        -- test values
        A <= "1000000000000011";
        B <= "1000000000000010";

        -- loop over all FS operation values
        -- i.e. 0000 to 1110
        TEST_VALUES : for i in 0 to 14 loop
            FS <= std_logic_vector(to_unsigned(i, FS'LENGTH));
            wait for 100 ns;
        end loop TEST_VALUES;
 
        wait;
    end process;

end;