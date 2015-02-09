with Screen;
with Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
package body Wall is

   subtype Width_Inner is Width range
     Width'Succ (Width'First) .. Width'Pred (Width'Last);
   subtype Height_Inner is Height range
     Height'First .. Height'Pred (Height'Last);

   Pick_Array : array (Styles) of Brick_Type :=
     (((-1, 1), (0, 1), (1, 1), (2, 1)), -- Long
      ((0, 0), (0, 1), (0, 2), (1, 2)),
      ((0, 0), (1, 0), (0, 1), (0, 2)),
      ((0, 0), (0, 1), (1, 0), (1, 1)),  -- Square
      ((0, 0), (0, 1), (1, 1), (1, 2)),
      ((1, 0), (1, 1), (0, 1), (0, 2)),
      ((1, 0), (0, 1), (1, 1), (1, 2)));

   type Line is array (Width) of Boolean;
   type Wall_Type is array (Height) of Line;
   Tetris_Wall : Wall_Type;

   ----------
   -- Pick --
   ----------

   function Pick (Style : in Styles) return Brick_Type is
   begin
      return Pick_Array (Style);
   end Pick;

   --------------
   -- Put_Wall --
   --------------

   procedure Put_Wall is
      Tetris_Piece : Boolean;
   begin
      for Y in Height'First .. Height'Last loop
         for X in Width'First .. Width'Last loop
            Tetris_Piece := Tetris_Wall (Y) (X);
            Screen.MoveCursor ((Column => 30 + X * 2, Row => 2 + Y));
            if Y in Height_Inner'First .. Height_Inner'Last and
               X in Width_Inner'First .. Width_Inner'Last
            then
               if Tetris_Piece then
                  Text_IO.Put_Line ("[]");
               else
                  Text_IO.Put_Line ("  ");
               end if;
            else
               Text_IO.Put_Line ("##");
            end if;
         end loop;
      end loop;
   end Put_Wall;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      for I in Height'First .. Height'Last - 1 loop
         Tetris_Wall (I) :=
           (Width'First                                          |
            Width'Last                                           => True,
            Width'Succ (Width'First) .. Width'Pred (Width'Last)  => False);
      end loop;
      Tetris_Wall (Height'Last) := (others => True);
      Put_Wall;
   end Initialize;

   ---------
   -- Put --
   ---------

   procedure Put (Brick : in Brick_Type; X : in Width; Y : in Height) is
      Bx, By : Natural;
   begin
      for I in Brick'Range loop
         Bx := X + Brick (I).X;
         By := Y + Brick (I).Y;
         Screen.MoveCursor ((Column => 30 + Bx * 2, Row => 2 + By));
         Text_IO.Put_Line ("[]");
      end loop;
   end Put;

   procedure Put (X : in Width; Y : in Height; Attr : in Boolean) is
   begin
      Screen.MoveCursor ((Column => 30 + X * 2, Row => 2 + Y));
      if Attr then
         Text_IO.Put_Line ("[]");
      else
         Text_IO.Put_Line ("--");
      end if;
   end Put;

   -----------
   -- Erase --
   -----------

   procedure Erase (Brick : in Brick_Type; X : in Width; Y : in Height) is
      Bx, By : Natural;
   begin
      for I in Brick'Range loop
         Bx := X + Brick (I).X;
         By := Y + Brick (I).Y;
         Screen.MoveCursor ((Column => 30 + Bx * 2, Row => 2 + By));
         Text_IO.Put_Line ("  ");
      end loop;
   end Erase;

   -----------
   -- Place --
   -----------

   procedure Place (Brick : in Brick_Type; X : in Width; Y : in Height) is
      Bx, By : Natural;
   begin
      for I in Brick'Range loop
         Bx                     := X + Brick (I).X;
         By                     := Y + Brick (I).Y;
         Tetris_Wall (By) (Bx)  := True;
      end loop;
   end Place;

   -------------
   -- Examine --
   -------------

   function Examine
     (Brick : in Brick_Type;
      X     : in Width;
      Y     : in Height)
      return  Boolean
   is
      Bx, By : Natural;
   begin
      for I in Brick'Range loop
         Bx := X + Brick (I).X;
         By := Y + Brick (I).Y;
         if not (Bx in Width_Inner) or else not (By in Height_Inner) then
            return False;
         elsif Tetris_Wall (By) (Bx) then
            return False;
         end if;
      end loop;
      return True;
   end Examine;

   -----------------
   -- Erase_Lines --
   -----------------

   procedure Erase_Lines is
      Line_No     : array (Height_Inner) of Height_Inner;
      No_Of_Lines : Natural := Height_Inner'First - 1;
      Attribute   : Boolean := True;
      T : Time := Clock;
   begin
      for Y in Height_Inner loop
         for X in Width_Inner loop
            exit when not Tetris_Wall (Y) (X);
            if X = Width_Inner'Last then
               No_Of_Lines           := No_Of_Lines + 1;
               Line_No (No_Of_Lines) := Y;
            end if;
         end loop;
      end loop;
      if Height_Inner'First <= No_Of_Lines then
         for I in 1 .. 8 loop
            Attribute := not Attribute;
            for I in Height_Inner'First .. No_Of_Lines loop
               for X in Width_Inner loop
                  Put (X, Line_No (I), Attribute);
               end loop;
            end loop;
            T := T + milliseconds(100);
            delay until T;
         end loop;
         for I in Height_Inner'First .. No_Of_Lines loop
            Tetris_Wall (Height_Inner'First + 1 .. Line_No (I))  :=
              Tetris_Wall (Height_Inner'First .. Line_No (I) - 1);
         end loop;
         Put_Wall;
      end if;
   end Erase_Lines;

end Wall;
