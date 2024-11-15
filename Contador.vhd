library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Contador is
    port (
        Clock, Reset : in std_logic;
        EN           : in std_logic;
        Load         : in std_logic;
        activador    : out std_logic;
        CNT_in       : in std_logic_vector (6 downto 0);
        CNT          : out std_logic_vector(6 downto 0));
end entity;

architecture arch_Contador of Contador is
    signal CNT_int : integer range 0 to 99;
	 signal activador1 : std_logic;
begin
COUNTER : process (Clock, Reset)
begin
    if Reset = '0' then
        CNT_int <= 0;
        activador <= '0';
    elsif rising_edge(Clock) then
        if Load = '1' then
            CNT_int <= to_integer(unsigned(CNT_in));
        elsif EN = '1' then
            if CNT_int = 0 then
				    CNT_int <= to_integer(unsigned(CNT_in));
                activador <= '1';
            else
                CNT_int <= CNT_int - 1;
                activador <= '0';
            end if;
        end if;
    end if;
end process;

    CNT <= std_logic_vector(to_unsigned(CNT_int, 7));
end arch_Contador;
