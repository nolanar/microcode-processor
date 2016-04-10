library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end full_adder_tb;

architecture behavior of full_adder_tb is

    -- component Declaration for the Unit Under Test (UUT)

    component full_adder
        port (
            X : in std_logic;
            Y : in std_logic;
            C_in : in std_logic;
            C_out : out std_logic;
            S : out std_logic
        );
    end component;
    --Inputs
    signal X : std_logic := '0';
    signal Y : std_logic := '0';
    signal C_in : std_logic := '0';
    signal C_out : std_logic := '0';

    --Outputs
    signal S : std_logic;
 
begin
    -- Instantiate the Unit Under Test (UUT)
    uut : full_adder
    port map(
        X => X, 
        Y => Y, 
        C_in => C_in, 
        C_out => C_out, 
        S => S
    );

    -- Stimulus process
    stim_proc : process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns; 

        X <= '1';
        wait for 100 ns; 

        Y <= '1';
        wait for 100 ns; 
 
        C_in <= '1';
        wait for 100 ns; 
 
        X <= '0';
        wait for 100 ns; 

        Y <= '0';
        wait for 100 ns; 

        C_in <= '0';
        wait;
    end process;

end;