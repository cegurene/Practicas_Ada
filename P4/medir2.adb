with Ada.Text_Io, Ada.Real_Time, Sensor, Calefactor;
use Ada.Text_Io, Ada.Real_Time, Sensor, Calefactor;

procedure Medir2 is
    
   Te, T, T_Anterior : Temperaturas;
   Ct, Cp : Float;
   P : Potencias := 1000.0;  -- P: potencia de prueba (dada en el enunciado)
   Start_Time : Time;
   Delta_Temperature : Float;
   Delta_Time : Duration;

begin

   -- Leer Te desde el sensor
   Leer(Te);
   Put_Line("Temperatura ambiente (Te): " & Float'Image(Float(Te)));

   -- Aplicar potencia al horno
   Escribir(P);
   Start_Time := Clock;

   -- Medir la evolución de la temperatura
   Leer(T_Anterior);
   loop
      delay 1.0; -- Esperar un segundo entre mediciones
      Leer(T);
      Delta_Temperature := Float(T) - Float(T_Anterior);
      Delta_Time := To_Duration(Clock - Start_Time);
      if Delta_Temperature /= 0.0 then
         Ct := (Float(P) - Cp * (Float(T) - Float(Te))) * Float(Delta_Time) / Delta_Temperature;
         Put_Line("Ct: " & Float'Image(Ct));
         exit;
      end if;
      T_Anterior := T;
   end loop;

   -- Apagar el horno
   Escribir(0.0);
    
end Medir2;
