--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:27:07 06/20/2014
-- Design Name:   
-- Module Name:   /home/christos_pp/Dropbox/Xilinx/DSPs/Ergasia3/Fir_4xTap_4xParallel/SiPo_Tb.vhd
-- Project Name:  Fir_4xTap_4xParallel
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Si_Po
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
 
ENTITY SiPo_Tb IS
END SiPo_Tb;
 
ARCHITECTURE behavior OF SiPo_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Si_Po
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Xn : IN  std_logic_vector(7 downto 0);
         X4k : OUT  std_logic_vector(7 downto 0);
         X4k_1 : OUT  std_logic_vector(7 downto 0);
         X4k_2 : OUT  std_logic_vector(7 downto 0);
         X4k_3 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Xn : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal X4k : std_logic_vector(7 downto 0);
   signal X4k_1 : std_logic_vector(7 downto 0);
   signal X4k_2 : std_logic_vector(7 downto 0);
   signal X4k_3 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Si_Po PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Xn => Xn,
          X4k => X4k,
          X4k_1 => X4k_1,
          X4k_2 => X4k_2,
          X4k_3 => X4k_3
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
		Xn <= "00000001";
		wait for Clk_period;
		Xn <= "00000011";
		wait for Clk_period;
		Xn <= "00000010";
		wait for Clk_period;
		Xn <= "00000101";
		wait for Clk_period;
		Xn <= "00001001";
		wait for Clk_period;
		Xn <= "00001011";
		wait for Clk_period;
		Xn <= "00100010";
		wait for Clk_period;
		Xn <= "00000111";

      -- insert stimulus here 

      wait;
   end process;

END;
