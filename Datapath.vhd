library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Datapath is
    port (
        ctrl_word : in STD_LOGIC_VECTOR (15 downto 0);
        const_in : in STD_LOGIC_VECTOR (15 downto 0);
        Data_in : in STD_LOGIC_VECTOR (15 downto 0);
        clk : in STD_LOGIC;
        V : out STD_LOGIC;
        C : out STD_LOGIC;
        N : out STD_LOGIC;
        Z : out STD_LOGIC;
        Addr_out : out STD_LOGIC_VECTOR (15 downto 0);
        Data_out : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Datapath;

architecture Behavioral of Datapath is

    component reg_file
        port (
            A_sel : in STD_LOGIC_VECTOR(2 downto 0);
            B_sel : in STD_LOGIC_VECTOR(2 downto 0);
            D_sel : in STD_LOGIC_VECTOR(2 downto 0);
            TA : in STD_LOGIC;
            TB : in STD_LOGIC;
            TD : in STD_LOGIC;
            load : in STD_LOGIC;
            clk : in STD_LOGIC;
            D_data : in STD_LOGIC_VECTOR(15 downto 0);
            A_data : out STD_LOGIC_VECTOR(15 downto 0);
            B_data : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;
 
    component function_unit
        port (
            A : in STD_LOGIC_VECTOR (15 downto 0);
            B : in STD_LOGIC_VECTOR (15 downto 0);
            FS : in STD_LOGIC_VECTOR (4 downto 0);
            V : out STD_LOGIC;
            C : out STD_LOGIC;
            N : out STD_LOGIC;
            Z : out STD_LOGIC;
            F : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
 
    component mux_2to1
        port (
            In0 : in std_logic_vector(15 downto 0);
            In1 : in std_logic_vector(15 downto 0);
            s : in std_logic;
            Z : out std_logic_vector(15 downto 0)
        );
    end component;

    signal A_data, B_data, D_data, mux_b_out, f_unit_out : std_logic_vector(15 downto 0);

begin
    -- port maps
 
    -- register file port map
    reg : reg_file
    port map(
        ctrl_word(13 downto 11), ctrl_word(10 downto 8), 
        ctrl_word(16 downto 14), '0', '0', '0',
        ctrl_word(0), clk, D_data, A_data, B_data
    );
 
    -- function unit port map
    funct_unit : function_unit
    port map(
        A_data, mux_b_out, ctrl_word(6 downto 2),
        V, C, N, Z, f_unit_out
    );

    -- MUX B port map
    mux_b : mux_2to1
    port map(
        B_data, const_in, ctrl_word(7), mux_b_out
    );
 
    -- MUX D port map
    mux_d : mux_2to1
    port map(
        f_unit_out, Data_in, ctrl_word(1), D_data
    );
 
    -- out lines
    Addr_out <= A_data;
    Data_out <= mux_b_out;

end Behavioral;