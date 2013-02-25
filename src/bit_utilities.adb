package body Bit_Utilities is

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

end Bit_Utilities;
