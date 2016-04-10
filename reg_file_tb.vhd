library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_tb is
end reg_file_tb;

architecture behavior of reg_file_tb is

    -- component Declaration for the Unit Under Test (UUT)

    component reg_file
        port (
            A_sel : in std_logic_vector(2 downto 0);
            B_sel : in std_logic_vector(2 downto 0);
            D_sel : in std_logic_vector(2 downto 0);
            TA : in std_logic;
            TB : in std_logic;
            TD : in std_logic;
            load : in std_logic;
            clk : in std_logic;
            D_data : in std_logic_vector(15 downto 0);
            A_data : out std_logic_vector(15 downto 0);
            B_data : out std_logic_vector(15 downto 0)
        );
    end component;
 

    --Inputs
    signal A_sel : std_logic_vector(2 downto 0) := (others => '0');
    signal B_sel : std_logic_vector(2 downto 0) := (others => '0');
    signal D_sel : std_logic_vector(2 downto 0) := (others => '0');
    signal TA : std_logic := '0';
    signal TB : std_logic := '0';
    signal TD : std_logic := '0';
    signal load : std_logic := '0';
    signal clk : std_logic := '0';
    signal D_data : std_logic_vector(15 downto 0) := (others => '0');

    --Outputs
    signal A_data : std_logic_vector(15 downto 0);
    signal B_data : std_logic_vector(15 downto 0);

    -- Clock period definitions
    constant clk_period : time := 50 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut : reg_file
    port map(
        A_sel => A_sel, 
        B_sel => B_sel, 
        D_sel => D_sel,
        TA => TA,
        TB => TB,
        TD => TD,
        load => load, 
        clk => clk, 
        D_data => D_data, 
        A_data => A_data, 
        B_data => B_data
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

        -- enable load data
        load <= '1';
 
        -- load values 1 to 8 into registers
        FILL_REGS : for i in 0 to 7 loop
            D_data <= std_logic_vector(to_unsigned(i + 1, D_data'LENGTH));
            D_sel <= std_logic_vector(to_unsigned(i, D_sel'LENGTH));
            wait for clk_period; 
        end loop FILL_REGS;
        
        -- load value into temp register
        TD <= '1';
        D_data <= "1111111111111111";
        wait for clk_period;

        -- disable load data and TD
        load <= '0';
        D_data <= "0000000000000000";
        TD <= '0';
        wait for clk_period;
 
        -- select reg4 for A_data and reg2 for B_data
        A_sel <= "100";
        B_sel <= "010";
        wait for clk_period;
 
        -- select temp register for A_data and reg2 for B_data
        TA <= '1';
        TB <= '1';
        wait for clk_period;
        
        wait;
    end process;

end;