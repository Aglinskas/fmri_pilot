close all;
%clear all;
Screen('Preference', 'SkipSyncTests', 1); % disable if script crashes. 
sca;

screens = Screen('Screens'); % number of screens available
screenNumber = max(screens);% Draw to the external screen if avaliable
screenNumber = 1 % which screen to use (0 - main screen; 1 extra screen)
%% PsychDefaultSetup(2);
% Get the screen numbers

%screenNumber = min(screens); % always draws on the main screen 
% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;
% Open an on screen window
%Takes over the screen
%[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[window, windowRect] = Screen(screenNumber, 'openwindow',[128 128 128]);
% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Query the frame duration
ifi = Screen('GetFlipInterval', window);
% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);
% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
%% Screen is blank at this point
%% get an image on the screen
theImageLocation = 'Other/Faster.jpeg';
theImage = imread(theImageLocation);
[s1, s2, s3] = size(theImage);
imageTexture = Screen('MakeTexture', window, theImage);
Screen('DrawTexture', window, imageTexture, [], [e1 e3 e2 e4],0);
Screen('Flip', window);


windowRect % screen dimension
e1 = xCenter - s2/2;e2 = xCenter + s2/2;e3 = yCenter - s1/2 - 150; e4 = yCenter + s1/2 - 150;
 

% flips the image
imageTexture = Screen('MakeTexture', window, theImage);
Screen('DrawTexture', window, imageTexture, [], [e1 e3 e2 e4],0)

Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter e4 - 220])
%Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter e4 - 230]);

Screen('Flip', window);
%% draw fixation cross

fixCrossDimPix = 35;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the cent1er of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 4;
%
% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
%Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter yCenter], 2);
Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter e4 - 220]); 


















