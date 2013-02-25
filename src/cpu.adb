with Ada.Text_IO; use Ada.Text_IO;
with Instruction;

with Memory;

package body CPU is

   function Value (Word : in Words) return Mnemonics is
   begin
      return Instruction_Table (Instructions (Word/(2**(Word_Size-Instruction_Size))));
   end Value;
   --  Extracts the Mnemonic of a word.

   procedure Tick is
   begin
      case Instruction_Cycle  is
         when Fetch =>
            Current_Operation   := Memory.Storage(Instruction_Pointer);
            Instruction_Pointer := Memory_Index'Succ (Instruction_Pointer);

         when Decode =>
            Instruction.Current := Instruction.Value (Current_Operation);
         when Load =>
            Instruction.Current.Load;
         when Evaluate =>
            Instruction.Current.Evaluate;
         when Store =>
            Instruction.Current.Store;
      end case;

      --  Move to the next cycle;
      if Instruction_Cycle = Instruction_Cycles'Last then
         Instruction_Cycle := Instruction_Cycles'First;
      else
         Instruction_Cycle := Instruction_Cycles'Succ (Instruction_Cycle);
      end if;

   end Tick;
end CPU;
