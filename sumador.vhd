library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sumador is
	port( clk, Reset, EN : in  std_logic;
	   Load : in std_logic;
		CNT_in : in std_logic_vector (6 downto 0);
		HEX0, HEX1	: out std_logic_vector(6 downto 0);
		j1, activador : out std_logic);
end sumador;


architecture arch_sumador of sumador is
	
--component divFrec_6 
--port(  clk : in  std_logic;
--out1, out2	: BUFFER std_logic);
--end component;

component Contador 
port (Clock, Reset : in std_logic;
		EN	: in std_logic;
	   Load : in std_logic;
		activador : out std_logic;
		CNT_in : in std_logic_vector (6 downto 0);
		CNT : out unsigned(6 downto 0));
end component;

component Bloque 
  Port ( sum : in integer range 0 to 99;
  D: out integer range 0 to 9;
  U: out integer range 0 to 9);
end component;


component DECOBCD 
port
  (A, B, C, D : in  std_logic;
  HEX0	: out std_logic_vector (6 downto 0)	);
end component;


SIGNAL con1, con2, con3 : std_logic ;
Signal CNT : unsigned(6 downto 0);
signal A : integer range 0 to 9;
signal B : integer range 0 to 9;
Signal dec : std_logic_vector(3 downto 0);
signal uni : std_logic_vector (3 downto 0);

 
begin
    
   -- U1: divFrec_6 port map(clk, con1, con2);
	 --j1 <= con2;
    U2: Contador Port map(clk, Reset, EN,Load, activador, CNT_in, CNT);
    U3: Bloque port map(To_integer(unsigned(CNT)), B, A);
    uni <= std_logic_vector(To_unsigned(A, 4));
    dec <= std_logic_vector(To_unsigned(B, 4));
    U4: DECOBCD port map(uni(3), uni(2), uni(1), uni(0), HEX0);
    U5: DECOBCD port map(dec(3), dec(2), dec(1), dec(0), HEX1);
	 
end arch_sumador;