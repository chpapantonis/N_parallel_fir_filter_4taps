----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:23:31 06/27/2014 
-- Design Name: 
-- Module Name:    Fir_Top_Gen - Behavioral 
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

entity Fir_Top_Gen is
generic (L : integer := 8;
    	        bus_width : integer := 8 );
    Port (
         Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Digit :  out STD_LOGIC_VECTOR (3 downto 0 );
           Segments : out STD_LOGIC_VECTOR(7 downto 0);
           Yout : out  STD_LOGIC_VECTOR (bus_width-1 downto 0));
end Fir_Top_Gen;

architecture Behavioral of Fir_Top_Gen is

-----Components-------------------
component Fir_Parallel_Gen is
	Generic  (L : integer := 4;
    	        bus_width : integer := 8 );
    Port ( Xin : in  STD_LOGIC_VECTOR (L*bus_width-1 downto 0);
           Yout : out  STD_LOGIC_VECTOR (L*bus_width-1 downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end  component Fir_Parallel_Gen;

component SiPo_Gen is
    generic (L : integer := 4;
    	        bus_width : integer := 8 );
    Port ( Xin : in  STD_LOGIC_VECTOR (bus_width -1 downto 0);
           Sipo_Bus_out : out  STD_LOGIC_VECTOR ((L*bus_width-1) downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Sync_out : out STD_LOGIC);
end  component SiPo_Gen;

component PiSo_Gen is
	Generic  (L : integer := 4;
    	        bus_width : integer := 8 );
    Port (
			Clk : in STD_LOGIC;
			Reset : in STD_LOGIC;
			Cnt_Sync : in STD_LOGIC;
			Xin : in  STD_LOGIC_VECTOR (L*bus_width-1 downto 0);
           Yout : out  STD_LOGIC_VECTOR (bus_width-1 downto 0));
end component PiSo_Gen;

component Clk_Divider is
	Generic( D : integer := 12500000);
    Port ( Clk_in : in  STD_LOGIC;
           Clk_out : out  STD_LOGIC;
           Reset : in  STD_LOGIC);
end  component Clk_Divider;

component fifo_rom is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_out : out  std_logic_vector (7 downto 0));
end component fifo_rom;

component seven_segment_controller_top is
    Port ( clk_1Khz : in  STD_LOGIC;
	        reset : STD_LOGIC;
           BCD : in  STD_LOGIC_VECTOR (15 downto 0);
           digits_out : out  STD_LOGIC_VECTOR (3 downto 0);
           segments_out : out  STD_LOGIC_VECTOR (7 downto 0));
end component seven_segment_controller_top;

component Segment_Divider is
    Port ( Xn : in  STD_LOGIC_VECTOR (7 downto 0);
           Digits : out  STD_LOGIC_VECTOR (15 downto 0));
end component Segment_Divider;

---------------Signals----------------------------------
---rologia
signal Clk_1Hz_out : std_logic;
signal Clk_10KHz_out : std_logic;
signal Mimo_sync_in : std_logic;
----ROM
signal Rom_out : std_logic_vector (7 downto 0);
--SiPo
signal SiPo_out : std_logic_vector (L*bus_width-1 downto 0);
---Fir---
signal Mimo_out : std_logic_vector (L*bus_width-1 downto 0);
--Piso
signal Piso_out  : std_logic_vector (bus_width-1 downto 0);
---7 segments
signal Seven_seg_final : std_logic_vector( 15 downto 0);


begin
---WIRING
----Clk_Dividers
Clk_1Hz : Clk_Divider generic map (D => 500000) port map (Clk_in => Clk , Reset => Reset , Clk_out => Clk_1Hz_out);
Clk_10Khz : Clk_Divider generic map (D => 50000) port map (Clk_in => Clk , Reset => Reset , Clk_out => Clk_10KHz_out);--10khz
----ROM
Rom : fifo_rom  port map (Clk =>Clk_1Hz_out , Reset =>Reset , Data_out => Rom_out);
----Si_Po
SiPo : SiPo_Gen generic map (L =>L , bus_width => bus_width) port map (Clk => Clk_1Hz_out , Reset => Reset , Xin => Rom_out , Sync_out => Mimo_sync_in , Sipo_Bus_out => SiPo_out);
----Fir---
Fir : Fir_Parallel_Gen  generic map (L =>L , bus_width => bus_width) port map (Clk => Mimo_sync_in , Reset => Reset , Xin => SiPo_out , Yout => Mimo_out);
---Pi_So
PiSo : PiSo_Gen generic map (L =>L , bus_width => bus_width) port map (Clk => Clk_1Hz_out , Reset => Reset , Cnt_Sync => Mimo_sync_in, Xin => Mimo_out , Yout =>Piso_out);
---7segments
Seg_Divider : Segment_Divider port map(Xn => Piso_out , Digits => Seven_seg_final); --- Divides the digit of the number 
Display_unit : seven_segment_controller_top port map ( clk_1Khz => Clk_10KHz_out , reset => Reset , BCD => Seven_seg_final , digits_out => Digit , segments_out => Segments);

Yout <= Piso_out ;


end Behavioral;

