LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY control_memory_tb IS
END control_memory_tb;
 
ARCHITECTURE behavior OF control_memory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control_memory
    PORT(
         MW : OUT  std_logic;
         MM : OUT  std_logic;
         RW : OUT  std_logic;
         MD : OUT  std_logic;
         FS : OUT  std_logic_vector(3 downto 0);
         MB : OUT  std_logic;
         TB : OUT  std_logic;
         TA : OUT  std_logic;
         TD : OUT  std_logic;
         PL : OUT  std_logic;
         PI : OUT  std_logic;
         IL : OUT  std_logic;
         SW : OUT  std_logic;
         MC : OUT  std_logic;
         MS : OUT  std_logic_vector(2 downto 0);
         NA : OUT  std_logic_vector(7 downto 0);
         IN_CAR : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal IN_CAR : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal MW : std_logic;
   signal MM : std_logic;
   signal RW : std_logic;
   signal MD : std_logic;
   signal FS : std_logic_vector(3 downto 0);
   signal MB : std_logic;
   signal TB : std_logic;
   signal TA : std_logic;
   signal TD : std_logic;
   signal PL : std_logic;
   signal PI : std_logic;
   signal IL : std_logic;
   signal SW : std_logic;
   signal MC : std_logic;
   signal MS : std_logic_vector(2 downto 0);
   signal NA : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: control_memory PORT MAP (
          MW => MW,
          MM => MM,
          RW => RW,
          MD => MD,
          FS => FS,
          MB => MB,
          TB => TB,
          TA => TA,
          TD => TD,
          PL => PL,
          PI => PI,
          IL => IL,
          SW => SW,
          MC => MC,
          MS => MS,
          NA => NA,
          IN_CAR => IN_CAR
        );


    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	

        -- select address 0 which stores MM and PI high, others low
        IN_CAR <= "00000000";
        wait for 100 ns;	
        
        -- select address 1 which stores MM and IL high, others low
        IN_CAR <= "00000001";
        wait for 100 ns;	

        wait;
    end process;

END;
