LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY status_flag_reg_tb IS
END status_flag_reg_tb;
 
ARCHITECTURE behavior OF status_flag_reg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT status_flag_reg
    PORT(
         V_in : IN  std_logic;
         C_in : IN  std_logic;
         N_in : IN  std_logic;
         Z_in : IN  std_logic;
         load : IN  std_logic;
         clk : IN  std_logic;
         V_out : OUT  std_logic;
         C_out : OUT  std_logic;
         N_out : OUT  std_logic;
         Z_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal V_in : std_logic := '0';
   signal C_in : std_logic := '0';
   signal N_in : std_logic := '0';
   signal Z_in : std_logic := '0';
   signal load : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal V_out : std_logic;
   signal C_out : std_logic;
   signal N_out : std_logic;
   signal Z_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: status_flag_reg PORT MAP (
        V_in => V_in,
        C_in => C_in,
        N_in => N_in,
        Z_in => Z_in,
        load => load,
        clk => clk,
        V_out => V_out,
        C_out => C_out,
        N_out => N_out,
        Z_out => Z_out
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

        V_in <= '1';
        C_in <= '1';
        N_in <= '1';
        Z_in <= '1';
        wait for clk_period;
        
        load <= '1';
        wait for clk_period;
        
        load <= '0';
        wait for clk_period;
       
        V_in <= '0';
        C_in <= '0';
        N_in <= '0';
        Z_in <= '0';
        wait for clk_period;
        
        wait;
    end process;

END;
