with CPU_Specifications;
package Bit_Utilities is
   use CPU_Specifications;

   function Extract (Bits : in Words;
                     From : in words;
                     To   : in words) return Words;
   --  Extracts a bitsequence from a word.
end Bit_Utilities;
