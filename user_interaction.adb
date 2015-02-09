with Actions, Text_IO, Ada.Real_Time, Bricks; use Actions, Ada.Real_Time;

package body user_interaction is

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

  task body take_user_input is
    user_input: character;
    available: boolean;
    T: Time := Clock;
  begin
    loop
      Text_IO.Get_Immediate (user_input, available);
      if available then
        --Text_IO.Put_Line("user input: " & character'Image(user_input) );
        case user_input is
          when '2' => Shared_Action.SetAction(Drop);
          when '4' => Shared_Action.SetAction(Left);
          when '5' => Shared_Action.SetAction(Rotate);
          when '6' => Shared_Action.SetAction(Right);
          --when 'Y' => null;
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
  begin
    loop
      Shared_Action.GetAction(command);
      case command is
        when Drop => Bricks.Drop_Brick(ok);
        when Left => Bricks.Move_Left;
        when Rotate => Bricks.Move_Rotate;
        when Right => Bricks.Move_Right;
        --when Exit => null;
        --when others => null;
      end case;
    end loop;
  end send_user_input;

end user_interaction;