----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:16:48 05/19/2014 
-- Design Name: 
-- Module Name:    segments_mux - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segments_mux is
    Port ( segments_mux_control : in  STD_LOGIC_VECTOR (3 downto 0);
           segments_mux_out : out  STD_LOGIC_VECTOR (7 downto 0));
end segments_mux;

architecture Behavioral of segments_mux is


signal temp : std_logic_vector(7 downto 0);


begin

process(segments_mux_control)
begin

case segments_mux_control is
--                    abcdefg.
when "0000" => temp<="00000011";   --0
--                    abcdefg.
when "0001" => temp<="10011111";   --1
--                    abcdefg.
when "0010" => temp<="00100101";   --2
--                    abcdefg.
when "0011" => temp<="00001101";   --3
--                    abcdefg.
when "0100" => temp<="10011001";   --4
--                    abcdefg.
when "0101" => temp<="01001001";   --5
--                    abcdefg.
when "0110" => temp<="01000001";   --6
--                    abcdefg.
when "0111" => temp<="00011111";   --7
--                    abcdefg.
when "1000" => temp<="00000001";   -- 8 

when "1001" => temp<="00001001";   -- 9

when "1111" => temp <="11111101"; -- minus

when others => temp<="11111111";

end case;

end process;


segments_mux_out<=temp;


end Behavioral;

