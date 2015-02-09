with Ada.Real_Time; use Ada.Real_Time;
with Screen, Bricks, Wall, Game_Avance, Text_IO;

procedure Tetris is
   pragma Priority (4);

   user_input: character;
   available: boolean;
   T: Time := Clock;

   begin

      Screen.ClearScreen;
      Wall.Initialize;
      Screen.MoveCursor ((Column => 10, Row => 3));
      Text_IO.Put_Line (" TETRIS Ada ");
      Screen.MoveCursor ((Column => 1, Row => 5));
      Text_IO.Put_Line ("2=drop 4=left 5=spin 6=right");

      --loop
      --  Text_IO.Get_Immediate (user_input, available);
      --  exit when available;
      --  T := T + milliseconds(10);
      --  delay until T;
    --end loop;
      -- 2 down arrow
      -- 4 left arrow
      -- 6 right arrow
      -- 5 rotate
      -- Y exit


   --Screen.ClearScreen;

end Tetris;
