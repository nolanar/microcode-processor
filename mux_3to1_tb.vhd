LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY mux_3to1_tb IS
END mux_3to1_tb;
 
ARCHITECTURE behavior OF mux_3to1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_3to1_1bit
    PORT(
         in0 : IN  std_logic;
         in1 : IN  std_logic;
         in2 : IN  std_logic;
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in0 : std_logic := '0';
   signal in1 : std_logic := '0';
   signal in2 : std_logic := '0';
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';

 	--Outputs
   signal z : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: mux_3to1_1bit PORT MAP (
		in0 => in0,
		in1 => in1,
		in2 => in2,
		s0 => s0,
		s1 => s1,
		z => z
	);


	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		wait for 100 ns;	
		
		-- test in0
		wait for 50ns;
		in0 <= '1';
		wait for 50 ns;	

		-- test in1
		s0 <= '1';
		s1 <= '0';
		wait for 50 ns;	
		in1 <= '1';
		wait for 50 ns;	

		-- test in2
		s0 <= '0';
		s1 <= '1';
		wait for 50 ns;	
		in2 <= '1';
		wait for 50 ns;		

		in0 <= '0';
		in1 <= '0';
		in2 <= '0';
		s0 <= '0';
		s1 <= '0';
		wait;
	end process;

END;
