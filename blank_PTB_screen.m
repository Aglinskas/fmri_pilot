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
theImageLocation = myTrials(randi(150,1)).filepath
theImage = imread(theImageLocation);
% image parameters
[s1, s2, s3] = size(theImage);

windowRect % screen dimension
e1 = xCenter - s2/2; % right edge of picture
e2 = xCenter + s2/2; % left edgle of picture
e3 = yCenter - s1/2 - 150; % top of picture
e4 = yCenter + s1/2 - 150; % bottom of picture
 

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


















%% test 
pace = 1;
instruct_time = 1
%ExpStart = GetSecs;
myTrials = func_myPracticeTrials(8,2)
%%  BLOCKS here
% Beginning of a block, task instructions, fixation cross
for expBlock = 1 : numBlocks
%     %% each block starts with an intro slide:
%     theImageLocation = fullfile(instruction_dir,slides_list(question_slides(expBlock)).name)
%     theImage = imread(theImageLocation);
%     imageTexture = Screen('MakeTexture', window, theImage);
% Screen('DrawTexture', window, imageTexture, [], windowRect,0)
% Screen('Flip', window);
% KbWait(-1)
% WaitSecs(0.1)
% 
% theImageLocation = fullfile(instruction_dir,slides_list(got_it_slide).name)
%     theImage = imread(theImageLocation);
%     imageTexture = Screen('MakeTexture', window, theImage);
% Screen('DrawTexture', awindow, imageTexture, [], windowRect,0)
% Screen('Flip', window);
% KbWait(-1)
% WaitSecs(0.1);
    %% Sets up the task and prompts
% %         
% %    
% % %     f_lines = find([myTrials.fmriblock] == rf_block(expBlock));
% % %     ff_line = f_lines(1);
% % %     lf_line = f_lines(length(f_lines))
% % %     %CurrentTask_num = randTask(expBlock);
%    CurrentTask_num = ff_line
%     CurrentTask{1,1} = Task(CurrentTask_num);
% %     %CurrentTask{1,2} = Task(CurrentTask_num,2);
% %     %taskName = CurrentTask{1,1}{1,1};
%     %taskIntruct = CurrentTask{1,2}{1,1}
    %expBlock * fmriTrials - fmriTrials + 1
   taskName = myTrials(expBlock * numTrials - numTrials + 1).TaskName;
   taskIntruct = myTrials(expBlock * numTrials - numTrials + 1).taskIntruct;
%% 
        %myTrials(Shuffled_faces() + 1).filenames
       %strcmp(myTrials(i_line).TaskName,control_task)
        
        % randperm(numTrials)
        %ceil(2.5)
        
      %  a = randperm(numTrials)
       % c_taskTrialsk
    % Task Name
Screen('TextSize', window, 28);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, taskName, 'center', 350, white);
% Task instructions
Screen('TextSize', window, 24);
Screen('TextFont', window, 'Courier');
%lower_third = screenYpixels / 3 * 2 + 50;
lower_third = 600;
cCenter = xCenter - length(taskIntruct); %change
%DrawFormattedText(window, taskIntruct, 'center', lower_third, white); % %centers nicely - not justified
DrawFormattedText(window, taskIntruct, cCenter, 'center', white);

%xCenter
%DrawFormattedText(window, 'What movies have they been in?', 'center', screenYpixels * 0.15, [1 0 0]);
Screen('Flip', window);
%t_startReading = GetSecs; %delete
%if instruct_param == 2
% RestrictKeysForKbCheck(spaceKey); %waits for space
% KbWait;
 %t_donereading = GetSecs; % delete
 %RestrictKeysForKbCheck(responseKeyes); % re-enabled response keyes
%else 
if pace == 1
   % RestrictKeysForKbCheck(spaceKey);
    pause(0.3)
   % RestrictKeysForKbCheck(enabledKeyes);
elseif pace == 2
    WaitSecs(instruct_time);
elseif pace == 3
    WaitSecs(instruct_time);
end

    
 % length of time that task and instructions are on the screen
%end               nnbsca

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
Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter e4 - 220]); % change 2350 is the y coord
% fix cross %xcros
%[570 150 870 550]
% Flip to the screen
Screen('Flip', window);
if pace == 1
    pause(0.3)
elseif pace == 3
WaitSecs(t_fixCross);
elseif pace == 2
    WaitSecs(t_fixCross);
end% Time that fixation cross is on the screen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EXPERIMENTAL RUN. 1 loop of code below = 1 trial
%fmriblocks
  % specify number of iterations
%for numBlocks * numTrials - 4 = 1 : numBlocks * numTrials
for ExpTrial = expBlock * numTrials - (numTrials - 1) : expBlock * numTrials; % code that matches blocks, trials, and trials per block
%for ExpTrial = 1 : fmriTrials
    pressed=0;
theImageLocation = myTrials(ExpTrial).filepath; % gets picture from myTrials
theImage = imread(theImageLocation);
%time_to_respond = myTrials(ExpTrial).time_to_respond;
% Get the size of the image
[s1, s2, s3] = size(theImage);

% Here we check if the image is too big to fit on the screen and abort if
% it is. See ImageRescaleDemo to see how to rescale an image.
if s1 > screenYpixels || s2 > screenYpixels
    disp('ERROR! Image is too big to fit on the screen');
    sca;
    return;
end

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the of the screen. We first draw the
% image in its correct orientation.
%uCenter = yCenter - 50 % a bit upper than Center
%Screen('DrawTexture', window, imageTexture, [], [], 0);% instruction in the xcenter and ycenter
                                      %     [], [], 0); imgRect, centerRect(imgRect*2, rect)
  
e1 = xCenter - s2/2; % right edge of picture
e2 = xCenter + s2/2; % left edgle of picture
e3 = yCenter - s1/2 - 150; % top of picture
e4 = yCenter + s1/2 - 150; % bottom of picture
 
 Screen('DrawTexture', window, imageTexture, [], [e1 e3 e2 e4],0);                                     
                                      
%Screen('DrawTexture', window, imagecTexture, [], [570 150 870 550],0); % only works on 1440 * 900 screen 
%570 870 250 650
%Screen('DrawTexture', window, imageTexture, [255 255 0], [255 255 0], 0);%
lower_third = 600;

%DrawFormattedText(window, taskIntruct, 'left', cCenter, white, [],[],[],[],[],[600 600 840 700]); % instructions below the image

% Flip to the screen
Screen('Flip', window); % the image is now on the screen
timePresented = GetSecs - ExpStart;
t_presented = GetSecs;
myTrials(ExpTrial).time_presented = timePresented;
%myTrials(ExpTrial).ExpBlock2 = expBlock;
%myTrials(ExpTrial).TaskName2 = taskName;
%myTrials(ExpTrial).taskIntruct2 = taskIntruct;
% Wait for two seconds
%WaitSecs(myTrials(ExpTrial).stimTime); % STIMULUS-ON TIME
%WaitSecs(myTrials(ExpTrial).time_to_r         espond); %stimulus is on the screen for a time period specified in myTrials
WaitSecs(StimTime);
% Now fill the screen GREY
Screen('FillRect', window, grey); % screen  is now blanc
%Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter 350]); % fix cross after face
%DrawFormattedText(window, taskIntruct, cCenter, lower_third, white); % instructions below the fix cross
Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter e4 - 220]);
% Flip to the screen
Screen('Flip', window);% fix cross on screen waiting for response
t_fix = GetSecs
%[secs, keyCode, deltaSecs] = KbWait;
%WaitSecs(time_to_respond)

if pace == 1
    pause(0.3)
elseif pace == 3 
    %WaitSecs(time_to_respond)
    RestrictKeysForKbCheck([30;31;32;33]);
    [secs button_press c] = KbWait(-1);
    myTrials(ExpTrial).RT = secs - t_fix; 
    myTrials(ExpTrial).response = kbnames(find(button_press == 1))
    RestrictKeysForKbCheck([44]);
elseif pace == 2
    t_now = GetSecs;
    while GetSecs < t_now + rsps_time
     RestrictKeysForKbCheck([30;31;32;33]);
    [pressed secs button_press c] = KbCheck(-1);
    if pressed == 1
    myTrials(ExpTrial).RT = secs - t_now; 
    myTrials(ExpTrial).response = kbnames(find(button_press == 1))
    RestrictKeysForKbCheck([44]);
    end
    end
end
%% scanner button reposne
% in a while loop when you want to collect the response
end 
%end
%%

%PressedKey = keyNames{find(keyCode,'1')};
%myTrials(ExpTrial).response = PressedKey;
%myTrials(ExpTrial).RT = t_pressed - t_presented;

% Wait for two secondsl
%WaitSecs(myTrials(ExpTrial).ISI); % screen is black for a period of time specified in myTrials.ISI
%ExpTrial = ExpTrial+1;
       
end
%% Final Save
expName = strcat(subjID, {'_Results_2run.mat'});
wrkspc = strcat(subjID, {'_workspace_2run.mat'});
save(expName{1,1},'myTrials');
save(wrkspc{1,1})
sca;
   

%writetable(struct2tabhle(myTrials),strcat(num2str(subjID), '.csv')) % after all loops are finished. Save myTrials as csv

% 
% t_now = GetSecs
% % while GetSecs < t_now + 10
% KbCheck
% end


% enabledKeyes = [30;31;32;33;44];
% responseKeyes = [30;31;32;33];
% spaceKey = [44];
% keyNames = KbName('KeyNames');
% RestrictKeysForKbCheck(enabledKeyes);
% 
% 
% %[secs, keyCode, deltaSecs] = KbWait([],[],[])
% %WaitSecs(1);KbWait([],[],[5])
% t_wait = GetSecs + 10
% % WaitSecs(1);KbWait([],[],[t_wait])
% % 
% % GetSecs - ans
% while GetSecs < GetSecs + 5
% [secs, keyCode, deltaSecs] = KbWait([],[],[]);
% end
% %WaitSecs(1);KbCheck
% WaitSecs(1)
% clear start; clear a
% start = GetSecs;
% while GetSecs < start + 5;
%     [a, RT,key] = KbCheck;
%     if a == 1
%         break
%     end
% end











