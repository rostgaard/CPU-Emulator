with CPU_Specifications;

package Instruction is
   use CPU_Specifications;

   Package_Name : constant String := "Instruction";

   type Instance is abstract tagged
      record
         Word : Words;
      end record;
   procedure Load (Obj : in out Instance) is abstract;
   procedure Evaluate (Obj : in out Instance) is abstract;
   procedure Store (Obj : in Instance) is abstract;

   type Add is new Instance with private;
   procedure Load (Obj : in out Add);
   procedure Evaluate (Obj : in out Add);
   procedure Store (Obj : in Add);

   type Bit_Or_Logic_And is new Instance with private;
   procedure Load (Obj : in out Bit_Or_Logic_And);
   procedure Evaluate (Obj : in out Bit_Or_Logic_And);
   procedure Store (Obj : in Bit_Or_Logic_And);

   function Value (Bits : Words) return Instance'Class;

   --  procedure Add_1 (Bits : in CPU.Words);

   type Dummy is new Instance with null record;
   procedure Load (Obj : in out Dummy) is null;
   procedure Evaluate (Obj : in out Dummy) is null;
   procedure Store (Obj : in Dummy) is null;

   Null_Operation : constant Dummy := (Word => 0);
   Current : Instance'Class := Null_Operation;


private
   type Add is new Instance with
      record
         Left                 : LC3_Integer := 0;
         Right                : LC3_Integer := 0;
         Destination_Register : Registers   := 0;
         Intermediate_Result  : LC3_Integer := 0;
      end record;

   type Bit_Or_Logic_And is new Instance with
      record
         Left                 : LC3_Integer := 0;
         Right                : LC3_Integer := 0;
         Destination_Register : Registers   := 0;
         Intermediate_Result  : LC3_Integer := 0;
      end record;
end Instruction;

