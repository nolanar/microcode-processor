LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY mux_4to1_tb IS
END mux_4to1_tb;
 
ARCHITECTURE behavior OF mux_4to1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_4to1
    PORT(
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         in0 : IN  std_logic_vector(15 downto 0);
         in1 : IN  std_logic_vector(15 downto 0);
         in2 : IN  std_logic_vector(15 downto 0);
         in3 : IN  std_logic_vector(15 downto 0);
         z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
   signal in0 : std_logic_vector(15 downto 0) := (others => '0');
   signal in1 : std_logic_vector(15 downto 0) := (others => '0');
   signal in2 : std_logic_vector(15 downto 0) := (others => '0');
   signal in3 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal z : std_logic_vector(15 downto 0);
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: mux_4to1 PORT MAP (
        s0 => s0,
        s1 => s1,
        in0 => in0,
        in1 => in1,
        in2 => in2,
        in3 => in3,
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

		s0 <= '0';
		s1 <= '0';

		wait for 100 ns;	
		s0 <= '0';
		s1 <= '1';

		wait for 100 ns;	
		s0 <= '1';
		s1 <= '0';

		wait for 100 ns;	
		s0 <= '1';
		s1 <= '1';

        wait;
    end process;

END;
