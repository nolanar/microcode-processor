library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arithmetic_logic_unit is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           G_sel : in STD_LOGIC_VECTOR (3 downto 0);
           G : out  STD_LOGIC_VECTOR (15 downto 0);
		   C : out STD_LOGIC);
end arithmetic_logic_unit;

architecture Behavioral of arithmetic_logic_unit is

	component arithmetic_circuit
	Port (
		A : in  STD_LOGIC_VECTOR (15 downto 0);
		B : in  STD_LOGIC_VECTOR (15 downto 0);
		s0 : in  STD_LOGIC;
		s1 : in  STD_LOGIC;
		C_in : in  STD_LOGIC;
		C_out : out  STD_LOGIC;
		G : out  STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;
	
	component logic_circuit
	Port (
		A : in  STD_LOGIC_VECTOR (15 downto 0);
		B : in  STD_LOGIC_VECTOR (15 downto 0);
		s0 : in  STD_LOGIC;
		s1 : in  STD_LOGIC;
		G : out  STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;
	
	component mux_2to1
	Port (
		in0 : in STD_LOGIC_VECTOR (15 downto 0);
		in1 : STD_LOGIC_VECTOR (15 downto 0);
		s : in STD_LOGIC;
		z : out STD_LOGIC_VECTOR (15 downto 0)		
	);
	end component;

	signal arith_out, logic_out : STD_LOGIC_VECTOR (15 downto 0);
	signal arith_C : STD_LOGIC;

begin
	
	ac: arithmetic_circuit PORT MAP (
		A => A,
		B => B,
		s0 => G_sel(1),
		s1 => G_sel(2),
		C_in => G_sel(0),
		C_out => arith_C,
		G => arith_out
	);

	lc: logic_circuit PORT MAP (
		A => A,
		B => B,
		s0 => G_sel(0),
		s1 => G_sel(1),
		G => logic_out
	);
	
	mux: mux_2to1 PORT MAP (
		in0 => arith_out,
		in1 => logic_out,
		s => G_sel(3),
		z => G
	);
	
	-- carry logic
	C <= arith_C when G_sel(3) = '0' else '0';

end Behavioral;
