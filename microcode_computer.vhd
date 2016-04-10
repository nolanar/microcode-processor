library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity microcode_computer is
    port (
        clk : in STD_LOGIC;
        reset_PC : in STD_LOGIC;
        reset_CAR : in STD_LOGIC;
        reset_val_PC : in STD_LOGIC_VECTOR(15 downto 0);
        reset_val_CAR : in STD_LOGIC_VECTOR(7 downto 0)
    );
end microcode_computer;

architecture Behavioral of microcode_computer is

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
            FS : in STD_LOGIC_VECTOR (3 downto 0);
            V : out STD_LOGIC;
            C : out STD_LOGIC;
            N : out STD_LOGIC;
            Z : out STD_LOGIC;
            F : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    
    component status_flag_reg
        port (
            V_in : in  STD_LOGIC;
            C_in : in  STD_LOGIC;
            N_in : in  STD_LOGIC;
            Z_in : in  STD_LOGIC;
            load : in STD_LOGIC;
            clk : in STD_LOGIC;
            V_out : out  STD_LOGIC;
            C_out : out  STD_LOGIC;
            N_out : out  STD_LOGIC;
            Z_out : out  STD_LOGIC
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
 
    component mux_2to1_8bit
        port (
            In0 : in std_logic_vector(7 downto 0);
            In1 : in std_logic_vector(7 downto 0);
            s : in std_logic;
            Z : out std_logic_vector(7 downto 0)
        );
    end component;    
    
    component mux_8to1_1bit
        port (
            s : in  STD_LOGIC_VECTOR (2 downto 0);
            in0 : in  STD_LOGIC;
            in1 : in  STD_LOGIC;
            in2 : in  STD_LOGIC;
            in3 : in  STD_LOGIC;
            in4 : in  STD_LOGIC;
            in5 : in  STD_LOGIC;
            in6 : in  STD_LOGIC;
            in7 : in  STD_LOGIC;
            z : out  STD_LOGIC
        );
    end component;
    
    component memory
        port (
            address : in STD_LOGIC_VECTOR (15 downto 0);
            write_data : in  STD_LOGIC_VECTOR (15 downto 0);
            MemWrite : in  STD_LOGIC;
            read_data : out  STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    
    component control_memory
        port (
            MW : out std_logic;
            MM : out std_logic;
            RW : out std_logic;
            MD : out std_logic;
            FS : out std_logic_vector(3 downto 0);
            MB : out std_logic;
            TB : out std_logic;
            TA : out std_logic;
            TD : out std_logic;
            PL : out std_logic;
            PI : out std_logic;
            IL : out std_logic;
            SW : out std_logic;
            MC : out std_logic;
            MS : out std_logic_vector(2 downto 0);
            NA : out std_logic_vector(7 downto 0);
            IN_CAR : in std_logic_vector(7 downto 0)            
        );
    end component;
    
    component instruction_reg
        port (
            IR : in  STD_LOGIC_VECTOR (15 downto 0);
            IL : in  STD_LOGIC;
            opcode : out  STD_LOGIC_VECTOR (7 downto 0);
            DR : out  STD_LOGIC_VECTOR (2 downto 0);
            SA : out  STD_LOGIC_VECTOR (2 downto 0);
            SB : out  STD_LOGIC_VECTOR (2 downto 0)
       );
   end component;
   
    component extend
    port (
        DR : in  STD_LOGIC_VECTOR (2 downto 0);
        SA : in  STD_LOGIC_VECTOR (2 downto 0);
        SB : in  STD_LOGIC_VECTOR (2 downto 0);
        z : out  STD_LOGIC_VECTOR (15 downto 0)
    );
    end component;
    
    component program_counter
    port (
        addr_offset : in  STD_LOGIC_VECTOR (15 downto 0);
        PL : in  STD_LOGIC;
        PI : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        reset_value : in  STD_LOGIC_VECTOR (15 downto 0);
        clk : in  STD_LOGIC;
        z : out  STD_LOGIC_VECTOR (15 downto 0)
    );
    end component;
    
    component control_addr_reg
    port (
        CAR_in : in  STD_LOGIC_VECTOR (7 downto 0);
        sel : in  STD_LOGIC;
        clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        reset_value : in  STD_LOGIC_VECTOR (7 downto 0);
        CAR_out : out  STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;
    
    component zero_fill
    port (
        value : in  STD_LOGIC_VECTOR (2 downto 0);
        padded : out  STD_LOGIC_VECTOR (15 downto 0)
    );
    end component;    
   
-- signals    

    signal A_data, B_data, mux_d_out, mux_b_out, 
        mux_m_out, f_unit_out, mem_out,
        extend_out, PC_out, ZF_out: std_logic_vector(15 downto 0);    
    signal V, C, N, Z, not_C, not_Z, V_func, C_func,
        N_func, Z_func, mux_s_out : std_logic;
    signal mux_c_out, CAR_out : std_logic_vector(7 downto 0);
    
    -- instruction register out
    signal DR, SA, SB : std_logic_vector(2 downto 0);
    signal opcode : std_logic_vector(7 downto 0);
    
    -- control memory out
    signal MW, MM, RW, MD, MB, TB, TA, TD, PL, PI, IL, SW, MC : std_logic;
    signal FS : std_logic_vector(3 downto 0);
    signal MS : std_logic_vector(2 downto 0);
    signal NA : std_logic_vector(7 downto 0);

begin

    -- flag logic
    not_C <= not C;
    not_Z <= not Z;

    -- register file port map
    reg : reg_file
    port map(
        A_sel => SA,
        B_sel => SB,
        D_sel => DR,
        TA => TA,
        TB => TB,
        TD => TD,
        load => RW,
        clk => clk,
        D_data => mux_d_out,
        A_data => A_data,
        B_data => B_data
    );
 
    -- function unit port map
    funct_unit : function_unit
    port map(
        A => A_data,
        B => mux_b_out,
        FS => FS,
        V => V_func,
        C => C_func,
        N => N_func,
        Z => Z_func,
        F => f_unit_out
    );
    
    -- status flag register port map
    SFR : status_flag_reg
    port map (
        V_in => V_func,
        C_in => C_func,
        N_in => N_func,
        Z_in => Z_func,
        load => SW,
        clk => clk,
        V_out => V,
        C_out => C,
        N_out => N,
        Z_out => Z
    );
    
    -- memory port map
    mem : memory
    port map(
        address => mux_m_out,
        write_data => mux_b_out,
        MemWrite => MW,
        read_data => mem_out
    );
    
    -- control memory port map
    ctrl_mem : control_memory
    port map(
        MW => MW,
        MM => MM,
        RW => RW,
        MD => MD,
        FS => FS,
        MB => MB,
        TB => TB,
        TA => TA,
        TD => TD,
        PL => PL,
        PI => PI,
        IL => IL,
        SW => SW,
        MC => MC,
        MS => MS,
        NA => NA,
        IN_CAR => CAR_out
    );
    
    -- instruction register port map
    inst_reg : instruction_reg
    port map(
        IR => mem_out,
        IL => IL,
        opcode => opcode,
        DR => DR,
        SA => SA,
        SB => SB
    );
    
    -- PC 2s complement extend port map
    exten : extend
    port map(
        DR => DR,
        SA => SA,
        SB => SB,
        z => extend_out
    );
    
    -- program counter port map
    PC : program_counter
    port map(
        addr_offset => extend_out,
        PL => PL,
        PI => PI,
        reset => reset_PC,
        reset_value => reset_val_PC,
        clk => clk,
        z => PC_out
    );
    
    -- control address register port map
    CAR : control_addr_reg
    port map(
        CAR_in => mux_c_out,
        sel => mux_s_out,
        clk => clk,
        reset => reset_CAR,
        reset_value => reset_val_CAR,
        CAR_out => CAR_out
    );
    
    -- zero fill port map
    ZF : zero_fill
    port map(
        value => SB,
        padded => ZF_out
    );

    -- MUX B port map
    mux_b : mux_2to1
    port map(
        In0 => B_data,
        In1 => ZF_out,
        s => MB,
        Z => mux_b_out
    );
 
    -- MUX D port map
    mux_d : mux_2to1
    port map(
        In0 => f_unit_out,
        In1 => mem_out,
        s => MD,
        Z => mux_d_out
    );
    
    -- MUX M port map
    mux_m : mux_2to1
    port map(
        In0 => A_data,
        In1 => PC_out,
        s => MM,
        Z => mux_m_out
    );
    
    -- MUX S port map
    mux_s : mux_8to1_1bit
    port map(
        s => MS,
        in0  => '0',
        in1  => '1',
        in2  => C,
        in3  => V,
        in4  => Z,
        in5  => N,
        in6  => not_C,
        in7  => not_Z,
        z  => mux_s_out
    );
    
    -- MUX C port map
    mux_c : mux_2to1_8bit
    port map(
        In0 => NA,
        In1 => opcode,
        s => MC,
        Z => mux_c_out
    );

end Behavioral;

