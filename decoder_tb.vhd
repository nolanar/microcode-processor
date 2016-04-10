LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY decoder_testbench IS
END decoder_testbench;
 
ARCHITECTURE behavior OF decoder_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder_3to8
    PORT(
         A0 : IN  std_logic;
         A1 : IN  std_logic;
         A2 : IN  std_logic;
         Q0 : OUT  std_logic;
         Q1 : OUT  std_logic;
         Q2 : OUT  std_logic;
         Q3 : OUT  std_logic;
         Q4 : OUT  std_logic;
         Q5 : OUT  std_logic;
         Q6 : OUT  std_logic;
         Q7 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A0 : std_logic := '0';
   signal A1 : std_logic := '0';
   signal A2 : std_logic := '0';

 	--Outputs
   signal Q0 : std_logic;
   signal Q1 : std_logic;
   signal Q2 : std_logic;
   signal Q3 : std_logic;
   signal Q4 : std_logic;
   signal Q5 : std_logic;
   signal Q6 : std_logic;
   signal Q7 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder_3to8 PORT MAP (
          A0 => A0,
          A1 => A1,
          A2 => A2,
          Q0 => Q0,
          Q1 => Q1,
          Q2 => Q2,
          Q3 => Q3,
          Q4 => Q4,
          Q5 => Q5,
          Q6 => Q6,
          Q7 => Q7
        );

   -- Stimulus process
   stim_proc: process
   begin	
		
      wait for 10 ns;	
      A0 <= '0';
		A1 <= '0';
		A2 <= '0';

      wait for 10 ns;	
      A0 <= '0';
		A1 <= '0';
		A2 <= '1';

      wait for 10 ns;	
      A0 <= '0';
		A1 <= '1';
		A2 <= '0';

      wait for 10 ns;	
      A0 <= '0';
		A1 <= '1';
		A2 <= '1';

      wait for 10 ns;	
      A0 <= '1';
		A1 <= '0';
		A2 <= '0';

      wait for 10 ns;	
      A0 <= '1';
		A1 <= '0';
		A2 <= '1';

      wait for 10 ns;	
      A0 <= '1';
		A1 <= '1';
		A2 <= '0';

      wait for 10 ns;	
      A0 <= '1';
		A1 <= '1';
		A2 <= '1';
		
		wait;
   end process;

END;
