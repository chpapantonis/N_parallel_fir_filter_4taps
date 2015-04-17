--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:33:25 06/26/2014
-- Design Name:   
-- Module Name:   E:/Dropbox/Xilinx/DSPs/Ergasia3/Fir_LxParallel/TB_MIMO.vhd
-- Project Name:  Fir_LxParallel
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Fir_Parallel_Gen
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_MIMO IS
END TB_MIMO;
 
ARCHITECTURE behavior OF TB_MIMO IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Fir_Parallel_Gen
    PORT(
         Xin : IN  std_logic_vector(31 downto 0);
         Yout : OUT  std_logic_vector(31 downto 0);
         Clk : IN  std_logic;
         Reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Xin : std_logic_vector(31 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Yout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Fir_Parallel_Gen PORT MAP (
          Xin => Xin,
          Yout => Yout,
          Clk => Clk,
          Reset => Reset
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Xin  <="11111100"&"00000100"&"11111110"& "00000110";
		wait for Clk_period ;
		Xin <="11111000"&"00001000"&"11111010"&"00000110";
		
      

      -- insert stimulus here 

      wait;
   end process;

END;
