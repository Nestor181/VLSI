entity display is
  port(
    clk 	: in std_logic;                  
    D0	: in unsigned( 3 downto 0 );       
    D1	: in unsigned( 3 downto 0 );       
    D2	: in unsigned( 3 downto 0 );       
    D3	: in unsigned( 3 downto 0 );       
    L		: out std_logic_vector( 6 downto 0 ); 
    A		: out std_logic_vector( 3 downto 0 )  
  );
  
end;

architecture arq of display is
  signal digito: unsigned( 1 downto 0 );   
  signal contador: unsigned( 25 downto 0 ); 

  begin

  -- Proceso que cuenta el reloj y selecciona el dígito a mostrar
  process( clk )
  begin
  
    if rising_edge( clk ) then
      if contador = 50000000 - 1 then   
        contador <= ( others => '0' );
        if digito = 3 then
          digito <= ( others => '0' );
        else
          digito <= digito + 1;
        end if;
      else
        contador <= contador + 1;
      end if;
    end if;
	 
  end process;

  -- Asignación a los segmentos según el dígito seleccionado
  with digito select
    L <=
      "0000001" when 0,   -- 0
      "1001111" when 1,   -- 1
      "0010010" when 2,   -- 2
      "0000110" when 3,   -- 3
      "1001100" when 4,   -- 4
      "0100100" when 5,   -- 5
      "0100000" when 6,   -- 6
      "0001111" when 7,   -- 7
      "0000000" when 8,   -- 8
      "0000100" when 9,   -- 9
      "0001000" when others; -- Apagado
    A <=
      "1110" when 0,
      "1101" when 1,
      "1011" when 2,
      "0111" when 3,
      "1111" when others;

end arq;
