with CPU;

with Bit_Utilities;
with Simulation_Trace;

package body Instruction is
   use Simulation_Trace;
   
--   procedure Conditional_Branch 
   
   procedure Bit_Or_Logic_And (Word : in words) is
      Context : constant String := Package_Name & ".And";
   begin
      Debug (Context => Context,
             Message => "Called");
   end Bit_Or_Logic_And;
   
   procedure Add (Word : Words) is
      use CPU_Specifications;
      use CPU;
      Context        : constant String := Package_Name & ".Add";

      Immidiate_Flag : constant Words := 2#0000000000100000#;
      Use_Immidiate  : constant Boolean  := (Word and Immidiate_Flag) > 0;
      Destination_Register : constant Registers := Registers (Bit_Utilities.Extract (Word, 9, 11));

   begin
      Debug (Context => Context,
             Message => "DR" & Registers'Image (Destination_Register));


      if Use_Immidiate then
         Debug (Context => Context,
                Message => "Using immidiate");
      else
         Debug (Context => Context,
                Message => "Not using immidiate");
         CPU.Register (Destination_Register) := 
           Register (Registers (Bit_Utilities.Extract (Word, 0, 2))) 
           + Register (Registers (Bit_Utilities.Extract (Word, 3, 5)));
      end if;
   end Add;


end Instruction;
