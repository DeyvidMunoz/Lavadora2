Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_16x8_asyn is
	port
	(
     address : in std_logic_vector(3 downto 0);
	  data_out : out std_logic_vector(7 downto 0)
	);
end rom_16x8_asyn;



architecture arch_rom_16x8_asyn of rom_16x8_asyn is

	type ROM_TYPE is array (0 to 15) of std_logic_vector(7 downto 0);
	constant ROM : ROM_TYPE := (0 => x"1E", 
	                            1 => x"5A",
										 2 => x"2D",
										 3 => x"3C",
										 4 => x"4B",
										 5 => x"55",
										 6 => x"66",
										 others => x"FA");

begin

     data_out <= ROM(to_integer(unsigned(address)));
 
end arch_rom_16x8_asyn;