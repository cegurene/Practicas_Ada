with PID;

package body PID is

   procedure Programar (
      el_Controlador : in out Controlador;
      Kp, Ki, Kd     : Real
   ) is
   begin
      el_Controlador.Kp := Kp;
      el_Controlador.Ki := Ki;
      el_Controlador.Kd := Kd;

      -- Reset del estado interno
      el_Controlador.S_Anterior     := 0.0;
      el_Controlador.Error_Anterior := 0.0;
   end Programar;


   procedure Controlar (
      con_el_Controlador : in out Controlador;
      R, C               : Entrada;
      U                  : out Salida
   ) is
      Error       : Real;
      Derivada    : Real;
      Integracion : Real;
      Salida_Real : Real;
   begin
      -- Cálculo del error
      Error := Real(R) - Real(C);

      -- Derivada (error actual - error anterior)
      Derivada := Error - con_el_Controlador.Error_Anterior;

      -- Integración (acumulador)
      con_el_Controlador.S_Anterior :=
         con_el_Controlador.S_Anterior + Error;

      Integracion := con_el_Controlador.S_Anterior;

      -- Salida PID
      Salida_Real :=
        con_el_Controlador.Kp * Error +
        con_el_Controlador.Ki * Integracion +
        con_el_Controlador.Kd * Derivada;

      -- Conversión a tipo de salida
      U := Salida(Salida_Real);

      -- Actualizar el error anterior
      con_el_Controlador.Error_Anterior := Error;
   end Controlar;

end PID;

