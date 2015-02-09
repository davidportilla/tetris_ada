with Bricks;
with Wall;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Numerics.Discrete_Random;
with Text_IO;

package body game_avance is

  package Random_Integer is new Ada.Numerics.Discrete_Random (Integer);
  int_generator : Random_Integer.Generator;

  function getRandomInt return Integer is
  begin
    return Random_Integer.Random(int_generator);
  end getRandomInt;

  task body put_and_drop is
    T : Time := Clock;
    ok : boolean; -- true if we can drop the brick
    done : boolean; -- true if we can place the brick
    brick_style : Wall.Styles;
  begin
    Random_Integer.Reset(int_generator);
    loop
      brick_style := Wall.Styles (getRandomInt mod Wall.Styles'Last + 1);
      Bricks.Put_F(5, 2, Wall.Pick(brick_style), done);
      exit when done;
      loop
        T := T + milliseconds(600);
        delay until T;
        Bricks.Drop_Brick(ok);
        exit when not ok;
      end loop;
      Wall.Erase_Lines;
    end loop;

  end put_and_drop;

end game_avance;
