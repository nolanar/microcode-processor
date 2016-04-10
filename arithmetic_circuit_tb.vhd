LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY arithmetic_circuit_tb IS
END arithmetic_circuit_tb;
 
ARCHITECTURE behavior OF arithmetic_circuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT arithmetic_circuit
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         C_in : IN  std_logic;
         C_out : OUT  std_logic;
         G : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
   signal C_in : std_logic := '0';

 	--Outputs
   signal C_out : std_logic;
   signal G : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: arithmetic_circuit PORT MAP (
		  A => A,
		  B => B,
		  s0 => s0,
		  s1 => s1,
		  C_in => C_in,
		  C_out => C_out,
		  G => G
		);

	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		wait for 100 ns;	

		A <= "0000000000000010";
		B <= "0000000000000011";

		-- transfer
		s0 <= '0';
		s1 <= '0';
		C_in <= '0';
		wait for 100 ns;			

		-- add
		s0 <= '1';
		s1 <= '0';
		C_in <= '0';
		wait for 100 ns;	
		
		-- subtract
		s0 <= '0';
		s1 <= '1';
		C_in <= '1';
		wait for 100 ns;	

		-- increment A
		s0 <= '0';
		s1 <= '0';
		C_in <= '1';
		wait for 100 ns;		

		-- decrement A
		s0 <= '1';
		s1 <= '1';
		C_in <= '0';
		wait for 100 ns;	
		
		wait;
	end process;

END;
