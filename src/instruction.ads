with CPU_Specifications;

package Instruction is
   use CPU_Specifications;

   Package_Name : constant String := "Instruction";
   
   
   procedure Add (Word : Words);
   procedure Bit_Or_Logic_And (Word : in words);
   procedure Conditional_Branch (Word : in words) is null;
   procedure Load (Word : in words) is null;
   procedure Store(Word : in words) is null;
   procedure JSR_Or_JSRR(Word : in words) is null;
   procedure Load_Relative(Word : in words) is null; 
   procedure Store_Relative(Word : in words) is null; 
   procedure Return_From_Interrupt(Word : in words) is null; 
   procedure Bitwise_Not(Word : in words) is null; 
   procedure Load_Indirect(Word : in words) is null; 
   procedure Store_Indirect(Word : in words) is null; 
   procedure JMP_Or_RET(Word : in words) is null; 
   procedure Unused(Word : in words) is null; 
   procedure Load_Effective_Address(Word : in words) is null; 
   procedure Return_From_Sub(Word : in words) is null; 
   procedure Trap(Word : in words) is null; 

   
   type Instance is abstract tagged
      record
         Word : Words;
      end record;
   procedure Load (Obj : in out Instance) is abstract;
   procedure Evaluate (Obj : in out Instance) is abstract;
   procedure Store (Obj : in Instance) is abstract;


   type Dummy is new Instance with null record;
   procedure Load (Obj : in out Dummy) is null;
   procedure Evaluate (Obj : in out Dummy) is null;
   procedure Store (Obj : in Dummy) is null;

   Null_Operation : constant Dummy := (Word => 0);
   Current : Instance'Class := Null_Operation;


private

end Instruction;

