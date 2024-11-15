LIBRARY ieee;
Use ieee.std_logic_1164.all;

entity divFrec_6 is
	port(  clk : in  std_logic;
		out1, out2	: BUFFER std_logic);
end divFrec_6;



architecture arch_divFrec_6 of divFrec_6 is
	SIGNAL count1: INTEGER RANGE 0 TO 24999999;

begin
     process(CLK)
	       VARIABLE count2: INTEGER RANGE 0 TO 25000000;
     Begin 
	       IF(clk'EVENT AND CLK='1') THEN
			   count1 <= count1 +1;
				count2 := count2+1;
			IF (count1 = 24999999) then
			   out1 <= NOT out1;
				count1 <= 0;
		   end if;
			IF (count2 = 25000000) then
			out2 <= NOT out2;
			count2 := 0;
			end if;
		end if;
	END process;
			   
end arch_divFrec_6;
