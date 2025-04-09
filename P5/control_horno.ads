with PID;
with Sensor;
with Calefactor;

package Control_Horno is

   type Controlador is limited private;

   procedure Programar (
      El_Controlador : in out Controlador;
      Kp, Ki, Kd     : Float);

   procedure Controlar (
      Con_El_Controlador : in out Controlador;
      T_Referencia       : Float;
      T_Actual           : Sensor.Temperaturas;
      Potencia_Salida    : out Calefactor.Potencias);

private
   package PID_Float is new PID (
      Real    => Float,
      Entrada => Float,
      Salida  => Calefactor.Potencias);

   type Controlador is record
      PID_Interno : PID_Float.Controlador;
   end record;

end Control_Horno;

