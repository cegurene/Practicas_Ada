with Ada.Text_IO; use Ada.Text_IO;
with Colas;
with Fracciones;

procedure Principal_Mix is
   -- Instanciación del paquete Colas con fraccion_t y la función Imprimir
   package Cola_De_Fracciones is new Colas(Fracciones.fraccion_t, Fracciones.Imprimir);
   use Cola_De_Fracciones;  -- Permite usar los procedimientos sin prefijo

   -- Declaración de la cola
   La_Cola : cola_t;
   F : Fracciones.fraccion_t;
begin
   -- Bucle anidado para insertar fracciones en la cola
   for num in 1 .. 4 loop
      for den in 1 .. 4 loop
      	 F := Fracciones."/"(num, den);
         Poner(F, La_Cola);  -- Ahora podemos usar Poner directamente
      end loop;
   end loop;

   -- Mostrar la cola de fracciones
   Put_Line("Cola de fracciones:");
   MostrarCola(La_Cola);
end Principal_Mix;

