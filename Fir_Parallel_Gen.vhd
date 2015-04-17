----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:03 06/25/2014 
-- Design Name: 
-- Module Name:    Fir_Parallel_Gen - Behavioral 
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

entity Fir_Parallel_Gen is
	Generic  (L : integer := 4;
    	        bus_width : integer := 8 );
    Port ( Xin : in  STD_LOGIC_VECTOR (L*bus_width-1 downto 0);
           Yout : out  STD_LOGIC_VECTOR (L*bus_width-1 downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end Fir_Parallel_Gen;

architecture Behavioral of Fir_Parallel_Gen is
----Components-------------------------------------
component Fir_Module 
	Generic  (bus_width : integer := 8);
    Port ( X1 : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
           X2 : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
           X3 : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
           X4 : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
           Fir_out : out  STD_LOGIC_VECTOR (bus_width-1 downto 0));
end component;
---------------Signals------------
type In_array is array (0 to 4*L-1) of std_logic_vector(bus_width-1 downto 0);
signal signal_array : In_array;
signal Xin_D : std_logic_vector (L*bus_width-1 downto 0) := (others => '0');  
signal Xin_DD : std_logic_vector (L*bus_width-1 downto 0) := (others => '0');  
signal Xin_DDD : std_logic_vector (L*bus_width-1 downto 0) := (others => '0');  
signal Xin_DDDD : std_logic_vector (L*bus_width-1 downto 0) := (others => '0');  
signal Fir_out : std_logic_vector (0 to L*bus_width-1);
-----------------------------------------------
begin
--Passing Values to the Array
-- Generate_X : process (Clk)
	-- variable counter : integer range 0 to L := 0;
	-- begin
		-- Xn_signal : for i in 0 to 2*L-1 loop 
			-- if i < L then
				-- signal_array(i) <= Xin(((L*bus_width-1)-(bus_width*counter)) downto ((L*bus_width-1)-(bus_width*(counter +1)-1)));
				-- counter := counter +1;
			-- else 
			-- if counter  = L then 
				-- counter := 0;
			-- end if;	
				-- signal_array(i) <= Xin_D(((L*bus_width -1)-(bus_width*counter)) downto ((L*bus_width-1)-(bus_width*(counter +1)-1)));
				-- counter := counter +1;
			-- end if;
		-- end  loop;
	-- end process;
	Generate_X : for i in 0 to 4*L-1 generate
		begin	
			Xn: if i < L generate 
				begin
					signal_array(i) <=  Xin(((L*bus_width-1)-(bus_width*i)) downto ((L*bus_width-1)-(bus_width*(i+1)-1)));
			end generate Xn;
			Xn_DD : if i >= L and i < 2*L  generate	
			begin
					signal_array(i) <=  Xin_DD(((L*bus_width-1)-(bus_width*(i-L))) downto ((L*bus_width-1)-(bus_width*((i-L) +1)-1)));			
			end generate Xn_DD;
			Xn_DDD : if i >= 2*L and i < 3*L generate	
			begin
				signal_array(i) <=  Xin_DDD(((L*bus_width-1)-(bus_width*(i-2*L))) downto ((L*bus_width-1)-(bus_width*((i-2*L) +1)-1)));			
			end generate Xn_DDD;
			Xn_DDDD : if i >= 3*L and i <= 4*L-1 generate	
			begin
				signal_array(i) <=  Xin_DDDD(((L*bus_width-1)-(bus_width*(i-3*L))) downto ((L*bus_width-1)-(bus_width*((i-3*L) +1)-1)));			
			end generate Xn_DDDD;
	end generate Generate_X;		
--Create the delay input

buffer_IO : process(Clk ,Reset)
begin
		 if rising_edge(Clk) then
			Xin_DDDD<=Xin_DDD; ---3 delays stin xeroteri
			Xin_DDD <= Xin_DD;
			Xin_DD <=Xin_D;---Delay so the array get the proper values... 
			Xin_D <= Xin;
		end if;
end process; 
---Generate Fir Modules
Fir_gen :  for i in 0 to L-1 generate 
begin	
		fir :  Fir_Module generic map (bus_width => bus_width) port map (X1 => signal_array(i) , X2 => signal_array(i +1) , X3 => signal_array(i+2), X4 =>signal_array(i+3) , Fir_out =>Fir_out( i*bus_width to (i+1)*bus_width-1));
end generate ;		
---assign buffer to output
Yout <= Fir_out;
end Behavioral;

