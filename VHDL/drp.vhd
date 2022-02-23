library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity drp is
  generic(
    width_addr : natural := 32;
    width_data : natural := 16
  );
  port(
    rst_n       : in  std_logic;
    -- define drp port 
    dclk        : in std_logic;
    den         : in std_logic;
    dwe         : in std_logic;
    daddr       : in std_logic_vector(width_addr-1 downto 0);
    do          : out std_logic_vector(width_data-1 downto 0);
    di          : in std_logic_vector(width_data-1 downto 0);
    drdy        : out  std_logic
  );
end drp;

architecture Behavioral of drp is

  signal data : std_logic_vector(width_data-1 downto 0):= ( 0 => '1', others => '0');
  signal addr : std_logic_vector(width_addr-1 downto 0):= ( 4 => '1', others => '0');

  signal f_read : std_logic := '0';

begin

  process(dclk)
  begin
    if falling_edge(dclk) then

      -- write operate 
      if den = '1' and dwe = '1' then
        if daddr = addr then
          data <= di ;
        end if ;
      end if ;

      -- read operate
      if den = '1' and dwe = '0' then
        if daddr = addr then
          f_read <= '1' ;
        end if ;
      end if ;

      if f_read = '1' then 
        f_read <= '0' ;
      end if ;

    end if;
  end process;

  do <= data;
  drdy <= f_read ;

  
end Behavioral;
