with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;

procedure registros is

   -- Definición del tipo enumerado para el mes
   type mes_t is (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre);

   -- Definición del tipo Fecha
   type fecha_t is record
      dia   : Integer range 1..31;
      mes   : mes_t;
      anno  : Integer range 2000..2024;
   end record;

   -- Definición del tipo Registro para las películas
   type Pelicula is record
      titulo    : Unbounded_String;
      fecha     : fecha_t;
      nota      : Float range 0.0..10.0;
   end record;

   -- Declaración del array de registros
   Max_Registros : constant Integer := 100;
   registros     : array (1..Max_Registros) of Pelicula;
   num_registros : Integer;

   -- Variables para las notas mínima, máxima y media
   nota_minima   : Float := 10.0;
   nota_maxima   : Float := 0.0;
   suma_notas    : Float := 0.0;
   media         : Float := 0.0;

   -- Variables para la fecha mínima y máxima
   fecha_minima  : fecha_t;
   fecha_maxima  : fecha_t;

   -- Paquetes para entrada/salida de enumerados y números reales
   package Mes_Es is new Ada.Text_IO.Enumeration_IO(mes_t);
   package Nota_Es is new Ada.Text_IO.Float_IO(Float);

begin

   -- Solicitar al usuario el número de registros
   Put("Introduce el número de registros: ");
   Get(num_registros);
   New_Line;

   -- Leer los registros de las películas
   for i in 1..num_registros loop
      
      -- Leer título
      Put("Introduce el título de la película: ");
      Get_Line(registros(i).titulo);

      -- Leer fecha
      Put("Introduce el día: ");
      Get(registros(i).fecha.dia);
      Put("Introduce el mes (número del 1 al 12): ");
      declare
         mes_temp : Integer;
      begin
         Get(mes_temp);
         registros(i).fecha.mes := mes_t'Val(mes_temp - 1);  -- Ajustar el valor para que coincida con el tipo enumerado
      end;
      Put("Introduce el año: ");
      Get(registros(i).fecha.anno);

      -- Leer nota
      Put("Introduce la nota de la película: ");
      Nota_Es.Get(registros(i).nota);
      New_Line;
      
      -- Actualizar la nota mínima y máxima
      if registros(i).nota < nota_minima then
         nota_minima := registros(i).nota;
         fecha_minima := registros(i).fecha;
      end if;
      if registros(i).nota > nota_maxima then
         nota_maxima := registros(i).nota;
         fecha_maxima := registros(i).fecha;
      end if;

      -- Sumar las notas
      suma_notas := suma_notas + registros(i).nota;
   end loop;
   
   -- Calculamos la media
   media := suma_notas / Float(num_registros);

   -- Mostrar los registros
   for i in 1..num_registros loop
      Put_Line("Registro nro. " & Integer'Image(i));
      Put_Line("Título: " & To_String(registros(i).titulo));
      Put_Line("Fecha. Día: " & Integer'Image(registros(i).fecha.dia));
      Put("Mes: ");
      Mes_Es.Put(registros(i).fecha.mes);
      New_Line;
      Put_Line("Año: " & Integer'Image(registros(i).fecha.anno));
      Put_Line("Nota: " & Float'Image(registros(i).nota));
      New_Line;
   end loop;

   -- Mostrar la nota mínima, máxima, la media y las fechas
   Put("Nota mínima: ");
   Nota_Es.Put(nota_minima);
   Put(" Película: " & To_String(registros(1).titulo) & " alquilada el ");
   Put(Integer'Image(fecha_minima.dia) & " de ");
   Mes_Es.Put(fecha_minima.mes);
   Put_Line(" de" & Integer'Image(fecha_minima.anno));

   Put("Nota máxima: ");
   Nota_Es.Put(nota_maxima);
   Put(" Película: " & To_String(registros(1).titulo) & " alquilada el ");
   Put(Integer'Image(fecha_maxima.dia) & " de ");
   Mes_Es.Put(fecha_maxima.mes);
   Put_Line(" de" & Integer'Image(fecha_maxima.anno));


   -- Mostrar la media de las notas
   Put("La nota media del periodo ");
   Put(Integer'Image(registros(1).fecha.dia) & " de ");
   Mes_Es.Put(registros(1).fecha.mes);
   Put(" de" & Integer'Image(registros(1).fecha.anno) & " a ");
   Put(Integer'Image(registros(num_registros).fecha.dia) & " de ");
   Mes_Es.Put(registros(num_registros).fecha.mes);
   Put(" de" & Integer'Image(registros(num_registros).fecha.anno) & " ha sido de ");
   Nota_Es.Put(media);
   New_Line;

end registros;

