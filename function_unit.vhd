library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity function_unit is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           FS : in  STD_LOGIC_VECTOR (3 downto 0);
           V : out  STD_LOGIC;
           C : out  STD_LOGIC;
           N : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           F : out  STD_LOGIC_VECTOR (15 downto 0));
end function_unit;

architecture Behavioral of function_unit is

	component arithmetic_logic_unit
	Port (
		A : in  STD_LOGIC_VECTOR (15 downto 0);
		B : in  STD_LOGIC_VECTOR (15 downto 0);
		G_sel : in STD_LOGIC_VECTOR (3 downto 0);
		G : out  STD_LOGIC_VECTOR (15 downto 0);
		C : out STD_LOGIC
	);
	end component;
	
	component shifter
	Port (
		B : in  STD_LOGIC_VECTOR (15 downto 0);
		H_sel : in STD_LOGIC_VECTOR (1 downto 0);
		i_R : in  STD_LOGIC;
		i_L : in  STD_LOGIC;
		i_C : in  STD_LOGIC;
		C : out  STD_LOGIC;
		H : out  STD_LOGIC_VECTOR (15 downto 0)		
	);
	end component;
	
	component mux_2to1
	Port (
         in0 : IN  std_logic_vector(15 downto 0);
         in1 : IN  std_logic_vector(15 downto 0);
         s : IN  std_logic;
         z : OUT  std_logic_vector(15 downto 0)
	);
	end component;

	signal alu_out, shifter_out, funct_out : STD_LOGIC_VECTOR(15 downto 0);
	signal alu_V, shifter_V, alu_C, shifter_C, MF_sel : STD_LOGIC;

begin
	
	MF_sel <= FS(3) AND FS(2);
	
	alu: arithmetic_logic_unit PORT MAP (
		A => A,
		B => B,
		G_sel => FS(3 downto 0),
		G => alu_out,
		C => alu_C
	);
	
	sh: shifter PORT MAP (
		B => B,
		H_sel => FS(1 downto 0),
		i_R => '0',
		i_L => '0',
		i_C => '0',
		C => shifter_C,
		H => shifter_out
	);
	
	mux: mux_2to1 PORT MAP (
		in0 => alu_out,
		in1 => shifter_out,
		s => MF_sel,
		z => funct_out
	);
	
-- flag logic:
	F <= funct_out;
	
	-- carry flag logic
	C <= alu_C after 1 ns when MF_sel = '0' else shifter_C after 1 ns;
	
	-- overflow flag logic
	alu_V <= (A(15) XNOR B(15)) AND (A(15) XOR alu_out(15)) after 2 ns;
	shifter_V <= B(15) XOR shifter_out(15) after 1 ns;
	V <= alu_V after 1 ns when MF_sel = '0' else shifter_V after 1 ns;
	
	-- negative flag logic
	N <= funct_out(15);
	
	-- zero flag logic
	Z <= '1' after 1 ns when funct_out = "0000000000000000"
		 else '0' after 1 ns;

end Behavioral;
