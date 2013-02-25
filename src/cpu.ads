with CPU_Specifications;

package CPU is
   use CPU_Specifications;

   Register : array (Registers) of Words := ( others => 0);

   Flag : array (CPU_Flags) of Boolean;

   procedure Tick;

private
   Current_Operation   : Words        := 0;
   Instruction_Pointer : Memory_Index := Memory_Index'First;

   Instruction_Cycle : Instruction_Cycles := Instruction_Cycles'First;
end CPU;
