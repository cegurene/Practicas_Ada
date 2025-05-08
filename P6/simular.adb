with Ada.Text_IO;
with Ada.Real_Time;
with Proc;

procedure Simular is
   use Ada.Text_IO;
   use Ada.Real_Time;

   Periodo_Simulacion : constant Time_Span := Seconds(50);
   Inicio_Simulacion  : constant Time := Clock;

   -- Tabla de tareas
   type Tarea_Info is record
      Id       : Positive;
      T        : Natural; -- período en ms
      C        : Natural; -- cómputo en ms
      P        : Integer; -- prioridad
      Trabajo  : access procedure;
   end record;

   -- Información de tareas (puedes ajustar según `medir`)
   Tareas : constant array (1 .. 4) of Tarea_Info := (
     (1, 2000, 400, 4, Proc.P1'Access),
     (2, 3000, 600, 3, Proc.P2'Access),
     (3, 4000, 800, 2, Proc.P3'Access),
     (4, 5000, 800, 1, Proc.P4'Access)
   );

   -- Tarea tipo
   task type Tarea_Periodica (Info : Tarea_Info);
   task body Tarea_Periodica is
      Siguiente_Instante : Time := Inicio_Simulacion;
      Fin_Tiempo         : constant Time := Inicio_Simulacion + Periodo_Simulacion;
      Ahora, Comienzo, Fin : Time;
   begin
      loop
         Siguiente_Instante := Siguiente_Instante + Milliseconds(Info.T);
         delay until Siguiente_Instante;

         Ahora := Clock;
         exit when Ahora >= Fin_Tiempo;

         Comienzo := Clock;
         Info.Trabajo.all;
         Fin := Clock;

         if Fin > Comienzo + Milliseconds(Info.T) then
            Put_Line("Tarea " & Info.Id'Image & " NO cumple su plazo.");
         else
            Put_Line("Tarea " & Info.Id'Image & " cumple su plazo.");
         end if;
      end loop;
   end Tarea_Periodica;

   -- Crear tareas
   T1 : Tarea_Periodica(Tareas(1)) do
      pragma Priority(Tareas(1).P);
   end T1;
   T2 : Tarea_Periodica(Tareas(2)) do
      pragma Priority(Tareas(2).P);
   end T2;
   T3 : Tarea_Periodica(Tareas(3)) do
      pragma Priority(Tareas(3).P);
   end T3;
   T4 : Tarea_Periodica(Tareas(4)) do
      pragma Priority(Tareas(4).P);
   end T4;

begin
   null;  -- cuerpo principal vacío; las tareas corren solas
end Simular;

