with Ada.Text_IO; -- we're using the Ada.Text_IO package to write to the console

procedure overloading_operators is

   -- Define a new type
   type My_Integer is new Integer; 

   -- Create an instance of the My_Integer_IO package to write to the console.
   -- Without this package, we wouldn't be able to use 'Image to convert the
   -- our new type to a string.
   package My_Integer_IO is new Ada.Text_IO.Integer_IO(My_Integer);

   -- Overload the + operator for our new type
   function "+" (Left, Right : My_Integer) return My_Integer is
   begin
      return My_Integer(Integer(Left) + Integer(Right));
   end "+";

   -- Declare some variables
   A, B, C : My_Integer;
begin
   A := 5;
   B := 10;
   C := A + B;  -- Uses our overloaded + operator

   -- Output the result
   Ada.Text_IO.Put_Line("Result: " & C'Image);   
end overloading_operators;
