LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ripple_adder_tb IS
END ripple_adder_tb;
 
ARCHITECTURE behavior OF ripple_adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ripple_adder
    PORT(
         X : IN  std_logic_vector(15 downto 0);
         Y : IN  std_logic_vector(15 downto 0);
         C_in : IN  std_logic;
         C_out : OUT  std_logic;
         S : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(15 downto 0) := (others => '0');
   signal Y : std_logic_vector(15 downto 0) := (others => '0');
   signal C_in : std_logic := '0';

 	--Outputs
   signal C_out : std_logic;
   signal S : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ripple_adder PORT MAP (
          X => X,
          Y => Y,
          C_in => C_in,
          C_out => C_out,
          S => S
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      X <= "1000000000000001";
      Y <= "1000000000001001";
	  C_in <= '1';


      wait;
   end process;

END;
