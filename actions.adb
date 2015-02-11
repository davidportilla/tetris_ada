package body Actions is

  protected body Protected_Action is

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

  end Protected_Action;

  protected body Protected_Restart is

    procedure Restart_Request is
    begin
      flag := true;
    end Restart_Request;

    entry Wait_For_Restart when flag is
    begin
      flag := false;
    end Wait_For_Restart;

  end Protected_Restart;

end Actions;
