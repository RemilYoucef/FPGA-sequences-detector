----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:19:10 01/06/2019 
-- Design Name: 
-- Module Name:    Detect_seq - Behavioral 
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

entity Detect_seq is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
			  seq : in  STD_LOGIC_VECTOR (89 downto 0);
			  taille : in  integer;
			  sor : out  STD_LOGIC:='0';
           err : out  STD_LOGIC:='0');
end Detect_seq;

architecture Behavioral of Detect_seq is

component encodeur is
    Port ( btn : in  STD_LOGIC_VECTOR (3 downto 0);
           b : out  STD_LOGIC_VECTOR (1 downto 0);
           gs : out  STD_LOGIC);
end component;

component debounce is
    Port ( D_IN : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           Q_OUT : out  STD_LOGIC);
end component;


signal gs, temp:STD_LOGIC; 
signal r:STD_LOGIC_VECTOR (3 downto 0);
signal b:STD_LOGIC_VECTOR (1 downto 0);
signal etatpres, etatsuiv : integer  ;


begin


--Filtrage du bruit des boutons
deb1: debounce port map (btn(0), clk, r(0));
deb2: debounce port map (btn(1), clk, r(1));
deb3: debounce port map (btn(2), clk, r(2)); 
deb4: debounce port map (btn(3), clk, r(3));

--Encodage des boutons
encod: encodeur port map (r, b, gs) ;

--registre d'etat
xreg: process(reset,clk)
	begin
		if(reset = '1') then
		       etatpres <= 0;
		elsif(clk'event and clk = '1')then
		       etatpres <= etatsuiv;
	   end if;
	end process;
--Transition dans l'automate
xifl: process(seq, reset, b , gs, clk) 
variable j : integer;
begin
	if(clk'event and clk = '1')then
		if(reset = '1') then 
			err <= '0';
			sor <= '0';
			j:=0;
		end if;
		if(etatpres rem 2 =0 )then
			if(gs = '1' and b(0) = seq(2*j) and b(1) = seq(2*j+1))  then
				etatsuiv <= etatpres+1; 
				j:=j+1;
				if (j=taille )then 
					sor <= '1';
				end if;
			elsif ((b(0) /= seq(2*j) or b(1) /= seq(2*j+1)) and gs='1') then 
				err<= '1';
			else
				etatsuiv <= etatpres;
			end if;			
		else
			if(gs = '0')then
				etatsuiv <= etatpres+1;
			else
				etatsuiv <= etatpres;
			end if;
		end if;
	end if ;
end process;

end Behavioral;