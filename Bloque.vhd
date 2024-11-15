Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Bloque is
Port ( sum : in integer range 0 to 99;
       D: out integer range 0 to 9;
       U: out integer range 0 to 9);
end Bloque;


architecture arch_Bloque of Bloque is

	

begin

	D <= sum / 10;
	U <= sum mod 10;

end arch_Bloque;


