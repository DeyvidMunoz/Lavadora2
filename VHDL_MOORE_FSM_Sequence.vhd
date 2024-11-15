library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity VHDL_MOORE_FSM_Sequence is
    port (
        clk, encendido, tapa, tambor1: in std_logic; 
        rapido, vaciar, j: out std_logic;	 
		  motor1_A, motor1_B, motor2_A, motor2_B : out STD_LOGIC;
        HEX0, HEX1: out std_logic_vector(6 downto 0);
		  beep: buffer STD_LOGIC );
end VHDL_MOORE_FSM_Sequence;

architecture Behavioral of VHDL_MOORE_FSM_Sequence is

component BUZZER 
port(
        CLK , RESET, ander : in STD_LOGIC;
        BEEP: buffer STD_LOGIC);
end component;

component divFrec_6 
port(  clk : in  std_logic;
out1, out2	: BUFFER std_logic);
end component;

component Contador 
port (Clock, Reset : in std_logic;
		EN	: in std_logic;
	   Load : in std_logic;
		activador : out std_logic;
		CNT_in : in std_logic_vector (6 downto 0);
		CNT : out unsigned(6 downto 0));
end component;

component C_Motores 
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        sw1 : in STD_LOGIC;
        sw2 : in STD_LOGIC;
        sw3 : in STD_LOGIC;
        sw4 : in STD_LOGIC;
        motor1_a : out STD_LOGIC;
        motor1_b : out STD_LOGIC;
        motor2_a : out STD_LOGIC;
        motor2_b : out STD_LOGIC);
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
    type estado_type is (inicial, llenado, lavado, vaciado, enjuagar, centrifugar, terminado, pausa);
    signal estado_actual, estado_siguiente : estado_type;
    signal act : std_logic;
    signal cnt : std_logic_vector (6 downto 0);
    signal con1, con2, con3, alarma : std_logic;
    signal CNT1 : unsigned(6 downto 0);
    signal A, B : integer range 0 to 9;
    signal dec, uni : std_logic_vector(3 downto 0);
    signal Reset : std_logic := '1';
    signal Load : std_logic := '0';
    signal EN, SW1, SW2, SW3, SW4 : std_logic; 
    signal Res: std_LOGIC:='0';
begin
    U1: divFrec_6 port map(clk, con1, con2);
    j <= con2;
    EN <= '1' when tapa = '1' else '0';

    U2: Contador Port map(con2, Reset, EN, Load, act, cnt, CNT1);
    U3: Bloque port map(To_integer(unsigned(CNT1)), B, A);
    uni <= std_logic_vector(To_unsigned(A, 4));
    dec <= std_logic_vector(To_unsigned(B, 4));
    U4: DECOBCD port map(uni(3), uni(2), uni(1), uni(0), HEX0);
    U5: DECOBCD port map(dec(3), dec(2), dec(1), dec(0), HEX1);
	 
	 
    U6: C_Motores port map(clk, Res, SW1, SW2, SW3,  SW4, motor1_A, motor1_B, motor2_A, motor2_B );
	 U7: BUZZER port map(clk, alarma, beep );
	 
	 
    process(clk)
    begin       
        if rising_edge(con1) then
            estado_actual <= estado_siguiente;
        end if;
    end process;

    process(estado_actual, act, encendido)
    begin
        estado_siguiente <= estado_actual; 
        case estado_actual is
            when inicial =>
                if encendido = '1' and tambor1 ='1' then
                    estado_siguiente <= llenado;
                end if;
            when llenado =>
                if act = '1' then
                    estado_siguiente <= lavado;
                end if;
            when lavado =>
                if act = '1' then
                    estado_siguiente <= vaciado;
                end if;
            when vaciado =>
                if act = '1' then
                    estado_siguiente <= enjuagar;
                end if;
            when enjuagar =>
                if act = '1' then
                    estado_siguiente <= centrifugar;
                end if;
            when centrifugar =>
                if act = '1' then
                    estado_siguiente <= terminado;
                end if;
            when terminado =>
                if tapa = '1' then
                    estado_siguiente <= inicial;
                end if;
            when others =>
                estado_siguiente <= inicial;
        end case;
    end process;

    process(estado_actual)
    begin
        case estado_actual is
            when inicial =>
                cnt <= "0000000";
					 SW3 <= '0';
					 SW1 <= '0';
                SW2 <= '0';
					 SW4 <= '0';
                vaciar <= '0';
                alarma <= '0';
                rapido <= '0';
            when llenado =>
                SW3 <= '1';
					 SW1 <= '0';
                SW2 <= '0';
					 SW4 <= '0';
                vaciar <= '0';
                alarma <= '0';
                rapido <= '0';
                cnt <= "0000110";
            when lavado =>
                SW3 <= '0';
					 SW1 <= '1';
                SW2 <= '0';
					 SW4 <= '0';
                vaciar <= '0';
                alarma <= '0';
                rapido <= '0';
                cnt <= "0011010";
            when vaciado =>
                cnt <= "0001101";
                SW3 <= '0';
					 SW1 <= '0';
                SW2 <= '0';
					 SW4 <= '0';
                vaciar <= '1';
                alarma <= '0';
                rapido <= '0';
            when enjuagar =>
                cnt <= "0011100";
                SW3 <= '0';
					 SW1 <= '0';
                SW2 <= '1';
					 SW4 <= '0';
                vaciar <= '0';
                alarma <= '0';
                rapido <= '0';
            when centrifugar =>
                cnt <= "0001011";
                SW3 <= '0';
					 SW1 <= '1';
                SW2 <= '0';
					 SW4 <= '0';
                vaciar <= '0';
                alarma <= '0';
                rapido <= '1';
            when terminado =>
                SW3 <= '0';
					 SW1 <= '0';
                SW2 <= '0';
					 SW4 <= '0';
                vaciar <= '0';
                alarma <= '1';
                rapido <= '0';
            when others =>
					 SW3 <= '0';
					 SW1 <= '0';
                SW2 <= '0';
					 SW4 <= '0';
                vaciar <= '0';
                alarma <= '0';
                rapido <= '0';
                cnt <= "0000000";
        end case;
    end process;
	 
end Behavioral;

