with Ada.Real_Time; use Ada.Real_Time;
with Screen, Bricks, Wall, Game_Avance, User_Interaction, Text_IO;

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

end Tetris;
