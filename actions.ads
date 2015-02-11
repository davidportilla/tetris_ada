package Actions is

type ActionMode is (Left, Right, Rotate, Drop, Restart, Exit_Tetris);

protected Shared_Action is

   procedure SetAction (X: in ActionMode);
   entry GetAction (X: out ActionMode);

   private
     action : ActionMode;
     flag : boolean := false;

end Shared_Action;

protected Shared_Restart is

  procedure Restart_Request;
  entry Wait_For_Restart;

  private
  flag : boolean := false;

end Shared_Restart;

end Actions;
