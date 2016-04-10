LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY microcode_computer_tb IS
END microcode_computer_tb;
 
ARCHITECTURE behavior OF microcode_computer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT microcode_computer
    PORT(
         clk : IN  std_logic;
         reset_PC : IN  std_logic;
         reset_CAR : IN  std_logic;
         reset_val_PC : IN  std_logic_vector(15 downto 0);
         reset_val_CAR : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset_PC : std_logic := '0';
   signal reset_CAR : std_logic := '0';
   signal reset_val_PC : std_logic_vector(15 downto 0) := (others => '0');
   signal reset_val_CAR : std_logic_vector(7 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: microcode_computer PORT MAP (
        clk => clk,
        reset_PC => reset_PC,
        reset_CAR => reset_CAR,
        reset_val_PC => reset_val_PC,
        reset_val_CAR => reset_val_CAR
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

        -- initalise PC and CAR
        reset_PC <= '1';
        reset_CAR <= '1';
        reset_val_PC <= x"000f";
        reset_val_CAR <= x"00";
        wait for 100 ns;
        reset_PC <= '0';
        reset_CAR <= '0';        

        wait;
    end process;

END;
