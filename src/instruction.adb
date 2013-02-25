with CPU;

with Bit_Utilities;
with Simulation_Trace;

package body Instruction is
   use Simulation_Trace;

   procedure Load (Obj : in out Bit_Or_Logic_And) is
      Context : constant String := Package_Name & ".Load (And)";
   begin
      Debug (Context => Context,
             Message => "Called");
   end Load;

   procedure Evaluate (Obj : in out Bit_Or_Logic_And) is
      Context : constant String := Package_Name & ".Evaluate (And)";
   begin
      Debug (Context => Context,
             Message => "Called");
   end Evaluate;

   procedure Store (Obj : in Bit_Or_Logic_And) is
   begin
      null;
   end Store;


   procedure Load (Obj : in out Add) is
      use CPU_Specifications;
      use CPU;
      Context        : constant String := Package_Name & ".Load (Add)";

      Immidiate_Flag : constant Words := 2#0000000000100000#;
      Use_Immidiate  : constant Boolean  := (Obj.Word and Immidiate_Flag) > 0;
   begin
      Obj.Destination_Register := Registers (Bit_Utilities.Extract (Obj.Word, 9, 11));
      Debug (Context => Context,
             Message => "DR" & Registers'Image (Obj.Destination_Register));


      if Use_Immidiate then
         Debug (Context => Context,
                Message => "Using immidiate");
      else
         Debug (Context => Context,
                Message => "Not using immidiate");
         Obj.Left  := Value (Register (Registers (Bit_Utilities.Extract (Obj.Word, 0, 2))));
         Obj.Right := Value (Register (Registers (Bit_Utilities.Extract (Obj.Word, 3, 5))));
      end if;
   end Load;

   procedure Evaluate (Obj : in out Add) is
      use CPU;
   begin
      Obj.Intermediate_Result := Obj.Left + Obj.Right;
   end Evaluate;


   procedure Store (Obj : in Add) is
      use CPU;
   begin
      --  Update the CPU register.
      CPU.Register (Obj.Destination_Register) := Value (Obj.Intermediate_Result);
   end Store;


   function Value (Word : in Words) return Mnemonics is
   begin
      return Instruction_Table (Instructions (Word/(2**(Word_Size-Instruction_Size))));
   end Value;
   --  Extracts the Mnemonic of a word.

   function Value (Bits : Words) return Instance'Class is
      Operation : Mnemonics := Value (Bits);
   begin
      case Operation is
         when CPU_Specifications.Add =>
            return Obj : Add do
               Obj.Word := Bits;
            end return;
         when CPU_Specifications.Bit_Or_Logic_And =>
            return Obj : Bit_Or_Logic_And do
               Obj.Word := Bits;
            end return;
         when others =>
            return Obj : Bit_Or_Logic_And do
               Obj.Word := Bits;
            end return;
      end case;
   end Value;

end Instruction;
