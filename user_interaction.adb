with Actions; use Actions;
with Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Bricks; use Bricks;
with Screen;
with Wall;
with GNAT.OS_Lib;

package body user_interaction is

  Exit_Status : Integer := 0; -- status code for program termination

  task body take_user_input is
    user_input: character;
    available: boolean;
    T: Time := Clock;
  begin
    loop
      Text_IO.Get_Immediate (user_input, available);
      if available then
        case user_input is
          when '2' => Shared_Action.SetAction(Drop);
          when '4' => Shared_Action.SetAction(Left);
          when '5' => Shared_Action.SetAction(Rotate);
          when '6' => Shared_Action.SetAction(Right);
          when 'y' | 'Y' => Shared_Action.SetAction(Restart);
          when 'n' | 'N' => Shared_Action.SetAction(Exit_Tetris);
          when others => null;
        end case;
      end if;
      T := T + milliseconds(10);
      delay until T;
  end loop;
  end take_user_input;

  task body send_user_input is
    command : ActionMode;
    ok : boolean;
    T: Time := Clock;

  begin
    loop
      Shared_Action.GetAction(command);
      case command is
        when Drop =>
          loop
            Bricks_Functions.Drop_Brick(ok);
            exit when not ok;
            T := T + milliseconds(10);
            delay until T;
          end loop;
        when Left => Bricks_Functions.Move_Left;
        when Rotate => Bricks_Functions.Move_Rotate;
        when Right => Bricks_Functions.Move_Right;
        when Exit_Tetris =>
          if Bricks_Functions.Finished then
            Screen.ClearScreen;
            GNAT.OS_Lib.OS_Exit(Exit_Status);
          end if;
        when Restart =>
          if Bricks_Functions.Finished then
            Bricks_Functions.Init_Game;
            Shared_Restart.Restart_Request;
          end if;
      end case;
    end loop;
  end send_user_input;

end user_interaction;
