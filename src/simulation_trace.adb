with Ada.Text_IO; use Ada.Text_IO;

package body Simulation_Trace is

   procedure Debug (Context : in String := ""; Message : in String) is
   begin
      if Context /= "" then
         Put_Line (Context & ": " & Message);
      else
         Put_Line ("??: " & Message);
      end if;
   end Debug;

end Simulation_Trace;
