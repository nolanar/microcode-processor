library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arithmetic_circuit is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           C_in : in  STD_LOGIC;
           C_out : out  STD_LOGIC;
           G : out  STD_LOGIC_VECTOR (15 downto 0));
end arithmetic_circuit;

architecture Behavioral of arithmetic_circuit is

	component ripple_adder
	Port (
		X, Y : in STD_LOGIC_VECTOR (15 downto 0);
		C_in : in STD_LOGIC;
		C_out : out STD_LOGIC;
		S : out STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;
	
	component ripple_adder_input_logic
	Port (
		B : in STD_LOGIC_VECTOR (15 downto 0);
		Y : out STD_LOGIC_VECTOR (15 downto 0);
		s0, s1 : in STD_LOGIC
	);
	end component;

	-- signal from ripple_adder_input_logic to ripple_adder
	signal input_logic : STD_LOGIC_VECTOR(15 downto 0);

begin
	
	rail: ripple_adder_input_logic PORT MAP (
		B => B,
		Y => input_logic,
		s0 => s0,
		s1 => s1
	);
	
	ra: ripple_adder PORT MAP (
		X => A,
		Y => input_logic,
		C_in => C_in,
		C_out => C_out,
		S => G
	);

end Behavioral;

