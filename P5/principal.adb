with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Real_Time;
use Ada.Real_Time;

with Sensor;
with Calefactor;
with Control_Horno;

procedure Principal is

   T_Ref        : Float;
   T_Actual     : Sensor.Temperaturas;
   Potencia     : Calefactor.Potencias;
   Horno_Ctrl   : Control_Horno.Controlador;

   -- Parámetros del PID según Ziegler-Nichols (ejemplo)
   Kp : constant Float := 1.2;
   Ki : constant Float := 0.1;
   Kd : constant Float := 0.01;

   -- Tiempo de muestreo
   Ts         : constant Time_Span := Milliseconds(500);  -- 500 ms por muestra
   Instante   : Time := Clock;
   Fin_Tiempo : constant Time := Clock + Minutes(1);      -- Duración del ciclo

begin
   -- Configuración inicial
   Put_Line("Introduce la temperatura de referencia:");
   Get(T_Ref);

   Control_Horno.Programar(Horno_Ctrl, Kp, Ki, Kd);

   loop
      -- Comprobación de tiempo límite
      exit when Clock >= Fin_Tiempo;

      -- Esperar al instante de muestreo
      delay until Instante;
      Instante := Instante + Ts;

      -- Lectura del sensor
      Sensor.Leer(T_Actual);

      -- Calcular potencia de control
      Control_Horno.Controlar(
         Con_El_Controlador => Horno_Ctrl,
         T_Referencia       => T_Ref,
         T_Actual           => T_Actual,
         Potencia_Salida    => Potencia);

      -- Escribir potencia en el calefactor
      Calefactor.Escribir(Potencia);

      -- Mostrar estado
      Put_Line("T = " & Float'Image(Float(T_Actual)) &
               "  -> P = " & Float'Image(Float(Potencia)));
   end loop;

   Put_Line("Control finalizado.");
end Principal;

