LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY zero_fill_tb IS
END zero_fill_tb;
 
ARCHITECTURE behavior OF zero_fill_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT zero_fill
    PORT(
         value : IN  std_logic_vector(2 downto 0);
         padded : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal value : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal padded : std_logic_vector(15 downto 0);
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: zero_fill PORT MAP (
        value => value,
        padded => padded
    );

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	

        value <= "101";

        wait;
    end process;

END;
