with CPU_Specifications;

package CPU is
   use CPU_Specifications;

   Register : array (Registers) of LC3_Integer := ( others => 0);

   Flag : array (CPU_Flags) of Boolean;

   procedure Tick;
   
   type Instruction_Registers is
      record
         Mnemonic : Mnemonics;
         Word     : Words;
      end record;
   
   
private
   Instruction_Register : Instruction_Registers;
   
   Current_Operation   : Words        := 0;
   Instruction_Pointer : Memory_Index := Memory_Index'First;

   Instruction_Cycle : Instruction_Cycles := Instruction_Cycles'First;
   
   type Active_Instructions is
      record
         Stage    : Instruction_Cycles;
         Mnemonic : Mnemonics;
         Word     : Words;
      end record;
   
end CPU;
