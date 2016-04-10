LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Datapath_tb IS
END Datapath_tb;
 
ARCHITECTURE behavior OF Datapath_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Datapath
    PORT(
		ctrl_word : in  STD_LOGIC_VECTOR (15 downto 0);
		const_in : in  STD_LOGIC_VECTOR (15 downto 0);
		Data_in : in  STD_LOGIC_VECTOR (15 downto 0);
		clk : in  STD_LOGIC;
		V : out  STD_LOGIC;
		C : out  STD_LOGIC;
		N : out  STD_LOGIC;
		Z : out  STD_LOGIC;
		Addr_out : out  STD_LOGIC_VECTOR (15 downto 0);
		Data_out : out  STD_LOGIC_VECTOR (15 downto 0)
	);
    END COMPONENT;
    

   --Inputs
   signal ctrl_word : std_logic_vector(15 downto 0) := (others => '0');
   signal const_in : std_logic_vector(15 downto 0) := (others => '0');
   signal Data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal V : std_logic;
   signal C : std_logic;
   signal N : std_logic;
   signal Z : std_logic;
   signal Addr_out : std_logic_vector(15 downto 0);
   signal Data_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: Datapath PORT MAP (
          ctrl_word => ctrl_word,
		  const_in => const_in,
		  Data_in => Data_in,
		  clk => clk,
		  V => V,
		  C => C,
		  N => N,
		  Z => Z,
		  Addr_out => Addr_out,
		  Data_out => Data_out
	);

	-- Clock process definitions
	clk_process :process
	begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
	end process;


	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 50 ns.
		wait for 50 ns;	

		-- load value into reg0:
		-- LDR r0, =2_0000111100001111
		ctrl_word <= "0000000000000011";
		Data_in <= "0000111100001111"; -- value to be stored
		wait for 100 ns;

		-- reg1 <= reg0 + 1
		-- ADD r1, r0, #1
		ctrl_word <= "0010000001001001";
		const_in <= "0000000000000001";
		wait for 100 ns;
		
		-- reg2 <= reg0 - reg1
		-- SUB r2, r0, r1
		ctrl_word <= "0100000010010101";
		wait for 100 ns;
		
		-- load into reg3, reg2 shifted right
		-- SR r3, r2
		ctrl_word <= "0110000100110101";
		wait for 100 ns;
		
		-- reg4 <= reg0 XOR reg2
		-- XOR r4, r0, r2
		ctrl_word <= "1000000100101001";
		wait for 100 ns;

		wait;
	end process;

END;
