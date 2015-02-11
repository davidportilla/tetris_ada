package Actions is

type ActionMode is (Left, Right, Rotate, Drop, Restart, Exit_Tetris);

protected Protected_Action is

   procedure SetAction (X: in ActionMode);
   entry GetAction (X: out ActionMode);

   private
     action : ActionMode;
     flag : boolean := false;

end Protected_Action;

protected Protected_Restart is

  procedure Restart_Request;
  entry Wait_For_Restart;

  private
  flag : boolean := false;

end Protected_Restart;

end Actions;
