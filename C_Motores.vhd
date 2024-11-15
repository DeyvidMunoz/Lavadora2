library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C_Motores is
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
end C_Motores;

architecture Behavioral of C_Motores is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            motor1_a <= '0';
            motor1_b <= '0';
            motor2_a <= '0';
            motor2_b <= '0';
        elsif rising_edge(clk) then
            -- Motor 1
            if sw1 = '1' and sw2 = '0' then
                motor1_a <= '1';
                motor1_b <= '0';
            elsif sw1 = '0' and sw2 = '1' then
                motor1_a <= '0';
                motor1_b <= '1';
            else
                motor1_a <= '0';
                motor1_b <= '0';
            end if;

            -- Motor 2 
            if sw3 = '1' and sw4 = '0' then
                motor2_a <= '1';
                motor2_b <= '0';
            elsif sw3 = '0' and sw4 = '1' then
                motor2_a <= '0';
                motor2_b <= '1';
            else
                motor2_a <= '0';
                motor2_b <= '0';
            end if;
        end if;
    end process;
end Behavioral;