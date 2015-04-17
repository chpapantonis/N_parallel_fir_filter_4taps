----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:33:05 06/20/2014 
-- Design Name: 
-- Module Name:    Fir_Module - Behavioral 
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
use ieee. STD_LOGIC_unsigned.all;
use ieee. STD_LOGIC_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Fir_Module is
Generic  (bus_width : integer := 8);
    Port ( X1 : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
           X2 : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
           X3 : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
           X4 : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
           Fir_out : out  STD_LOGIC_VECTOR (bus_width-1 downto 0));
end Fir_Module;

architecture Behavioral of Fir_Module is
---------------Components-------------
component Mul_tap 
generic (arth :integer:= 0;
			only_fraction : integer := 0;
			a : integer := 1;
			b : integer := 1;
			bus_width : integer := 8);
Port (
		Xn : in  STD_LOGIC_VECTOR (bus_width-1 downto 0);
      Yn : out  STD_LOGIC_VECTOR (bus_width-1 downto 0));
end component;
-------------------------------------
---Signals
signal Y1_out : std_logic_vector (bus_width-1 downto 0);
signal Y2_out : std_logic_vector (bus_width-1 downto 0);
signal Y3_out : std_logic_vector (bus_width-1 downto 0);
signal Y4_out : std_logic_vector (bus_width-1 downto 0);
--------------------------

begin

Tap_1 : Mul_tap generic map (arth => 0 , only_fraction => 0, a => 1 , b=>1) port map (Xn => X1, Yn => Y1_out); 
Tap_2 : Mul_tap generic map (arth => 0 , only_fraction => 0, a => 2 , b=>0) port map (Xn => X2, Yn => Y2_out); 
Tap_3 : Mul_tap generic map (arth => 1 , only_fraction => 0, a => 2 , b=>0) port map (Xn => X3, Yn => Y3_out); 
Tap_4 : Mul_tap generic map (arth => 1 , only_fraction => 0, a => 1 , b=>1) port map (Xn => X4,	Yn => Y4_out);

Fir_out <= Y1_out + Y2_out + Y3_out + Y4_out;

end Behavioral;

