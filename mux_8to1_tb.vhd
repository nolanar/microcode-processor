LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
ENTITY mux_8to1_testbench IS
END mux_8to1_testbench;
 
ARCHITECTURE behavior OF mux_8to1_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_8to1
    PORT(
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         s2 : IN  std_logic;
         in0 : IN  std_logic_vector(15 downto 0);
         in1 : IN  std_logic_vector(15 downto 0);
         in2 : IN  std_logic_vector(15 downto 0);
         in3 : IN  std_logic_vector(15 downto 0);
         in4 : IN  std_logic_vector(15 downto 0);
         in5 : IN  std_logic_vector(15 downto 0);
         in6 : IN  std_logic_vector(15 downto 0);
         in7 : IN  std_logic_vector(15 downto 0);
         z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
   signal s2 : std_logic := '0';
   signal in0 : std_logic_vector(15 downto 0) := (others => '0');
   signal in1 : std_logic_vector(15 downto 0) := (others => '0');
   signal in2 : std_logic_vector(15 downto 0) := (others => '0');
   signal in3 : std_logic_vector(15 downto 0) := (others => '0');
   signal in4 : std_logic_vector(15 downto 0) := (others => '0');
   signal in5 : std_logic_vector(15 downto 0) := (others => '0');
   signal in6 : std_logic_vector(15 downto 0) := (others => '0');
   signal in7 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal z : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux_8to1 PORT MAP (
          s0 => s0,
          s1 => s1,
          s2 => s2,
          in0 => in0,
          in1 => in1,
          in2 => in2,
          in3 => in3,
          in4 => in4,
          in5 => in5,
          in6 => in6,
          in7 => in7,
          z => z
        );


	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		wait for 100 ns;	


		in0 <= "1000000000000001";
		in1 <= "1100000000000011";		
		in2 <= "1110000000000111";		
		in3 <= "1111000000001111";		
		in4 <= "1111100000011111";		
		in5 <= "1111110000111111";		
		in6 <= "1111111001111111";		
		in7 <= "1111111111111111";		

		s0 <= '0';
		s1 <= '0';
		s2 <= '0';

		wait for 10 ns;	
		s0 <= '0';
		s1 <= '0';
		s2 <= '1';

		wait for 10 ns;	
		s0 <= '0';
		s1 <= '1';
		s2 <= '0';

		wait for 10 ns;	
		s0 <= '0';
		s1 <= '1';
		s2 <= '1';

		wait for 10 ns;	
		s0 <= '1';
		s1 <= '0';
		s2 <= '0';

		wait for 10 ns;	
		s0 <= '1';
		s1 <= '0';
		s2 <= '1';

		wait for 10 ns;	
		s0 <= '1';
		s1 <= '1';
		s2 <= '0';

		wait for 10 ns;	
		s0 <= '1';
		s1 <= '1';
		s2 <= '1';

		wait;
	end process;

END;
