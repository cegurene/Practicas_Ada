with PID;
with Sensor;
with Calefactor;

package body Control_Horno is

   procedure Programar (
      El_Controlador : in out Controlador;
      Kp, Ki, Kd     : Float) is
   begin
      PID_Float.Programar(El_Controlador.PID_Interno, Kp, Ki, Kd);
   end Programar;

   procedure Controlar (
      Con_El_Controlador : in out Controlador;
      T_Referencia       : Float;
      T_Actual           : Sensor.Temperaturas;
      Potencia_Salida    : out Calefactor.Potencias) is
      Error : Float;
   begin
      Error := T_Referencia - Float(T_Actual);
      PID_Float.Controlar(Con_El_Controlador.PID_Interno, Error, 0.0, Potencia_Salida);
   end Controlar;

end Control_Horno;

