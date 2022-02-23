library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity gen_cmd is
  port(
    clock_in    : in  std_logic;
    rst_n       : in  std_logic;
    control_tgt : out  std_logic
  );
end gen_cmd;

architecture Behavioral of gen_cmd is

  signal count_64clk : integer range 0 to 63 := 0 ;
  signal cmd_flag : std_logic := '0';

begin

  process(clock_in)
  begin
    if falling_edge(clock_in) then
      if count_64clk >= 63 then
        cmd_flag <= '1';
        count_64clk <= 0 ;
      else
        cmd_flag <= '0';
        count_64clk <= count_64clk + 1 ;
      end if ;

    end if;
  end process;

  control_tgt <= cmd_flag;

end Behavioral;
