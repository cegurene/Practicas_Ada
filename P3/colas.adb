with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Colas is

   -- Procedimiento para liberar memoria de un nodo
   procedure Liberar is new Ada.Unchecked_Deallocation(Nodo, ref_Nodo);

   -- Comprobar si la cola está vacía
   function Esta_Vacia(La_Cola: cola_t) return Boolean is
   begin
      return La_Cola.ptr_primero = null;
   end Esta_Vacia;

   -- Comprobar si la cola está llena (nunca se llena en una implementación dinámica)
   function Esta_Llena(La_Cola: cola_t) return Boolean is
   begin
      return False;
   end Esta_Llena;

   -- Insertar un elemento en la cola
   procedure Poner(el_Elemento: elemento_t; en_la_Cola: in out cola_t) is
      nuevo_nodo : ref_Nodo := new Nodo'(Datos => el_Elemento, ptr_Siguiente => null);
   begin
      if Esta_Vacia(en_la_Cola) then
         en_la_Cola.ptr_primero := nuevo_nodo;
      else
         en_la_Cola.ptr_ultimo.ptr_Siguiente := nuevo_nodo;
      end if;
      en_la_Cola.ptr_ultimo := nuevo_nodo;
   end Poner;

   -- Extraer un elemento de la cola
   procedure Quitar(un_Elemento: out elemento_t; de_la_Cola: in out cola_t) is
      nodo_a_eliminar : ref_Nodo := de_la_Cola.ptr_primero;
   begin
      if Esta_Vacia(de_la_Cola) then
         raise Constraint_Error with "Intento de quitar en una cola vacía";
      end if;
      un_Elemento := nodo_a_eliminar.Datos;
      de_la_Cola.ptr_primero := nodo_a_eliminar.ptr_Siguiente;
      if de_la_Cola.ptr_primero = null then
         de_la_Cola.ptr_ultimo := null;
      end if;
      Liberar(nodo_a_eliminar);
   end Quitar;

   -- Mostrar los elementos de la cola
   procedure MostrarCola(La_Cola: cola_t) is
      nodo_actual : ref_Nodo := La_Cola.ptr_primero;
   begin
      while nodo_actual /= null loop
         Put_Line(ToString(nodo_actual.Datos));
         nodo_actual := nodo_actual.ptr_Siguiente;
      end loop;
   end MostrarCola;

   -- Copiar una cola en otra
   procedure Copiar(Origen: cola_t; Destino: in out cola_t) is
      nodo_actual : ref_Nodo := Origen.ptr_primero;
   begin
      while nodo_actual /= null loop
         Poner(nodo_actual.Datos, Destino);
         nodo_actual := nodo_actual.ptr_Siguiente;
      end loop;
   end Copiar;

   -- Comparar dos colas
   function "="(La_Cola, Con_La_Cola: cola_t) return Boolean is
      nodo1 : ref_Nodo := La_Cola.ptr_primero;
      nodo2 : ref_Nodo := Con_La_Cola.ptr_primero;
   begin
      while nodo1 /= null and nodo2 /= null loop
         if nodo1.Datos /= nodo2.Datos then
            return False;
         end if;
         nodo1 := nodo1.ptr_Siguiente;
         nodo2 := nodo2.ptr_Siguiente;
      end loop;
      return nodo1 = null and nodo2 = null;
   end "=";

end Colas;

