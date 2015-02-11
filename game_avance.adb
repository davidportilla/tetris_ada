with Bricks;
with Wall;
with Screen;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Numerics.Discrete_Random;
with Text_IO;
with Actions; use Actions;

package body game_avance is

  package Random_Integer is new Ada.Numerics.Discrete_Random (Integer);
  int_generator : Random_Integer.Generator;

  function getRandomInt return Integer is
  begin
    return Random_Integer.Random(int_generator);
  end getRandomInt;

  task body put_and_drop is
    T : Time := Clock;
    initial_delay : Time_Span := milliseconds(600);
    speeder : Time_Span;
    counter : Integer;
    ok : boolean; -- true if we can drop the brick
    done : boolean; -- true if we can place the brick
    brick_style : Wall.Styles;
  begin
    loop
      speeder := milliseconds(0);
      counter := 0;
      Random_Integer.Reset(int_generator);
      loop
        brick_style := Wall.Styles (getRandomInt mod Wall.Styles'Last + 1);
        Bricks.Put_F(5, 2, Wall.Pick(brick_style), done);
        exit when done;
        loop
          T := T + initial_delay - speeder;
          delay until T;
          if ((counter mod 10) = 0) then
            speeder := speeder + milliseconds(10);
          end if;
          counter := counter + 1;
          Bricks.Drop_Brick(ok);
          exit when not ok;
        end loop;
        Wall.Erase_Lines;
      end loop;
      Shared_Restart.Wait_For_Restart; -- wait until user restarts
    end loop;

  end put_and_drop;

end game_avance;
