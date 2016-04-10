library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity control_memory is
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
        MC : out std_logic;
        SW : out std_logic;
        MS : out std_logic_vector(2 downto 0);
        NA : out std_logic_vector(7 downto 0);
        IN_CAR : in std_logic_vector(7 downto 0)
    );
end control_memory;

architecture Behavioral of control_memory is
    type mem_array is array(0 to 255) of std_logic_vector(27 downto 0);
    
    -- fetch next instruction control word:
    constant NEXT_INSTR : std_logic_vector(27 downto 0) := x"0020002";
begin
    memory_m : process(IN_CAR)
        variable control_mem : mem_array := (
        
            -- 0x00 fetch next instruction:
            x"0002002", -- increment PC and load from mem
            x"0004002", -- write into instruction register
            x"0030000", -- write opcode into CAR from IR
            
            -- 0x03 ADD
            x"0000024", -- ADD Rd Ra Rb
            NEXT_INSTR, -- fetch next instruction
            
            -- 0x05 ADI (add immediate value)
            x"0000124", -- ADI Rd Ra op
            NEXT_INSTR, -- fetch next instruction

            -- 0x07 INC
            x"0000014", -- INC Rd Ra
            NEXT_INSTR, -- fetch next instruction
            
            -- 0x09 NOT
            x"00000b4", -- NOT Rd Ra
            NEXT_INSTR, -- fetch next instruction
            
            -- 0x0b LD (load)
            x"000000c", -- LD Rd Ra
            NEXT_INSTR, -- fetch next instructions
            
            -- 0x0d SR (store)
            x"00000c1", -- SR Rb M[Ra]
            NEXT_INSTR, -- fetch next instruction
            
            -- 0x0f CMP (compare values)
            x"0008050", -- CMP Ra Rb -- writes to status_flag_reg
            NEXT_INSTR, -- fetch next instruction            
            
            -- 0x11 JMP (unconditional jump)
            x"0001002", -- offset PC and load from mem
            x"0004002", -- write into instruction register
            x"0030000", -- write opcode into CAR from IR            
            
            -- 0x14 BEQ (branch if equal, i.e. Z = 1)
            x"1180050", -- JMP if Ra - Rb is Z = 1
            NEXT_INSTR, -- else fetch next instruction
            
            -- 0x16 LDI (load immediate value)
            x"00001c4", -- LDI Rd op
            NEXT_INSTR, -- fetch next instruction            
            
            others => x"0000000"
        );
        variable addr : integer;
        variable control_out : std_logic_vector(27 downto 0);
    begin
        addr := conv_integer(IN_CAR);
        control_out := control_mem(addr);
        
        --hex digit [0]
        MW <= control_out(0) after 5 ns;
        MM <= control_out(1) after 5 ns;
        RW <= control_out(2) after 5 ns;
        MD <= control_out(3) after 5 ns;
        -- hex digit [1]
        FS <= control_out(7 downto 4) after 5 ns;
        -- hex digit [2]
        MB <= control_out(8) after 5 ns;
        TB <= control_out(9) after 5 ns;
        TA <= control_out(10) after 5 ns;
        TD <= control_out(11) after 5 ns;
        -- hex digit [3]
        PL <= control_out(12) after 5 ns;
        PI <= control_out(13) after 5 ns;
        IL <= control_out(14) after 5 ns;
        SW <= control_out(15) after 5 ns;
        -- hex digit [4]
        MC <= control_out(16) after 5 ns;
        MS <= control_out(19 downto 17) after 5 ns;
        -- hex digit [6:5]
        NA <= control_out(27 downto 20) after 5 ns;
        
    end process;
end Behavioral;