with Ada.Text_IO; use Ada.Text_IO;
with Instruction;

with Memory;

package body CPU is
   
   function Value (Word : in Words) return Mnemonics is
   begin
      return Instruction_Table (Instructions (Word/(2**(Word_Size-Instruction_Size))));
   end Value;
   --  Extracts the Mnemonic of a word.
   
   procedure Decode (Word : in Words) is
   begin
      Instruction_Register := (Mnemonic => Value (Word),
                               Word     => Word);
   end Decode;
   
   procedure Load (Word : in Words) is
   begin
      case Instruction_Register.Mnemonic is
         when Add =>
            null;
         when Bit_Or_Logic_And =>   
            null;
         when others =>
            null;
      end case;
   end Load;
   
   procedure Evaluate (Word : in Words) is
   begin
      case Instruction_Register.Mnemonic is
         when Add =>
            Instruction.Add (Word);
         when Bit_Or_Logic_And =>
            Instruction.Bit_Or_Logic_And (Word);
         when Conditional_Branch =>
            Instruction.Conditional_Branch (Word);
         when Load =>
            Instruction.Load (Word);
         when others =>
            null;
      end case;
   end Evaluate;
     
   procedure Store (Word : in Words) is
   begin
      case Instruction_Register.Mnemonic is
         when Add =>
            null;
         when others =>
            null;
      end case;
   end Store;
   
   procedure Tick is
   begin
      case Instruction_Cycle  is
         when Fetch =>
            Current_Operation   := Memory.Storage(Instruction_Pointer);
            Instruction_Pointer := Memory_Index'Succ (Instruction_Pointer);
         when Decode =>
            Decode (Current_Operation);
         when Load =>
            Load (Current_Operation);
         when Evaluate =>
            Evaluate (Current_Operation);
         when Store =>
            Store (Current_Operation);
      end case;

      --  Move to the next cycle;
      if Instruction_Cycle = Instruction_Cycles'Last then
         Instruction_Cycle := Instruction_Cycles'First;
      else
         Instruction_Cycle := Instruction_Cycles'Succ (Instruction_Cycle);
      end if;

   end Tick;
end CPU;
