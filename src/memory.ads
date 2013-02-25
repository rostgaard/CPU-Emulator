with CPU_Specifications;

package Memory is
   use CPU_Specifications;

   ADD_Test  : constant Words := 2#0001001001000001#;
   ADD_Test2 : constant Words := 2#0001111001100111#;
   AND_Test  : constant Words := 2#0101001001000001#;
   BR_Test   : constant Words := 2#0000000101100000#;

   Storage : array (Memory_Index) of aliased Words :=
     (ADD_Test,
      ADD_Test2,
      AND_Test,
      BR_Test,
      others => 0);

end Memory;
