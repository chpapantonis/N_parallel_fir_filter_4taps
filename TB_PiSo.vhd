--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:12:14 06/27/2014
-- Design Name:   
-- Module Name:   /home/christos_pp/Dropbox/Xilinx/DSPs/Ergasia3/Fir_LxParallel/TB_PiSo.vhd
-- Project Name:  Fir_LxParallel
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PiSo_Gen
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
 
ENTITY TB_PiSo IS
END TB_PiSo;
 
ARCHITECTURE behavior OF TB_PiSo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PiSo_Gen
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Xin : IN  std_logic_vector(31 downto 0);
         Yout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Xin : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Yout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PiSo_Gen PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Xin => Xin,
          Yout => Yout
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '1';
		wait for Clk_period/2;
		Clk <= '0';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
      Reset <= '1';
      wait for Clk_period;
      Reset <= '0';	
	  Xin  <="11111100"&"00000100"&"11111110"&"00000110";
     wait for 10 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
