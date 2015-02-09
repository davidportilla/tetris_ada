package body Actions is

  protected body Shared_Action is

    procedure SetAction(X : in ActionMode) is
    begin
      action := X;
      flag := true;
    end SetAction;

    entry GetAction (X : out ActionMode) when flag is
    begin
      X := action;
      flag := false;
    end GetAction;

  end Shared_Action;

end Actions;
