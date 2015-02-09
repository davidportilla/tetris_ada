package Actions is

type ActionMode is (Left, Right, Rotate, Drop);

protected Shared_Action is

   procedure SetAction (X: in ActionMode);
   entry GetAction (X: out ActionMode);

   private
     action : ActionMode;
     flag : boolean := false;

end Shared_Action;

end Actions;
