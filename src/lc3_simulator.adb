with Ada.Text_IO; use Ada.Text_IO;
with CPU; use CPU;
with CPU_Specifications; use CPU_Specifications;

package body LC3_Simulator is

   procedure Simulate is

      type Padding_Type is mod 2**(Word_Size-4);



   begin
      loop
         CPU.Tick;
         delay 0.2;
      end loop;

      --   Read_Word;
      --   Decode;
   end Simulate;
end LC3_Simulator;
