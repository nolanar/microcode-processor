LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY shifter_tb IS
END shifter_tb;
 
ARCHITECTURE behavior OF shifter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shifter
    PORT(
         B : IN  std_logic_vector(15 downto 0);
         H_sel : std_logic_vector(1 downto 0);
         i_R : IN  std_logic;
         i_L : IN  std_logic;
		 i_C : IN std_logic;
		 C : OUT std_logic;
         H : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal H_sel : std_logic_vector(1 downto 0) := (others => '0');
   signal i_R : std_logic := '0';
   signal i_L : std_logic := '0';
   signal i_C : std_logic := '0';

 	--Outputs
   signal H : std_logic_vector(15 downto 0);
   signal C : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: shifter PORT MAP (
		B => B,
		H_sel => H_sel,
		i_R => i_R,
		i_L => i_L,
		i_C => i_C,
		C => C,
		H => H
	);

	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		wait for 100 ns;	

		B <= "1111111111111111";

		-- test transfer
		wait for 100 ns;
		
		-- test right shift
		H_sel <= "01";
		wait for 100 ns;

		-- test left shift
		H_sel <= "10";
		wait for 100 ns;		

		wait;
	end process;

END;
