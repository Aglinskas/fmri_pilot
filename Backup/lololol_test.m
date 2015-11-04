screens = Screen('Screens');
screenNumber = max(screens); % Draw to the external screen if avaliable
%screenNumber = min(screens); % always draws on the main screen 


% Define black and white
Screen('Preference', 'SkipSyncTests', 1); % disable if script crash
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;
[window, windowRect] = Screen(screenNumber, 'openwindow',[128 128 128]);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
WaitSecs(5);