with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Proc;
with Plan;

procedure Medir is
   use Ada.Text_IO;
   package Int_IO is new Ada.Integer_Text_IO(Integer);
   use Int_IO;

   -- Tipos auxiliares
   type ref_array is array (1 .. 4) of Plan.ref_Procedimiento_t;
   type tiempo_array is array (1 .. 4) of Natural;

   -- Procedimientos y tiempos medidos
   Procedimientos : ref_array := (Proc.P1'Access, Proc.P2'Access, Proc.P3'Access, Proc.P4'Access);
   Tiempos        : tiempo_array;

   -- Datos de planificación
   Tareas : Plan.array_reg_Planificacion_t := (
      (1, 2000, 2000, 0, 0, 0, False),
      (2, 3000, 3000, 0, 0, 0, False),
      (3, 4000, 4000, 0, 0, 0, False),
      (4, 5000, 5000, 0, 0, 0, False)
   );

begin
   -- Medir tiempos de cómputo
   Plan.Medir(Procedimientos, Tiempos);

   -- Asignar tiempos medidos a cada tarea
   for I in Tiempos'Range loop
      Tareas(I).C := Tiempos(I);
   end loop;

   -- Planificar tareas
   Plan.Planificar(Tareas);

   -- Mostrar resultados
   Put_Line("+---------------------------------------------------+");
   Put_Line("| Tarea     T     D     C     P     R  Planificable |");
   Put_Line("|---------------------------------------------------|");
   for I in Tareas'Range loop
      Put ("| ");
      Put (Tareas(I).Nombre, Width => 5); Put ("  ");
      Put (Tareas(I).T, Width => 5); Put ("  ");
      Put (Tareas(I).D, Width => 5); Put ("  ");
      Put (Tareas(I).C, Width => 5); Put ("  ");
      Put (Tareas(I).P, Width => 5); Put ("  ");
      Put (Tareas(I).R, Width => 5); Put ("  ");
      if Tareas(I).Planificable then
         Put_Line ("          SI |");
      else
         Put_Line ("          NO |");
      end if;
   end loop;
   Put_Line("+---------------------------------------------------+");
end Medir;

