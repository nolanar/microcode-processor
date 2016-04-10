library ieee;
use ieee.std_logic_1164.all;

entity reg_16bit_testbench is
end reg_16bit_testbench;

architecture behavior of reg_16bit_testbench is

    -- component Declaration for the Unit Under Test (UUT)

    component reg_16bit
        port (
            D : in std_logic_vector(15 downto 0);
            load : in std_logic;
            clk : in std_logic;
            Q : out std_logic_vector(15 downto 0)
        );
    end component;
 
    --Inputs
    signal D : std_logic_vector(15 downto 0) := (others => '0');
    signal load : std_logic := '0';
    signal clk : std_logic := '0';

    --Outputs
    signal Q : std_logic_vector(15 downto 0);

    -- Clock period definitions
    constant clk_period : time := 50 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut : reg_16bit
    port map(
        D => D, 
        load => load, 
        clk => clk, 
        Q => Q
    );

    -- Clock process definitions
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    -- Stimulus process
    stim_proc : process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns; 

        D <= "0101010101010101";
        load <= '1';
 
        wait for clk_period;

        D <= "1111111111111111";
        load <= '0';

        wait for 2 * clk_period;
 
        load <= '1';
 
        wait;
    end process;

end;