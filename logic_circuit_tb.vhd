LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY logic_circuit_tb IS
END logic_circuit_tb;
 
ARCHITECTURE behavior OF logic_circuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT logic_circuit
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         G : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';

 	--Outputs
   signal G : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: logic_circuit PORT MAP (
		A => A,
		B => B,
		s0 => s0,
		s1 => s1,
		G => G
	);

	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		wait for 100 ns;	

		A <= "1000000000000011";
		B <= "1000000000000010";
		
		-- F = A AND B
		s0 <= '0';
		s1 <= '0';
		wait for 100 ns;	
		
		-- F = A OR B
		s0 <= '1';
		s1 <= '0';
		wait for 100 ns;			
		
		-- F = A XOR B
		s0 <= '0';
		s1 <= '1';
		wait for 100 ns;
		
		-- F = NOT A 
		s0 <= '1';
		s1 <= '1';
		wait for 100 ns;	
		
		wait;
	end process;

END;
