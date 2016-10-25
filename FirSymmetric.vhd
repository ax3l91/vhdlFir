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

entity FirSymmetric is
	generic (N: integer :=64);
	port( clk: in std_logic;
			en: in std_logic;
			input: in std_logic_vector(15 downto 0);
			output: out std_logic_vector(31 downto 0)
			);
end FirSymmetric;

architecture Behavioral of FirSymmetric is
	
	type array16 is array(0 to N-1) of std_logic_vector(15 downto 0);
		signal reg:array16;
	type array16n2 is array(0 to N/2-1) of std_logic_vector(15 downto 0);
		signal s:array16n2;
		signal sreg:array16n2;
		signal h:array16n2;
	type array32n2 is array(0 to N/2-1) of std_logic_vector(31 downto 0);
		signal o:array32n2;
		signal oreg:array32n2;
	type array32n21 is array(0 to N/2-2) of std_logic_vector(31 downto 0);
		signal sum:array32n21;
	type array4n is array (0 to 3) of std_logic_vector(31 downto 0);
		signal sumreg:array4n;
	
	component multiplier
	 port(
			A:in std_logic_vector(15 downto 0);
			B:in std_logic_vector(15 downto 0);
			c: out std_logic_vector(31 downto 0)
			);
	 end component;

	 component adder
	 generic (BITS: integer);
	 port(
			A:in std_logic_vector(BITS-1 downto 0);
			B:in std_logic_vector(BITS-1 downto 0);
			c: out std_logic_vector(BITS-1 downto 0)
			);
	 end component;

begin
	
H(0)<= "1111111111111101";
H(1)<= "0000000000000010";
H(2)<= "0000000000001001";
H(3)<= "1111111111111110";
H(4)<= "1111111111110100";
H(5)<= "0000000000001011";
H(6)<= "0000000000010001";
H(7)<= "1111111111100111";
H(8)<= "1111111111110000";
H(9)<= "0000000000101110";
H(10)<= "0000000000000101";
H(11)<= "1111111110111010";
H(12)<= "0000000000010111";
H(13)<= "0000000001011011";
H(14)<= "1111111110111001";
H(15)<= "1111111110100000";
H(16)<= "0000000010001101";
H(17)<= "0000000001001000";
H(18)<= "1111111100100000";
H(19)<= "1111111111111111";
H(20)<= "0000000100110010";
H(21)<= "1111111101111100";
H(22)<= "1111111010011000";
H(23)<= "0000000101010100";
H(24)<= "0000000101100000";
H(25)<= "1111110101111101";
H(26)<= "1111111100100011";
H(27)<= "0000010001000101";
H(28)<= "1111111101010001";
H(29)<= "1111100001100001";
H(30)<= "0000011001111100";
H(31)<= "0001111101100011";
	

	process(clk)
	begin
		if rising_edge(clk) then
			for i in 0 to N-1 loop
				if (i = 0) then
					reg(i) <=  input;
				else
					reg(i)<= Reg(i-1);					
				end if;
			end loop;
			for i in 0 to N/2 - 1 loop
				oreg(i) <= o(i);
				sreg(i) <= s(i);
			end loop;
			sumreg(0) <= sum(24);
			sumreg(1) <= sum(25);
			sumreg(2) <= sum(26);
			sumreg(3) <= sum(27);
			if en='1' then
				output <= sum(N/2-2);
			else
				output <= (others => '0');
			end if;
		end if;
	end process;
	

	
	generateproc1:
	for i in 0 to (N/2-1) generate
		add: adder
		generic map (BITS =>16)
		port map(reg(i),reg((N-1)-i),s(i));
		
		
	------------------PIPELINE HERE-----------------

		mul: multiplier port map(sreg(i),h(i),o(i));
	end generate generateproc1;
	
	
	------------------PIPELINE HERE-----------------
	
	generateProc3:
	for i in 0 to (N/4-1) generate
		add16:adder
		generic map(Bits =>32)
			port map(oreg(2*i),oreg(2*i+1),sum(i));
	end generate generateProc3;
	
	generateProc4:
	for i in 0 to(N/8-1) generate
		add8:adder
		generic map(bits=>32)
			port map(sum(2*i),sum(2*i+1),sum(N/4 + i));
	end generate generateProc4;
	
	generateProc5:
	for i in 0 to (N/16-1) generate
		add4:adder
		generic map (bits=>32)
			port map (sum(16 + 2*i),sum(16 + 2*i+1),sum(24 + i));
	end generate generateProc5;

	------------------PIPELINE HERE-----------------
	
		generateProc6:
	for i in 0 to (N/32-1) generate
		add2:adder
		generic map (bits=>32)
			port map (sumreg(2*i),sumreg(2*i+1),sum(28+ i));
	end generate generateProc6;
	
	add1:adder
		generic map(bits =>32)
		port map (sum(28),sum(29),sum(30));
	
	
	
		
end Behavioral;

