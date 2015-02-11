with Game_Advance;
with User_Interaction;

procedure Tetris is

   begin
     null;
     -- tasks:
     -- Game_Advance.Put_And_Drop
     -- User_Interaction.Take_User_Input
     -- User_Interaction.Send_User_Input

end Tetris;

-- *****README*****
--
-- author: David Portilla Abellán
-- version: 11-feb-2015
-- tested on OS X 10.10 with gcc 4.9.1
--
-- The program has three tasks:
--
-- 1) game_advance.put_and_drop
-- This task manages the normal operation of the tetris: it places a
-- random brick, and let it drop after some delay. These delay is
-- decreased with the time, so the game becomes more difficult.
--
-- 2) user_interaction.take_user_input
-- It reads continuously from the keyboard and writes the action in the
-- protected object actions.protected_action
--
-- 3) user_interaction.send_user_input
-- It reads from protected_action the action to execute, and calls
-- the corresponding procedure of Bricks. If there is no action it waits
-- on the barrier of protected_action.
--
-- For starting a new game it is used the protected object
-- Actions.Protected_Restart. The task put_and_drop will wait on this object
-- until the user sends a restart request.
--
-- Important: the functions in bricks may be protected, as they use
-- Text_IO.Put_Line which is not thread safe. If they are not, can occur
-- that put_and_drop is dropping a brick and send_user_input makes
-- other action at the same time. In this case, a lot of characters
-- are written at the left of the screen, and some unexpected behaviour
-- on the game can occur. To fix it, Bricks procedures are encapsulated in
-- a protected object called Bricks_Functions.
