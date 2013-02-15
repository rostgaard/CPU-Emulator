package CPU is
   
   Word_Size        : constant Natural := 16;
   Instruction_Size : constant Natural := 4;
   Register_Size    : constant Natural := 3;
   
   type Words is mod 2**Word_Size;
   type Instructions is mod 2**Instruction_Size;
   type Operands is mod 2**(Word_Size-Instruction_Size);
   type Registers is mod 2**Register_Size;
   
   type CPU_Flags is (P,Z, N);

   Register : array (0 .. 7) of Registers := ( others => 0);
   
--   Flags : array (
   
end CPU;
