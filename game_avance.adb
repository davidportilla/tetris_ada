with Bricks; with Wall;
with Ada.Real_Time; use Ada.Real_Time; with Text_IO;

package body game_avance is

  T : Time := Clock;

  type Unsigned is range 0 .. 2 ** 16;

  Seed : Unsigned := 3;
  --Unsigned(Float (To_Duration
  --(Time_Span (Clock - Time_First))) / 10.0);

  function Cheap_Random return Integer is
  begin
    Seed := (Seed * 25173 + 13849) mod 2 ** 16;
    return Integer (Seed mod 2 ** 15);
  end Cheap_Random;

  task body put_and_drop is
    ok : boolean; -- true if we can drop the brick
    done : boolean; -- true if we can place the brick
    brick_style : Wall.Styles;
  begin
    loop
      brick_style := Wall.Styles (Cheap_Random mod Wall.Styles'Last + 1);
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
