library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ripple_adder_input_logic is
    port (
        B : in STD_LOGIC_VECTOR (15 downto 0);
        Y : out STD_LOGIC_VECTOR (15 downto 0);
        s0 : in STD_LOGIC;
        s1 : in STD_LOGIC
    );
end ripple_adder_input_logic;

architecture Behavioral of ripple_adder_input_logic is

    component adder_input_logic
        port (
            B : in STD_LOGIC;
            Y : out STD_LOGIC;
            s0 : in STD_LOGIC;
            s1 : in STD_LOGIC
        );
    end component;

begin
    -- generate port maps
    GEN_AIL : for i in 0 to 15 generate
        ail : adder_input_logic
        port map(
            B => B(i), 
            Y => Y(i), 
            s0 => s0, 
            s1 => s1
        ); 
    end generate GEN_AIL;
 
end Behavioral;