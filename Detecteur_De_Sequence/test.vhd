----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:07:48 01/07/2019 
-- Design Name: 
-- Module Name:    test - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
			  sor : out  STD_LOGIC:='0';
           err : out  STD_LOGIC:='0');
end test;

architecture Behavioral of test is

component Detect_seq is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
			  seq : in  STD_LOGIC_VECTOR (89 downto 0);
			  taille : in  integer;
			  sor : out  STD_LOGIC:='0';
           err : out  STD_LOGIC:='0');
end component;

component diviseur_clk is
	Port ( 
	clkin : in STD_LOGIC;
	clk2hz : out STD_LOGIC;
	clk16hz : out STD_LOGIC;
	clk2khz : out STD_LOGIC);
end component;

signal clk1, clk2, clk3 : STD_LOGIC;
--signal btn :   STD_LOGIC_VECTOR (7 downto 0);
signal seq :   STD_LOGIC_VECTOR (89 downto 0);
signal taille : integer;
begin
div: diviseur_clk port map (clk, clk1, clk2, clk3);
seq <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000001110010";	
taille<=4;
detect: Detect_seq port map (clk3, reset, btn, seq, taille, sor, err);
end Behavioral;

