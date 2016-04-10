library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder is
    Port ( X : in  STD_LOGIC_VECTOR (15 downto 0);
           Y : in  STD_LOGIC_VECTOR (15 downto 0);
           C_in : in  STD_LOGIC;
           C_out : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (15 downto 0));
end ripple_adder;

architecture Behavioral of ripple_adder is

	component full_adder
	Port (
		X : in STD_LOGIC;
		Y : in STD_LOGIC;
		C_in : in STD_LOGIC;
		C_out : out STD_LOGIC;
		S : out STD_LOGIC
	);
	end component;

	signal C : STD_LOGIC_VECTOR(1 to 15);

begin
-- port maps
	
	-- LSB adder port map
	full_adder_lsb: full_adder PORT MAP (
		X => X(0),
		Y => Y(0),
		C_in => C_in,
		C_out => C(1),
		S => S(0)
	);
	
	-- generate middle adder port maps
	GEN_ADD: for i in 1 to 14 generate
		full_adder_mid: full_adder PORT MAP (
			X => X(i),
			Y => Y(i),
			C_in => C(i),
			C_out => C(i+1),
			S => S(i)
		);
	end generate GEN_ADD;

	-- MSB adder port map
	full_adder_msb: full_adder PORT MAP (
		X => X(15),
		Y => Y(15),
		C_in => C(15),
		C_out => C_out,
		S => S(15)
	);


end Behavioral;
