----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:50:29 06/27/2014 
-- Design Name: 
-- Module Name:    PiSo_Gen - Behavioral 
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

entity PiSo_Gen is
	Generic  (L : integer := 4;
    	        bus_width : integer := 8 );
    Port (
			Clk : in STD_LOGIC;
			Reset : in STD_LOGIC;
			Cnt_Sync : in STD_LOGIC;
			Xin : in  STD_LOGIC_VECTOR (L*bus_width-1 downto 0);
           Yout : out  STD_LOGIC_VECTOR (bus_width-1 downto 0));
end PiSo_Gen;

architecture Behavioral of PiSo_Gen is
---------------------Signals-----------------
--type piso_out is array (0 to L-1) of std_logic_vector(bus_width-1 downto 0);
--signal reg_out : piso_out;
signal  reg_out : std_logic_vector (bus_width-1 downto 0);


begin

buffer_IO : process(Clk,Reset, Cnt_Sync)
variable  counter : integer range 0 to L-1:= L-1;
begin 
	if Reset = '1' then 
		reg_out <=(others =>'0');
		counter := L-1;
	else if rising_edge(Clk) then 
		if Cnt_Sync = '1' then 
			counter := L-1;
			end if;
		if counter > 0 then
			reg_out <=Xin((L*bus_width -1)-(bus_width*counter) downto (L*bus_width-1)-(bus_width*(counter +1)-1)); 
			counter := counter - 1;
		else   
			reg_out <= Xin(L*bus_width-1 downto L*bus_width - bus_width) ;
			counter := L-1 ;
		end if ;
	end if;
	end if;		
end process;

-- Generate_Y : for i in 0 to L-1 generate 
-- begin
	-- reg_out(i) <=  Xin(((L*bus_width-1)-(bus_width*i)) downto ((L*bus_width-1)-(bus_width*(i+1)-1)));
-- end generate; 

-- output : process(Clk,Reset)
-- variable  i : integer range L-1 downto 0 := L-1; 
-- begin
	-- if Reset = '1' then 
		-- Yout <= (others=>'0');
	-- else if rising_edge(Clk)	then 
		-- if i > 0 then 
			-- Yout <= reg_out(i);
			-- i := i -1;
		-- else 
			-- Yout <=reg_out(0);
			-- i := L-1;
		-- end if ;	
	-- end if;
	-- end if;
-- end process;
	
	Yout <= reg_out;
end Behavioral;

