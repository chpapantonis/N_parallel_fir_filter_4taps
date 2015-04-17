--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:52:59 06/27/2014
-- Design Name:   
-- Module Name:   E:/Dropbox/Xilinx/DSPs/Ergasia3/Fir_LxParallel/TB_TopModule.vhd
-- Project Name:  Fir_LxParallel
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Fir_Top_Gen
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
 
ENTITY TB_TopModule IS
END TB_TopModule;
 
ARCHITECTURE behavior OF TB_TopModule IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Fir_Top_Gen
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Digit : OUT  std_logic_vector(3 downto 0);
         Segments : OUT  std_logic_vector(7 downto 0);
         Yout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Digit : std_logic_vector(3 downto 0);
   signal Segments : std_logic_vector(7 downto 0);
   signal Yout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Fir_Top_Gen PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Digit => Digit,
          Segments => Segments,
          Yout => Yout
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
      wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
