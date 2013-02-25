with Ada.Unchecked_Conversion;

with Interfaces;

package CPU_Specifications is
   use Ada;

   Word_Size        : constant Natural := 16;
   Instruction_Size : constant Natural := 4;
   Register_Size    : constant Natural := 3;

   type Words is mod 2**Word_Size;
   type Instructions is mod 2**Instruction_Size;
   type Operands is mod 2**(Word_Size-Instruction_Size);
   type Registers is mod 2**Register_Size;
   type Memory_Index is mod (2**Word_Size);

   type LC3_Integer is new Interfaces.Integer_16;

   function Value is new Unchecked_Conversion (Source => Words,
                                               Target => LC3_Integer);
   function Value is new Unchecked_Conversion (Source => LC3_Integer,
                                               Target => Words);

   type CPU_Flags is (P,Z, N);

   type Instruction_Cycles is (Fetch, Decode, Load, Evaluate, Store);

      type Mnemonics is (
                      Conditional_Branch,     -- 0000
                      Add,                    -- 0001
                      Load,                   -- 0010
                      Store,                  -- 0011
                      JSR_Or_JSRR,            -- 0100
                      Bit_Or_Logic_And,       -- 0101
                      Load_Relative,          -- 0110
                      Store_Relative,         -- 0111
                      Return_From_Interrupt,  -- 1000
                      Bitwise_Not,            -- 1001
                      Load_Indirect,          -- 1010
                      Store_Indirect,         -- 1011
                      JMP_Or_RET,             -- 1100
                      Unused,                 -- 1101
                      Load_Effective_Address, -- 1110
                      Return_From_Sub,        -- 1000
                      Trap                   -- 1111
                     );

   Instruction_Table : array (Instructions) of Mnemonics :=
     (2#0000# => Conditional_Branch,
      2#0001# => Add,
      2#0010# => Load,
      2#0011# => Store,
      2#0100# => JSR_Or_JSRR,
      2#0101# => Bit_Or_Logic_And,
      2#0110# => Load_Relative,
      2#0111# => Store_Relative,
      2#1000# => Return_From_Interrupt,
      2#1001# => Bitwise_Not,
      2#1010# => Load_Indirect,
      2#1011# => Store_Indirect,
      2#1100# => JMP_Or_RET,
      2#1101# => Unused,
      2#1110# => Load_Effective_Address,
      2#1111# => Return_From_Sub);
end CPU_Specifications;
