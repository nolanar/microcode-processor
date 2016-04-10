library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity memory is
    Port ( address : in STD_LOGIC_VECTOR (15 downto 0);
           write_data : in  STD_LOGIC_VECTOR (15 downto 0);
           MemWrite : in  STD_LOGIC;
           read_data : out  STD_LOGIC_VECTOR (15 downto 0));
end memory;

architecture Behavioral of memory is

    type mem_array is array(0 to 511) of STD_LOGIC_VECTOR(15 downto 0);

begin
    mem_process: process(address, write_data, MemWrite)
        -- initialize data memory, X denotes hexadecimal number
        variable data_mem : mem_array := (
                
            -- 0x00 Data:
            x"0000", x"0001", x"0002", x"0003",
            x"0004", x"0005", x"0006", x"0007",
            x"dead", x"feed", x"1000", x"cafe",
            x"1111", x"1000", x"0111", x"1010", 
            
            -- 0x10 Program:
            -- init:
            --   PC  := 0x000f
            --   CAR := 0x00   -- fetch next instruction

            -- LDI R0 #0
            x"2C00",

            -- ADI R0, R0, #5
            x"0a05",

            -- ADD R1, R0, R0
            x"0640",
                
            -- LD R2, M(R1)
            x"1688",
                
            -- SR R1, M(R1)
            x"1A09",
                
            -- INC R3, R1
            x"0EC8",
                
            -- NOT R4, R3
            x"1318",
                
            -- JMP #9
            x"2209",
                
            -- 8 word block:
            x"0000", x"0000", x"0000", x"0000",
            x"0000", x"0000", x"0000", x"0000",
                
            -- CMP R0, R1
            x"1E01", -- not equal
                
            -- BEQ #5
            x"2805", -- won't break

            -- CMP R0, R0
            x"1E00", -- equal

            -- BEQ #5
            x"2805", -- will break   

            -- 4 word block:
            x"0000", x"0000", x"0000", x"0000",

            -- JMP #0
            x"2200", -- wait
            
            others => x"0000"
        );
        variable addr : integer;
    begin
        addr := conv_integer(unsigned(address(8 downto 0)));
        
        if MemWrite = '1' then
            data_mem(addr) := write_data;
        end if;
           
       read_data <= data_mem(addr) after 5 ns;
    end process;

end Behavioral;
