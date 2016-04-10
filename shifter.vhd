library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter is
    Port ( B : in  STD_LOGIC_VECTOR (15 downto 0);
           H_sel : in STD_LOGIC_VECTOR (1 downto 0);
           i_R, i_L, i_C: in  STD_LOGIC;
		   C : out STD_LOGIC;
           H : out  STD_LOGIC_VECTOR (15 downto 0));
end shifter;

architecture Behavioral of shifter is

	component mux_3to1_1bit 
	Port (
		in0, in1, in2, s0, s1 : in  STD_LOGIC;
		z : out  STD_LOGIC
	);
	end component;

begin
-- port maps

	-- generate middle MUXs
	GEN_SHIFTER: for i in 1 to 14 generate
		mux_M: mux_3to1_1bit PORT MAP (
			B(i), B(i+1), B(i-1), H_sel(0), H_sel(1), H(i)
		);
	end generate GEN_SHIFTER;

	-- right MUX
	mux_R: mux_3to1_1bit PORT MAP (
		B(0), B(1), i_R, H_sel(0), H_sel(1), H(0)
	);
	
	-- left MUX
	mux_L: mux_3to1_1bit PORT MAP (
		B(15), i_L, B(14), H_sel(0), H_sel(1), H(15)
	);
	
	-- carry MUX
	mux_C: mux_3to1_1bit PORT MAP (
		i_C, B(0), B(15), H_sel(0), H_sel(1), C
	);

end Behavioral;
