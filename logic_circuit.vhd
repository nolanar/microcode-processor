library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_circuit is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           G : out  STD_LOGIC_VECTOR (15 downto 0));
end logic_circuit;

architecture Behavioral of logic_circuit is

	component mux_4to1
	Port (
		s0 : in  STD_LOGIC;
		s1 : in  STD_LOGIC;
		in0 : in  STD_LOGIC_VECTOR(15 downto 0);
		in1 : in  STD_LOGIC_VECTOR(15 downto 0);
		in2 : in  STD_LOGIC_VECTOR(15 downto 0);
		in3 : in  STD_LOGIC_VECTOR(15 downto 0);
		z : out  STD_LOGIC_VECTOR(15 downto 0)
	);
	end component;

	signal and_gate, or_gate, xor_gate, not_gate : STD_LOGIC_VECTOR(15 downto 0);

begin

	-- mux to select logical operation
	mux: mux_4to1 PORT MAP (
		s0 => s0,
		s1 => s1,
		in0 => and_gate,
		in1 => or_gate,
		in2 => xor_gate,
		in3 => not_gate,
		z => G
	);

	-- logical operations
	and_gate <= A AND B after 1 ns;
	or_gate <= A OR B after 1 ns;
	xor_gate <= A XOR B after 1 ns;
	not_gate <= NOT A after 1 ns;
	
end Behavioral;

