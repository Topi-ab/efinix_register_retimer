library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.float_pkg.all;

entity reg_retimer is
    port(
		clk_in: in std_logic;
		
		a_data_in: in std_logic_vector(31 downto 0);
		
		b_data_out: out std_logic_vector(31 downto 0)
    );
end;

architecture rtl of reg_retimer is
	constant EXP_BITS: integer := 8;
	constant MANT_BITS: integer := 23;

    subtype fp_t is float(EXP_BITS downto -MANT_BITS);
	
	signal a_data_d0: fp_t;
	signal a_data_d1: fp_t;
	signal a_data_d2: fp_t;

	signal b_data_d1: fp_t;
	signal b_data_d2: fp_t;
begin
	a_data_d0 <= float(a_data_in);

	process(clk_in)
	begin
		if rising_edge(clk_in) then
			a_data_d1 <= a_data_d0;
			a_data_d2 <= a_data_d1;
			
			b_data_d1 <= reciprocal(a_data_d2, Denormalize => false, check_error => false, Round_style => round_zero, guard => 0);
			b_data_d2 <= b_data_d1;
		end if;
	end process;
	
	b_data_out <= std_logic_vector(b_data_d2);
end;


