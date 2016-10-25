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

Library std;
use std.textio.all;

 
ENTITY TB IS
END TB;
 
ARCHITECTURE behavior OF TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 
	 COMPONENT FirSymmetric
    PORT(
         clk : IN  std_logic;
			en: in std_logic;
         input : IN  std_logic_vector(15 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal clk : std_logic := '0';
   signal input : std_logic_vector(15 downto 0) := (others => '0');
	signal en: std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(31 downto 0):= std_logic_vector(conv_signed(integer(0),32));
	signal ok: std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	-- FILE IO THINGS
	file file_pointer : text;
	

--function for IO
	impure function fileio(X : std_logic_vector)
              return std_logic is
	variable line_content : string(1 to 32);
	variable line_num : line;
   variable j : integer := 0;
	
	begin
		for j in 0 to 31 loop
            if(X(j) = '0') then
                line_content(32-j) := '0';
            else
                line_content(32-j) := '1';
            end if; 
        end loop;
		write(line_num,line_content); --write the line.
      writeline (file_pointer,line_num); --write the contents into the file.
		return '0';
	end fileio;	
 
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
	
	rst_process: process
	begin
		wait for 67*clk_period;
		en<= '1';
	end process;
	
	--get results and store
	result_proc: process
	begin
	wait for clk_period;
		ok<=fileio(output);
	end process;
	
	--open file and close file
	file_proc:process
	begin
	file_open(file_pointer,"write.txt",WRITE_MODE);
		wait for 2001*clk_period;
	file_close(file_pointer); --Close the file after writing.
	wait;
	end process; 
	
	--Read process
    process 
      file file_pointer : text;
        variable line_content : string(1 to 16);
        variable line_num : line;
        variable j : integer := 0;
        variable char : character:='0'; 
    begin
        --Open the file read.txt from the specified location for reading(READ_MODE).
      file_open(file_pointer,"exportedWave.txt",READ_MODE);    
      while not endfile(file_pointer) loop --till the end of file is reached continue.
      readline (file_pointer,line_num);  --Read the whole line from the file
        --Read the contents of the line from  the file into a variable.
      READ (line_num,line_content); 
        --For each character in the line convert it to binary value.
        --And then store it in a signal named 'bin_value'.
        for j in 1 to 16 loop        
            char := line_content(j);
            if(char = '0') then
                input(16-j) <= '0';
            elsif(char = '1') then
                input(16-j) <= '1';
				else
            end if; 
        end loop;   
        wait for clk_period; --after reading each line wait for 10ns.
      end loop;
      file_close(file_pointer);  --after reading all the lines close the file.  
        wait;
    end process;

END;
