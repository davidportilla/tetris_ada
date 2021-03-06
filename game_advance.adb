with Bricks; use Bricks;
with Wall;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Numerics.Discrete_Random;
with Actions; use Actions;

package body game_advance is

  package Random_Integer is new Ada.Numerics.Discrete_Random (Integer);
  int_generator : Random_Integer.Generator;

  function getRandomInt return Integer is
  begin
    return Random_Integer.Random(int_generator);
  end getRandomInt;

  task body put_and_drop is
    T : Time;
    initial_delay : Time_Span := milliseconds(600);
    speeder : Time_Span;
    counter : Integer;
    ok : boolean; -- true if we can drop the brick
    done : boolean; -- true if we can place the brick
    brick_style : Wall.Styles;
  begin
    loop
      T := Clock;
      Bricks_Functions.Init_Game;
      speeder := milliseconds(0);
      counter := 0;
      Random_Integer.Reset(int_generator);
      loop
        brick_style := Wall.Styles (getRandomInt mod Wall.Styles'Last + 1);
        Bricks_Functions.Put_F(5, 2, Wall.Pick(brick_style), done);
        exit when done;
        loop
          T := T + initial_delay - speeder;
          delay until T;
          if ((counter mod 10) = 0) then
            speeder := speeder + milliseconds(10);
          end if;
          counter := counter + 1;
          Bricks_Functions.Drop_Brick(ok);
          exit when not ok;
        end loop;
        Wall.Erase_Lines;
      end loop;
      Protected_Restart.Wait_For_Restart; -- wait until user restarts
    end loop;

  end put_and_drop;

end game_advance;
