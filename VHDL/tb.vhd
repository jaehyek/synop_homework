----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/02/15 21:42:53
-- Design Name: 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture sim of tb is
	component main is
        port (
            clock_in : in std_logic; 
    		rst_n   : in std_logic
        );
    end component;

    signal Clk,rst_n    : std_logic := '1';
    constant Clk_period : time := 2 ns;    --clock period.

begin

	Clk <= not Clk after Clk_period/2;
	UUT: main 
		port map(
			clock_in => Clk,
			rst_n =>rst_n
			);

	process

	begin 
		rst_n <= '0';
        wait for Clk_period;
        rst_n <= '1';

        wait;

	end process;


end sim;
