package Plan is

   type ref_Procedimiento_t is access procedure;

   type array_ref_Procedimiento_t is array (Positive range <>) of ref_Procedimiento_t;
   type array_Tiempos_t is array (Positive range <>) of Natural;
   
   procedure Medir (Procedimientos: array_ref_Procedimiento_t; Tiempos: out array_Tiempos_t);

   type reg_Planificacion_t is record
            Nombre: Positive; -- Numero de la tarea
                 T: Natural;  -- Periodo
                 D: Natural;  -- Plazo
                 C: Natural;  -- Tiempo de computo
                 P: Positive; -- Prioridad
                 R: Natural;  -- Tiempo de respuesta
      Planificable: Boolean;
   end record;

   type array_reg_Planificacion_t is array (Positive range <>) of reg_Planificacion_t;
   
   procedure Planificar (Tareas: in out array_reg_Planificacion_t);
   
end Plan;
