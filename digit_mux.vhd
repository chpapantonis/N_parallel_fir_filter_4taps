----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:49:15 05/19/2014 
-- Design Name: 
-- Module Name:    digit_mux - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digit_mux is
    Port ( digit_mux_control : in  STD_LOGIC_VECTOR (1 downto 0);
           digit_mux_out : out  STD_LOGIC_VECTOR (3 downto 0));
end digit_mux;

architecture Behavioral of digit_mux is

signal temp : std_logic_vector(3 downto 0);


begin

process(digit_mux_control)
begin

case digit_mux_control is
when "00" => temp<="0111";
when "01" => temp<="1011";
when "10" => temp<="1101";
when others => temp<="1110";
end case;

end process;


digit_mux_out<=temp;

end Behavioral;

