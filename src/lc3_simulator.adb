with Ada.Text_IO; use Ada.Text_IO;
with CPU; use CPU;

package body LC3_Simulator is

   procedure Simulate is
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
      
      ADD_Test  : constant Words := 2#0001001001000001#;
      ADD_Test2 : constant Words := 2#0001111001100111#;
      AND_Test  : constant Words := 2#0101001001000001#;
      BR_Test   : constant Words := 2#0000000101100000#;
      
      Memory : constant array (Natural range 1 .. 4) of Words :=
        (ADD_Test,
         ADD_Test2,
         AND_Test,
         BR_Test );
      
      type Padding_Type is mod 2**(Word_Size-4);
      
      function Value (Word : in Words) return Mnemonics is
      begin
         return Instruction_Table (Instructions (Word/(2**(Word_Size-Instruction_Size))));
      end Value;
      --  Extracts the Mnemonic of a word.
      
      function Extract (Bits : in Words;
                        From : in words;
                        To   : in words) return Words is
         Mask   : Words := 0;
         Result : Words;
      begin
         pragma Assert (From >= To);
         --  Initialize the bitpattern.
         for I in From .. To loop
            Mask := Mask + 2**Natural(I);
         end loop;
         
         --  Apply the mask, and shift the result.
         Result := Bits and Mask;
         Result := Result / (2**Natural(From));
         
         return Result;
      end Extract;
      
      procedure Add (Bits : in Words) is
         Immidiate_Flag : constant Words := 2#0000000000100000#;
         Use_Immidiate  : constant Boolean  := (Bits and Immidiate_Flag) > 0;
         DR, SR1, SR2   : Registers; 
      begin
         
         if Use_Immidiate then
            Put_Line("Using immidiate");
         else
            Put_Line("Not Using immidiate");
         end if;
         DR := Registers (Extract (Bits, 9, 11));
         Put_Line("DR" & Registers'Image (DR));
      end;
      
      
   begin
      for Word in Memory'Range loop
         Put_Line (Value(Memory(Word))'Img);
         
         case Value(Memory(Word)) is
            when Add =>
               Add (Memory(Word));
            when others =>
               null;
         end case;
         
      end loop;
      
      null;
      --   Read_Word;
      --   Decode;
   end Simulate;
end LC3_Simulator;
