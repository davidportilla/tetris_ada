with Ada.Real_Time;
with Ada.Text_IO;

with Bricks;
with Wall;

package body Arrival is

   use Ada.Real_Time;

   Initial_Delay : Time_Span := Milliseconds(600);
   Delay_Time    : Time_Span;

   type Unsigned is range 0 .. 2 ** 16;

   Seed : Unsigned := Unsigned(Float (To_Duration
     (Time_Span (Clock - Time_First))) / 10.0);

   ------------------
   -- Cheap_Random --
   ------------------

   function Cheap_Random return Integer is
   begin
      Seed := (Seed * 25173 + 13849) mod 2 ** 16;
      return Integer (Seed mod 2 ** 15);
   end Cheap_Random;

   -------------
   -- Manager --
   -------------

   task body Manager is
      Style : Wall.Styles;
      Done  : Boolean;
   begin
      Outer : loop
         accept Start;
         Middle : loop
            --  Select a brick
            Style := Wall.Styles (Cheap_Random mod Wall.Styles'Last + 1);
            select
               accept Tick;
            or
               accept Stop;
               exit Middle;
            or
               delay until Clock + Delay_Time;
            end select;

            --  Display it
            Bricks.Put_F
              (X     => 5,
               Y     => 2,
               Brick => Wall.Pick (Style),
               Done  => Done);
            if Done then
               accept Stop;
               exit Middle;
            end if;

            --  Make it move
            for Y in Wall.Height'First + 1 .. Wall.Height'Last loop
               declare
                  Ok : Boolean;
               begin
                  select
                     accept Tick;
                  or
                     accept Stop;
                     exit Middle;
                  or
                     delay until Clock + Delay_Time;
                  end select;
                  Bricks.Drop_Brick (Ok);
                  if not Ok then
                     exit;
                  end if;
               end;
            end loop;
            Wall.Erase_Lines;
         end loop Middle;
      end loop Outer;
   end Manager;

   -----------
   -- Timer --
   -----------

   task body Timer is
   begin
      Outer : loop
         Delay_Time := Initial_Delay;
         accept Start;
         Main : loop
            select
               accept Stop;
               exit Main;
            or
               delay until Clock + Delay_Time;
            end select;
            select
               Manager.Tick;
            else
               null;
            end select;
         end loop Main;
      end loop Outer;
   end Timer;

   -------------
   -- Speeder --
   -------------

   task body Speeder is
   begin
      Delay_Time := Initial_Delay;
      Outer : loop
         accept Start;
         Middle : loop
            for I in 1 .. 100 loop
               select
                  accept Stop;
                  exit Middle;
               or
                  delay until Clock + Delay_Time;
               end select;
            end loop;
            Delay_Time := Delay_Time * 9 / 10;
         end loop Middle;
      end loop Outer;
   end Speeder;

end Arrival;
