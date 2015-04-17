--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:53:14 06/25/2014
-- Design Name:   
-- Module Name:   /home/christos_pp/Dropbox/Xilinx/DSPs/Ergasia3/Fir_LxParallel/TB_Si_Po_Gen.vhd
-- Project Name:  Fir_LxParallel
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SiPo_Gen
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
 
ENTITY TB_Si_Po_Gen IS
END TB_Si_Po_Gen;
 
ARCHITECTURE behavior OF TB_Si_Po_Gen IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SiPo_Gen
	 generic (L : integer := 4;
    	        bus_width : integer := 8 );
    PORT(
         Xin : IN  std_logic_vector(7  downto 0);
         Sipo_Bus_out : OUT  std_logic_vector(31  downto 0);
         Clk : IN  std_logic;
         Reset : IN  std_logic;
           Sync_out : out STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal Xin : std_logic_vector(7 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Sipo_Bus_out : std_logic_vector(31 downto 0);
	signal  Sync_out :  STD_LOGIC:= '0';
   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SiPo_Gen PORT MAP (
          Xin => Xin,
          Sipo_Bus_out => Sipo_Bus_out,
          Clk => Clk,
          Reset => Reset,
            Sync_out =>Sync_out
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
		Reset <= '1';
		wait for Clk_period;
		Reset <= '0';
		Xin <= "00000001";
		wait for Clk_period;
		Xin <= "00000011";
		wait for Clk_period;
		Xin <= "00000010";
		wait for Clk_period;
		Xin <= "00000101";
		wait for Clk_period;
		Xin <= "00001001";
		wait for Clk_period;
		Xin <= "00001011";
		wait for Clk_period;
		Xin <= "00100010";
		wait for Clk_period;
		Xin <= "00000111";

      -- insert stimulus here 

      wait;
   end process;

END;
