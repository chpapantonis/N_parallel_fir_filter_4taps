----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:22:13 05/13/2014 
-- Design Name: 
-- Module Name:    Clk_Divider - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clk_Divider is
	Generic( D : integer := 12500000);
    Port ( Clk_in : in  STD_LOGIC;
           Clk_out : out  STD_LOGIC;
           Reset : in  STD_LOGIC);
end Clk_Divider;

architecture Behavioral of Clk_Divider is
signal step : integer range 0 to D := 0;  
signal temp : std_logic := '0';
begin
process(Clk_in,Reset)

 begin
	 if Reset = '1' then
		 temp <= '0';
		 step <= 0;
	 elsif Clk_in'event and Clk_in = '1' then
		 if step = D/2 -1  then
			 step <= 0;
			 temp <= not temp;
		 else
			 step <= step + 1;
		end if;
	 end if;
 end process; 
 
Clk_out <= temp;
end Behavioral;

