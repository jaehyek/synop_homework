library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;           -- Needed for shifts



entity mymodule is
  generic(
    width_addr : natural := 32;
    width_data : natural := 16
  );
  port(
    clock_in    : in  std_logic;
    rst_n       : in  std_logic;
    control_tgt : in  std_logic;
    -- define drp port 
    dclk        : out std_logic;
    den         : out std_logic;
    dwe         : out std_logic;
    daddr       : out std_logic_vector(width_addr-1 downto 0);
    do          : out std_logic_vector(width_data-1 downto 0);
    di          : in std_logic_vector(width_data-1 downto 0);
    drdy        : in  std_logic
  );
end mymodule;

architecture Behavioral of mymodule is

  signal addr : std_logic_vector(width_addr-1 downto 0) := ( 4 => '1' , others => '0');
  signal data : std_logic_vector(width_data-1 downto 0);
  signal en : std_logic := '0';
  signal we : std_logic := '0';
  signal f_write : std_logic;

begin

  process(clock_in)
  begin
    if falling_edge(clock_in) then

      -- read operation 
      if control_tgt = '1' then
        en <= '1';
        we <= '0';
      end if ;

      if en = '1' then 
        en <= '0';
        we <= '0';
      end if ;

      if drdy = '1' then
        data <= std_logic_vector(shift_left(unsigned(di), 1));   -- multiply by 2 
        f_write <= '1' ;
      end if ;

      -- write operation
      if f_write = '1' then 
        f_write <= '0';
        en <= '1';
        we <= '1';
      end if ;


    end if;
  end process;

  daddr <= addr ;
  do <= data ;
  den <= en ;
  dwe <= we ;


  dclk <= clock_in;


end Behavioral;
