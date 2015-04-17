----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:44:32 06/20/2014 
-- Design Name: 
-- Module Name:    Segment_Divider - Behavioral 
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

use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Segment_Divider is
    Port ( Xn : in  STD_LOGIC_VECTOR (7 downto 0);
           Digits : out  STD_LOGIC_VECTOR (15 downto 0));
end Segment_Divider;



architecture Behavioral of Segment_Divider is
---------Components---------------
component binary_to_decimal 
	port(
	inbcd : in std_logic_vector(13 downto 0);
	 outbcd : out std_logic_vector(17 downto 0));
end component;
-----------signals-------------------
signal Xn_bcd : std_logic_vector (13 downto 0):= (others=>'0');
signal Bcd_Digit_out : std_logic_vector(17 downto 0):= (others=>'0');
signal minus : std_logic_vector (3 downto 0):= (others =>'0');
------------------------------

begin

Xn_bcd <= "000000"&Xn when Xn(7) = '0' else 
		"000000"&(not(Xn) + '1' );	 -- Xn to 14 bit -- Reverse the signal to 2s coplement because bcd takes positive numbers
bdc_unit : binary_to_decimal port map (inbcd => Xn_bcd , outbcd => Bcd_Digit_out);
---Out signal for & segments
Digits <= minus&Bcd_Digit_out(11 downto 0);
minus <= "1111" when Xn(7) = '1' else "0000";

end Behavioral;

