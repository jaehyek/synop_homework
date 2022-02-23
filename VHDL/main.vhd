library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity main is
  generic (
    width_addr : natural := 32;
    width_data : natural := 16
  );
  port(
    clock_in : in std_logic; 
    rst_n   : in std_logic

  );
end main;

architecture Behavioral of main is
  signal control_tgt : std_logic;

  signal dclk : std_logic;
  signal den : std_logic;
  signal dwe : std_logic;
  signal drdy : std_logic;

  signal daddr : std_logic_vector(width_addr-1 downto 0);
  signal do_write : std_logic_vector(width_data-1 downto 0);
  signal di_read  : std_logic_vector(width_data-1 downto 0);
begin

  generate_cmd : entity work.gen_cmd
    port map(
      clock_in      => clock_in,       -- in
      rst_n         => rst_n,          -- in
      control_tgt   => control_tgt
      );

  mymodule_block : entity work.mymodule
    generic map(
    width_addr => width_addr,
    width_data => width_data
    )
    port map (
      clock_in    => clock_in,        -- in 
      rst_n       => rst_n,           -- in 
      control_tgt => control_tgt,     -- in 

      dclk        => dclk,            -- out 
      den         => den,             -- out 
      dwe         => dwe,             -- out
      daddr       => daddr,           -- out
      do          => do_write,        -- out
      di          => di_read,         -- in
      drdy        => drdy             -- in

    );

  drp_interface : entity work.drp
    generic map(
    width_addr => width_addr,
    width_data => width_data
    )
    port map (
      rst_n       => rst_n,           -- in 
      dclk        => dclk,            -- in 
      den         => den,             -- in 
      dwe         => dwe,             -- in
      daddr       => daddr,           -- in
      do          => di_read,         -- out
      di          => do_write,        -- in
      drdy        => drdy             -- out
      );   -- out


end Behavioral;
