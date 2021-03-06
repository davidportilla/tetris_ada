with Wall;

package Bricks is

   protected Bricks_Functions is
   function Finished return Boolean;

   procedure Init_Game;
   procedure Put_F
    (X     : in Wall.Width;
     Y     : in Wall.Height;
     Brick : in Wall.Brick_Type;
     Done  : out Boolean);
   procedure Move_Right;
   procedure Move_Left;
   procedure Move_Rotate;
   procedure Drop_Brick (Ok : out Boolean);
   end Bricks_Functions;

end Bricks;
