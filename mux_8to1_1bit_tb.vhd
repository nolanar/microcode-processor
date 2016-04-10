LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
ENTITY mux_8to1_1bit_tb IS
END mux_8to1_1bit_tb;
 
ARCHITECTURE behavior OF mux_8to1_1bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_8to1_1bit
    PORT(
         s : IN  std_logic_vector(2 downto 0);
         in0 : IN  std_logic;
         in1 : IN  std_logic;
         in2 : IN  std_logic;
         in3 : IN  std_logic;
         in4 : IN  std_logic;
         in5 : IN  std_logic;
         in6 : IN  std_logic;
         in7 : IN  std_logic;
         z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal s : std_logic_vector(2 downto 0) := (others => '0');
   signal in0 : std_logic := '1';
   signal in1 : std_logic := '0';
   signal in2 : std_logic := '1';
   signal in3 : std_logic := '0';
   signal in4 : std_logic := '1';
   signal in5 : std_logic := '0';
   signal in6 : std_logic := '1';
   signal in7 : std_logic := '0';

 	--Outputs
   signal z : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux_8to1_1bit PORT MAP (
          s => s,
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

        -- loop over all select values
        -- should alternate 1 and 0 output
        TEST_SEL : for i in 0 to 7 loop
            s <= std_logic_vector(to_unsigned(i, s'LENGTH));
            wait for 100 ns;
        end loop TEST_SEL;
 
        wait;
    end process;

END;
