with Horno;
package body Sensor is
   
   procedure Leer (la_Temperatura: out Temperaturas) is
      Temp: Horno.Temperaturas;
   begin
      Horno.Leer(Temp);
      la_Temperatura := Temperaturas(Temp);
   end Leer;
   
end Sensor;
