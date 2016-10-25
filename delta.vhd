--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:39:58 10/12/2016
-- Design Name:   
-- Module Name:   D:/AlexFile/FIR_SYMMETRIC/delta.vhd
-- Project Name:  FIR_SYMMETRIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FirSymmetric
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
 
ENTITY delta IS
END delta;
 
ARCHITECTURE behavior OF delta IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FirSymmetric
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         input : IN  std_logic_vector(15 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal input : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FirSymmetric PORT MAP (
          clk => clk,
          en => en,
          input => input,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 64*clk_period;
		input<= "0000000000000001";
		wait for clk_period;
		input<= "0000000000000000";
		wait for clk_period*2;
		en<='1';


      -- insert stimulus here 

      wait;
   end process;

END;
