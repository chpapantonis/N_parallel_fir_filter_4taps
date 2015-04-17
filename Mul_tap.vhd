----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:20:57 05/21/2014 
-- Design Name: 
-- Module Name:    Mul_tap - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mul_tap is
generic (	arth :integer := 0;
		only_fraction : integer := 1;
		a : integer := 1;
		b : integer := 1;
		bus_width : integer := 8);
Port (
	Xn : in  STD_LOGIC_VECTOR (bus_width -1 downto 0);
  	Yn : out  STD_LOGIC_VECTOR (bus_width -1 downto 0));
end Mul_tap;

architecture Behavioral of Mul_tap is

-------signals for control and assignment---------
	--signal control : integer := 0;
	signal integer_part : std_logic_vector (bus_width-1 downto 0) := (others=> '0');
	signal fraction_part : std_logic_vector (bus_width-1 downto 0):= (others=> '0');
-----------------------------------------		
	
begin
process (Xn)
begin	
	if (a = 0 ) then  
		if (only_fraction = 1) then
			integer_part <= (others=>'0');
			fraction_part <=  to_stdlogicvector(to_bitvector(Xn) sra b);
		else		    
			integer_part <= Xn;
			fraction_part <= to_stdlogicvector(to_bitvector(Xn) sra b); 
		end if;	
	else if b = 0 then 
		integer_part <= to_stdlogicvector(to_bitvector(Xn) sll a);
		fraction_part <= (others=>'0');
	else
		integer_part <= to_stdlogicvector(to_bitvector(Xn) sll a);
		fraction_part <= to_stdlogicvector(to_bitvector(Xn) sra b);
	end if; 
	end if;
end process;

Yn <= ( (not integer_part) +'1' + ((not fraction_part)+ '1')) when arth = 1 
		else integer_part + fraction_part; 
		
end Behavioral;

