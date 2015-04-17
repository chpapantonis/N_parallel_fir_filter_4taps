----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:15 06/03/2014 
-- Design Name: 
-- Module Name:    fifo_rom - Behavioral 
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
use IEEE.STD_LOGIC_Unsigned.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_rom is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_out : out  std_logic_vector (7 downto 0));
end fifo_rom;

architecture Behavioral of fifo_rom is

 type rom_type is array (0 to 15) of std_logic_vector (7 downto 0);
signal ROM : rom_type:= (
"00000000", "00000000", "00000000", -- latency FF 	
"00000110", "11111110", "00000100", "11111100", "00000110", "11111010",
"00001000", "11111000", "00000010", "00000010", "00000001", "00000010",
"00000001");


SIGNAL Addr : std_logic_vector(3 downto 0):= ( others=>'0' );

begin


process(Clk,Reset)

	begin

	if (Reset='1') then

		Addr<="0000";
		Data_out <= (others=>'0');
	elsif (rising_edge(Clk)) then
		Data_out<=ROM(conv_INTEGER(Addr));
			if(Addr < "1111") then
				Addr<=Addr+'1';
			end if;
	end if;

end process;

end Behavioral;
