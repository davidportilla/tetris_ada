with Screen, Bricks, Wall, Arrival, Text_IO;

procedure Tetris is
   pragma Priority (4);

   Ch        : Character;
   Available : Boolean;
   Ok        : Boolean;

begin
   loop

      Screen.ClearScreen;
      Wall.Initialize;
      Screen.MoveCursor ((Column => 10, Row => 3));
      Text_IO.Put_Line (" TETRIS Ada ");
      Screen.MoveCursor ((Column => 1, Row => 5));
      Text_IO.Put_Line ("2=drop 4=left 5=spin 6=right");

      Bricks.Start;
      Arrival.Manager.Start;
      Arrival.Timer.Start;
      Arrival.Speeder.Start;

      Outer : loop
         loop
            Text_IO.Get_Immediate (Ch, Available);
            exit when Available;
            delay 0.01;
         end loop;
         exit Outer when Bricks.Finished;
         case Ch is
            when '2' => -- Down arrow
               loop
                  Bricks.Drop_Brick (Ok);
                  --Ok := True; -- Keep dropping the brick
                  exit when not Ok;
               end loop;
               delay 1.0;

            when '4' => -- Left arrow
              Bricks.Move_Left;

            when '5' => -- blank
              Bricks.Move_Rotate;

            when '6' => -- Right arrow
              Bricks.Move_Right;

            when others =>
               null;
         end case;
      end loop Outer;

      Arrival.Speeder.Stop;
      Arrival.Timer.Stop;
      Bricks.Stop;
      Arrival.Manager.Stop;

      exit when Ch /= 'Y' and Ch /= 'y';
   end loop;

   Screen.ClearScreen;

end Tetris;
