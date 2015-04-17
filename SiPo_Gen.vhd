----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:23:07 06/24/2014 
-- Design Name: 
-- Module Name:    SiPo_Gen - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SiPo_Gen is
    generic (L : integer := 4;
    	        bus_width : integer := 8 );
    Port ( Xin : in  STD_LOGIC_VECTOR (bus_width -1 downto 0);
           Sipo_Bus_out : out  STD_LOGIC_VECTOR ((L*bus_width-1) downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Sync_out : out STD_LOGIC);
end SiPo_Gen;

architecture Behavioral of SiPo_Gen is

signal  reg_in : std_logic_vector (L*bus_width-1 downto 0);
signal  reg_out : std_logic_vector (L*bus_width-1 downto 0);

signal sync : std_logic;

begin

process(Clk , Reset)
variable counter : integer range 0 to L -1 := L-1;
begin
if Reset = '1'then 
	reg_in <= (others =>'0');
	counter := L-1;
else if rising_Edge(Clk) then 
	if counter = L-1 then 
		sync <= '1';
		reg_out <= reg_in;
	else 
		sync <= '0';
	end if;
	if counter > 0 then
		reg_in((L*bus_width -1)-(bus_width*counter) downto (L*bus_width-1)-(bus_width*(counter +1)-1)) <= Xin ; 
		counter := counter - 1;
	else   
		reg_in (L*bus_width-1 downto L*bus_width - bus_width) <= Xin;
		counter := L-1;
	end if;
end if; 
end if;	
end process ;

Sipo_Bus_out  <= reg_out;
Sync_out <= sync;
end Behavioral;

