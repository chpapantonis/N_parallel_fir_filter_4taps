----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:03:41 05/19/2014 
-- Design Name: 
-- Module Name:    BCD_mux - Behavioral 
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

entity BCD_mux is
    Port ( bcd_mux_control : in  STD_LOGIC_VECTOR (1 downto 0);
           bcd_input : in  STD_LOGIC_VECTOR (15 downto 0);
           bcd_mux_out : out  STD_LOGIC_VECTOR (3 downto 0));
end BCD_mux;

architecture Behavioral of BCD_mux is

signal temp : std_logic_vector(3 downto 0);

begin

process (bcd_mux_control,bcd_input)
begin

case bcd_mux_control is
when "00" => temp<=bcd_input(15 downto 12);
when "01" => temp<=bcd_input(11 downto 8);
when "10" => temp<=bcd_input(7 downto 4);
when others => temp<=bcd_input(3 downto 0);
end case;


end process;

bcd_mux_out<=temp;


end Behavioral;

