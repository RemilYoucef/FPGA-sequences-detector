----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:27:34 01/06/2019 
-- Design Name: 
-- Module Name:    encodeur - Behavioral 
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

entity encodeur is
    Port ( btn : in  STD_LOGIC_VECTOR (3 downto 0);
           b : out  STD_LOGIC_VECTOR (1 downto 0);
           gs : out  STD_LOGIC := '0');
end encodeur;

architecture Behavioral of encodeur is

begin
-- Encoder le boutton appuyé
b(0) <= '1' when 
(btn(0) = '0' and btn(1) = '1' and btn(2) = '0' and btn(3) = '0'  ) or
(btn(0) = '0' and btn(1) = '0' and btn(2) = '0' and btn(3) = '1'  ) 
else '0';
b(1) <= '1' when 
(btn(0) = '0' and btn(1) = '0' and btn(2) = '1' and btn(3) = '0' ) or
(btn(0) = '0' and btn(1) = '0' and btn(2) = '0' and btn(3) = '1' ) 
else '0';

-- gs = 1 signifie qu'un boutton à été appuyé
gs <= '1' when btn(0) = '1' or btn(1) = '1' or btn(2) = '1' or btn(3) = '1' 
else '0';


end Behavioral;

