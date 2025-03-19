with Ada.Text_Io, Ada.Real_Time, Sensor, Calefactor;
use Ada.Text_Io, Ada.Real_Time, Sensor, Calefactor;

procedure Medir1 is

   Te, T : Temperaturas;  -- Te: temperatura ambiente
   L : Time_Span;  -- L: retardo
   Cp : Float;  -- Cp: coeficiente de perdidas
   P : Potencias := 1000.0;  -- P: potencia de prueba (dada en el enunciado)
   Start_Time, End_Time : Time;  -- Tiempos para medir L

begin
   -- Medir Te
   Leer(Te);
   Put_Line("Temperatura ambiente (Te): " & Float'Image(Float(Te)));

   -- Aplicar potencia y medir L
   Escribir(P);
   Start_Time := Clock;
   loop
      Leer(T);
      if T > Te then
         End_Time := Clock;
         exit;
      end if;
   end loop;
   L := End_Time - Start_Time;
   Put_Line("Retardo (L): " & Duration'Image(To_Duration(L)) & " segundos");

   -- Esperar régimen permanente
   delay 10.0;
   Leer(T);
   Cp := Float(P) / (Float(T) - Float(Te));  -- Formula dada en el enunciado
   Put_Line("Coeficiente de pérdidas (Cp): " & Float'Image(Cp));

   -- Apagar el horno
   Escribir(0.0);
end Medir1;

