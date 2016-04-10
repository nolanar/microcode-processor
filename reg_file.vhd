library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_file is
	Port ( 
		A_sel : in  STD_LOGIC_VECTOR(2 downto 0);
		B_sel : in  STD_LOGIC_VECTOR(2 downto 0);
		D_sel : in  STD_LOGIC_VECTOR(2 downto 0);
        TA : in STD_LOGIC;
        TB : in STD_LOGIC;
        TD : in STD_LOGIC;
		load : in STD_LOGIC;
		clk : in  STD_LOGIC;
		D_data : in  STD_LOGIC_VECTOR(15 downto 0);
		A_data : out  STD_LOGIC_VECTOR(15 downto 0);
		B_data : out  STD_LOGIC_VECTOR(15 downto 0)
	);
end reg_file;

architecture Behavioral of reg_file is
-- components
	-- 4 bit Register for register file
	COMPONENT reg_16bit
		PORT(
			D : IN std_logic_vector(15 downto 0);
			load : IN std_logic;
			Clk : IN std_logic;
			Q : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	-- 3 to 8 Decoder
	COMPONENT decoder_3to8
	PORT(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		Q0 : OUT std_logic;
		Q1 : OUT std_logic;
		Q2 : OUT std_logic;
		Q3 : OUT std_logic;
		Q4 : OUT std_logic;
		Q5 : OUT std_logic;
		Q6 : OUT std_logic;
		Q7 : OUT std_logic
	);
	END COMPONENT;

	-- 8 to 1 line multiplexer
	COMPONENT mux_8to1
	PORT(
		In0 : IN std_logic_vector(15 downto 0);
		In1 : IN std_logic_vector(15 downto 0);
		In2 : IN std_logic_vector(15 downto 0);
		In3 : IN std_logic_vector(15 downto 0);
		In4 : IN std_logic_vector(15 downto 0);
		In5 : IN std_logic_vector(15 downto 0);
		In6 : IN std_logic_vector(15 downto 0);
		In7 : IN std_logic_vector(15 downto 0);
		S0 : IN std_logic;
		S1 : IN std_logic;
		S2 : IN std_logic;
		Z : OUT std_logic_vector(15 downto 0)
	);
	END COMPONENT;
    
    -- 2 to 1 line multiplexer
	COMPONENT mux_2to1
	PORT(
		In0 : in std_logic_vector(15 downto 0);
		In1 : in std_logic_vector(15 downto 0);
		s : in std_logic;
		Z : out std_logic_vector(15 downto 0)
	);
	END COMPONENT;

-- signals
	signal load_reg : std_logic_vector(0 to 8);
	signal dec_out : std_logic_vector(0 to 7);
	type multi_vector is array (0 to 8) of std_logic_vector(15 downto 0);
	signal reg_q : multi_vector;
    signal A_mux_out, B_mux_out : std_logic_vector(15 downto 0);

begin
-- port maps ;-)

	-- generate register port maps
	GEN_REG: for i in 0 to 8 generate
		reg: reg_16bit PORT MAP (
			D_data, load_reg(i), Clk, reg_q(i)
		);
	end generate GEN_REG;


	-- 4 to 1 source register multiplexer
	A_mux_8to1: mux_8to1 PORT MAP (
		reg_q(0), reg_q(1), reg_q(2), reg_q(3), 
		reg_q(4), reg_q(5), reg_q(6), reg_q(7), 
		A_sel(2), A_sel(1), A_sel(0), A_mux_out
	);
	-- 4 to 1 source register multiplexer
	B_mux_8to1: mux_8to1 PORT MAP (
		reg_q(0), reg_q(1), reg_q(2), reg_q(3), 
		reg_q(4), reg_q(5), reg_q(6), reg_q(7), 
		B_sel(2), B_sel(1), B_sel(0), B_mux_out
	);
	
	-- Destination select decoder
	decoder: decoder_3to8 PORT MAP (
		D_sel(2), D_sel(1), D_sel(0), 
		dec_out(0), dec_out(1),	dec_out(2), dec_out(3),
		dec_out(4), dec_out(5),	dec_out(6), dec_out(7)
	);
    
    -- TA register select mux
 	TA_mux: mux_2to1 PORT MAP (
		A_mux_out, reg_q(8), TA, A_data
	); 

    -- TB register select mux
 	TB_mux: mux_2to1 PORT MAP (
		B_mux_out, reg_q(8), TB, B_data
	);    
	
	-- load enable logic
	LOAD_LOGIC: for i in 0 to 7 generate
		load_reg(i) <= not TD AND load AND dec_out(i) after 1 ns;
	end generate LOAD_LOGIC;
    
    load_reg(8) <= load AND TD after 1 ns;

end Behavioral;
