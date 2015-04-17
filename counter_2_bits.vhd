----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:13:31 05/19/2014 
-- Design Name: 
-- Module Name:    counter_2_bits - Behavioral 
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
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_2_bits is
    Port ( clk_1kHz : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           counter_out : out  STD_LOGIC_VECTOR (1 downto 0));
end counter_2_bits;

architecture Behavioral of counter_2_bits is

signal temp : std_logic_vector(1 downto 0) := "00";
begin

counter_2bitss : process(clk_1kHz)
begin
if (rising_edge(clk_1kHz)) then
	if (reset='1') then
	temp<="11";
	elsif (temp<"11") then
	temp<=temp+1;
	else
	temp<="00";
	end if;
end if;

end process;

counter_out<=temp;

end Behavioral;

