--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:22:33 04/14/2016
-- Design Name:   
-- Module Name:   D:/AlexFile/FIR/TB.vhd
-- Project Name:  FIR
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FirModule
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
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.std_logic_arith.all;

 
ENTITY TB IS
END TB;
 
ARCHITECTURE behavior OF TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FirModule
    PORT(
         clk : IN  std_logic;
         input : IN  std_logic_vector(11 downto 0);
         output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 

    

   --Inputs
   signal clk : std_logic := '0';
   signal input : std_logic_vector(11 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(15 downto 0):= std_logic_vector(conv_signed(integer(0),16));

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FirModule PORT MAP (
          clk => clk,
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
		input <= std_logic_vector(to_signed(0,12));
		--wait for clk_period;
		for i in 0 to  5 loop
			wait for clk_period;
			input <= input + 1;
		end loop;
		for i in 0 to 5 loop
			wait for clk_period;
			input <= input - 1;
		end loop;
		for i in 0 to  5 loop
			wait for clk_period;
			input <= input - 1;
		end loop;
		for i in 0 to 5 loop
			wait for clk_period;
			input <= input + 1;
		end loop;
--		input <= std_logic_vector(to_unsigned(1,12));
--		wait for clk_period;
--		input <= (others=>'0');
      --wait;
   end process;

END;
