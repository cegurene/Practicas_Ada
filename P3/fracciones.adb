with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Fracciones;

package body Fracciones is

   -- Sumar dos fracciones
   function "+"(X, Y : fraccion_t) return fraccion_t is
      resultado : fraccion_t;
   begin
      resultado.num := X.num * Y.den + Y.num * X.den;
      resultado.den := X.den * Y.den;
      return resultado;
   end "+";
   
   -- Negación de una fracción
   function "-"(X : fraccion_t) return fraccion_t is
      resultado : fraccion_t;
   begin
      resultado.num := -X.num;
      resultado.den := X.den;
      return resultado;
   end "-";

   -- Restar dos fracciones
   function "-"(X, Y : fraccion_t) return fraccion_t is
      resultado : fraccion_t;
   begin
      resultado.num := X.num * Y.den - Y.num * X.den;
      resultado.den := X.den * Y.den;
      return resultado;
   end "-";

   -- Multiplicar dos fracciones
   function "*"(X, Y : fraccion_t) return fraccion_t is
      resultado : fraccion_t;
   begin
      resultado.num := X.num * Y.num;
      resultado.den := X.den * Y.den;
      return resultado;
   end "*";

   -- Dividir dos fracciones
   function "/"(X, Y : fraccion_t) return fraccion_t is
      resultado : fraccion_t;
   begin
      resultado.num := X.num * Y.den;
      resultado.den := X.den * Y.num;
      return resultado;
   end "/";

   -- Comparación de igualdad entre dos fracciones
   function "="(X, Y : fraccion_t) return Boolean is
   begin
      return X.num * Y.den = Y.num * X.den;
   end "=";

   -- Leer una fracción desde el teclado
   procedure Leer(F : out fraccion_t) is
   begin
      Put("Introduce el numerador: ");
      Get(F.num);
      Put("Introduce el denominador: ");
      Get(F.den);
      if F.den = 0 then
         Put_Line("Error: El denominador no puede ser cero. Se establecerá a 1.");
         F.den := 1;
      end if;
   end Leer;

   -- Escribir una fracción en pantalla
   procedure Escribir(F : fraccion_t) is
   begin
      Put(Integer'Image(F.num) & "/" & Integer'Image(F.den));
   end Escribir;

   -- División de un entero por otro para obtener una fracción
   function "/"(X, Y : Integer) return fraccion_t is
      resultado : fraccion_t;
   begin
      if Y = 0 then
         Put_Line("Error: División por cero. Se establecerá el denominador a 1.");
         resultado.num := X;
         resultado.den := 1;
      else
         resultado.num := X;
         resultado.den := Y;
      end if;
      return resultado;
   end "/";

   -- Obtener el numerador de una fracción
   function Numerador(F : fraccion_t) return Integer is
   begin
      return F.num;
   end Numerador;

   -- Obtener el denominador de una fracción
   function Denominador(F : fraccion_t) return Positive is
   begin
      return F.den;
   end Denominador;

   -- Practica 3
   -- Parte 2
   function Imprimir (F: fraccion_t) return string is
   begin
      return Integer'Image(F.num) & "/" & Integer'Image(F.den);
   end Imprimir;

end Fracciones;

