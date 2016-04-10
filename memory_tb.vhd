LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY memory_tb IS
END memory_tb;
 
ARCHITECTURE behavior OF memory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memory
    PORT(
         address : IN  std_logic_vector(15 downto 0);
         write_data : IN  std_logic_vector(15 downto 0);
         MemWrite : IN  std_logic;
         read_data : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(15 downto 0) := (others => '0');
   signal write_data : std_logic_vector(15 downto 0) := (others => '0');
   signal MemWrite : std_logic := '0';

 	--Outputs
   signal read_data : std_logic_vector(15 downto 0);

BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: memory PORT MAP (
        address => address,
        write_data => write_data,
        MemWrite => MemWrite,
        read_data => read_data
    );

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	

        -- 0x000a stores 0x1000
        address <= x"000a";
        wait for 100 ns;
        
        -- write data to 0x000a
        MemWrite <= '1';
        write_data <= x"1358";
        wait for 100 ns;	

        -- disable write data
        MemWrite <= '0';
        write_data <= x"9876";
        wait for 100 ns;	

        wait;
    end process;

END;
