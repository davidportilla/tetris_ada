package body Actions is

  protected body Shared_Action is

    procedure SetAction(X : in ActionMode) is
    begin
      action := X;
    end SetAction;

    entry GetAction (X : out ActionMode) when flag is
    begin
      X := action;
    end GetAction;

  end Shared_Action;

end Actions;
