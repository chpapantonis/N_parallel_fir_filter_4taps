----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:37 05/20/2014 
-- Design Name: 
-- Module Name:    seven_segment_controller_top - Behavioral 
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

entity seven_segment_controller_top is
    Port ( clk_1Khz : in  STD_LOGIC;
	        reset : STD_LOGIC;
           BCD : in  STD_LOGIC_VECTOR (15 downto 0);
           digits_out : out  STD_LOGIC_VECTOR (3 downto 0);
           segments_out : out  STD_LOGIC_VECTOR (7 downto 0));
end seven_segment_controller_top;

architecture Behavioral of seven_segment_controller_top is

component counter_2_bits is
    Port ( clk_1kHz : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           counter_out : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

component digit_mux is
    Port ( digit_mux_control : in  STD_LOGIC_VECTOR (1 downto 0);
           digit_mux_out : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component BCD_mux is
    Port ( bcd_mux_control : in  STD_LOGIC_VECTOR (1 downto 0);
           bcd_input : in  STD_LOGIC_VECTOR (15 downto 0);
           bcd_mux_out : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component segments_mux is
    Port ( segments_mux_control : in  STD_LOGIC_VECTOR (3 downto 0);
           segments_mux_out : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal counter_out_int : STD_LOGIC_VECTOR(1 downto 0);
signal bcd_mux_out_int : STD_LOGIC_VECTOR(3 downto 0);


begin

counter : counter_2_bits port map(clk_1Khz=>clk_1Khz , reset=>reset, counter_out=>counter_out_int);
digits_mux : digit_mux port map( digit_mux_control=>counter_out_int, digit_mux_out=>digits_out );
BCD_mux_comp : BCD_mux port map( bcd_mux_control=>counter_out_int, bcd_input=>BCD ,  bcd_mux_out=>bcd_mux_out_int);
segments_mux_comp : segments_mux port map( segments_mux_control=>bcd_mux_out_int, segments_mux_out=>segments_out);

end Behavioral;

