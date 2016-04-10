LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY control_addr_reg_tb IS
END control_addr_reg_tb;
 
ARCHITECTURE behavior OF control_addr_reg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control_addr_reg
    PORT(
         CAR_in : IN  std_logic_vector(7 downto 0);
         sel : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         reset_value : IN  std_logic_vector(7 downto 0);
         CAR_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CAR_in : std_logic_vector(7 downto 0) := (others => '0');
   signal sel : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal reset_value : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal CAR_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: control_addr_reg PORT MAP (
        CAR_in => CAR_in,
        sel => sel,
        clk => clk,
        reset => reset,
        reset_value => reset_value,
        CAR_out => CAR_out
    );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;


    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;

        sel <= '1';
        CAR_IN <= x"f0";
        wait for clk_period;

        sel <= '0';
        wait for 2 * clk_period;

        wait for clk_period / 5;
        reset <= '1';
        reset_value <= x"55";
        wait for clk_period;
        
        reset <= '0';

        wait;
    end process;

END;
