with Ada.Real_Time;
use  Ada.Real_Time;

package body Plan is

   -- Medir el tiempo de ejecución de cada procedimiento
   procedure Medir (Procedimientos: array_ref_Procedimiento_t; Tiempos: out array_Tiempos_t) is
      T1, T2 : Time;
   begin
      for I in Procedimientos'Range loop
         T1 := Clock;
         Procedimientos(I).all;
         T2 := Clock;
         Tiempos(I) := Natural(To_Duration(T2 - T1) * 1000.0); -- convertir a milisegundos
      end loop;
   end Medir;

   -- Intercambia dos registros de planificación
   procedure Swap(I, J: in out reg_Planificacion_t) is
      Temp: reg_Planificacion_t;
   begin
      Temp := I;
      I := J;
      J := Temp;
   end Swap;

   -- Planificación de tareas con DMS
   procedure Planificar (Tareas: in out array_reg_Planificacion_t) is
      N : constant Integer := Tareas'Length;
   begin
      -- Ordenar tareas por D (menor plazo = mayor prioridad)
      for I in Tareas'First .. Tareas'Last - 1 loop
         for J in I + 1 .. Tareas'Last loop
            if Tareas(J).D < Tareas(I).D then
               Swap(Tareas(I), Tareas(J));
            end if;
         end loop;
      end loop;

      -- Asignar prioridades (1 = más alta)
      for I in Tareas'Range loop
         Tareas(I).P := I;
      end loop;

      -- Calcular tiempo de respuesta y si es planificable
      for I in Tareas'Range loop
         declare
            R_ant, R_act : Natural;
         begin
            R_act := Tareas(I).C;
            loop
               R_ant := R_act;
               R_act := Tareas(I).C;
               for J in Tareas'First .. I - 1 loop
                  R_act := R_act + ((R_ant + Tareas(J).T - 1) / Tareas(J).T) * Tareas(J).C;
               end loop;
               exit when R_act = R_ant or else R_act > Tareas(I).D;
            end loop;
            Tareas(I).R := R_act;
            Tareas(I).Planificable := R_act <= Tareas(I).D;
         end;
      end loop;
   end Planificar;

end Plan;

