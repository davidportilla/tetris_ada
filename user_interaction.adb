with Actions; use Actions;
with Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Bricks;

package body user_interaction is

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
            Bricks.Drop_Brick(ok);
            exit when not ok;
            T := T + milliseconds(10);
            delay until T;
          end loop;
        when Left => Bricks.Move_Left;
        when Rotate => Bricks.Move_Rotate;
        when Right => Bricks.Move_Right;
      end case;
    end loop;
  end send_user_input;

end user_interaction;
