----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:16:04 04/14/2016 
-- Design Name: 
-- Module Name:    FirModule - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FirModule is
	port( clk: in std_logic;
			input: in std_logic_vector(11 downto 0);
			output: out std_logic_vector(15 downto 0)
			);
end FirModule;

architecture Behavioral of FirModule is
	signal reg0,reg1,reg2,reg3: std_logic_vector(11 downto 0):=(others => '0');
	signal s0,s1,s2,s3,out1,out2: std_logic_vector(15 downto 0);
	signal h0,h1,h2,h3: std_logic_vector(3 downto 0):= (others=> '0');
	
	component multiplier
	 port(
			A:in std_logic_vector(11 downto 0);
			B:in std_logic_vector(3 downto 0);
			c: out std_logic_vector(15 downto 0)
			);
	 end component;
	 component adder
	 port(
			A:in std_logic_vector(15 downto 0);
			B:in std_logic_vector(15 downto 0);
			c: out std_logic_vector(15 downto 0)
			);
	 end component;

begin
	
	H0 <= std_logic_vector(to_signed(-2,4));
	H1 <= std_logic_vector(to_signed(2,4));
	H2 <= std_logic_vector(to_signed(3,4));
	H3 <= std_logic_vector(to_signed(1,4));

	process(clk)
	begin
		if rising_edge(clk) then
			reg0 <= input;
			reg1 <= reg0;
			reg2 <= reg1;
			reg3 <= reg2;
		end if;
	end process;
	
	mul0: multiplier port map(reg0,h0,s0);
	mul1: multiplier port map(reg1,h1,s1);
	mul2: multiplier port map(reg2,h2,s2);
	mul3: multiplier port map(reg3,h3,s3);
	
	add0: adder port map(s0,s1,out1);
	add1: adder port map(out1,s2,out2);
	add2: adder port map(out2,s3,output);
		
end Behavioral;

