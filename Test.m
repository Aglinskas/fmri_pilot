% Clear the workspace
close all;
%clear all;
Screen('Preference', 'SkipSyncTests', 1); % disable if script crashes. 
sca;   
myTrials = func_myPracticeTrials(7,1); %ins = 2, gives english instructions, 1= italian
%% parameters
%subjID = input('input participant number ','s')

subjID = datestr(date)
numBlocks = 15; % how many blocks                                                                      1112 2224  3233               w22222222  1222  1112o run in experiment if 15 = all blocks will be presented in a random order, if less, a random subset of tasks will be selected
numTrials = length(myTrials) / 15; % number of faces to be shown per block
instruct_time = 4; %time in seconds that instructions are on the screen (if not self paced)  
t_fixCross = 2; % time that fix at nnmn sd ion cross is on the screen
StimTime = 0.5;
% time_to_respond = 1;
rsps_time = 4 - StimTime;  
debug_mode = 0;
pace = 3;
encourage = 1;

%% load random pics for the experiment
 %getTrials
%load('test_myTrials.mat');
if debug_mode
    for i = 1 : length(myTrials);
        myTrials(i).time_to_respond = 0.1;
    end
    instruct_time = 5; %time in seconds that instructions are on the screen (if not self paced)  
t_fixCross = 0.1; % time that fixation cross is on the screen
StimTime = 0.1;
end

% For KbCheck
KbName('UnifyKeyNames');
kbnames = KbName('KeyNames');
RestrictKeysForKbCheck([44]);
%myTrials = func_getmyTrials2(numBlocks, numTrials,Task, time_to_respond, fmriblocks, fmriTrials,control_task, monuments_task);
%myTrials2 = func_getmyTrials2(numBlocks, numTrials, Task, instruct_time, t_fixCross, StimTime, time_to_respond, fmriblocks, fmriTrials);
%% Set up KbCheck and keyboard related things
% enabledKeyes = [30;31;32;33;44];
% responseKeyes = [30;31;32;33];
% spaceKey = [44];
% keyNames = KbName('KeyNames');
% RestrictKeysForKbCheck(enabledKeyes);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PTB CODE
% set up defaults
% PsychDefaultSetup(2);
% Get the screen numbers
screens = Screen('Screens');

screenNumber = max(screens); % Draw to the external screen if avaliable
%screenNumber = min(screens); % Draws on the main screen

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;

%Open an on screen window
%Takes over the screen
%[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
%
[window, windowRect] = Screen(screenNumber, 'openwindow',[128 128 128]);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%% Instructions

instruction_dir = 'Pilot_pics/';
ext = '*jpeg';
nslides = length(dir([instruction_dir ext]));
slides_list = dir([instruction_dir ext]);

n_intro_pics = length(slides_list) - 15 - 1;
got_it_slide = length(slides_list) - 15;
question_slides = got_it_slide+1: nslides;
%intro_pics = dir([i  nstruction_dir intro_prefix ext])
 intro_pics = slides_list;
 intro_pics = intro_pics(1:n_intro_pics);
for slide = 1:length(intro_pics)
theImageLocation = fullfile(instruction_dir,intro_pics(slide).name);
theImage = imread(theImageLocation);
imageTexture = Screen('MakeTexture', window, theImage);
Screen('DrawTexture', window, imageTexture, [], windowRect,0)
Screen('Flip', window);
KbWait(-1)
WaitSecs(0.1)
end

%%
ExpStart = GetSecs;
 
%%  BLOCKS here
% Beginning of a block, task instructions, fixation cross
for expBlock = 1 : numBlocks
    %% each block starts with an intro slide:
    theImageLocation = fullfile(instruction_dir,slides_list(question_slides(expBlock)).name);
    theImage = imread(theImageLocation);
    imageTexture = Screen('MakeTexture', window, theImage);
Screen('DrawTexture', window, imageTexture, [], windowRect,0)
Screen('Flip', window);
KbWait(-1)
WaitSecs(0.1)

theImageLocation = fullfile(instruction_dir,slides_list(got_it_slide).name)
    theImage = imread(theImageLocation);
    imageTexture = Screen('MakeTexture', window, theImage);
Screen('DrawTexture', window, imageTexture, [], windowRect,0)
Screen('Flip', window);
KbWait(-1)
WaitSecs(0.1)
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
%DrawFormattedText(window, taskName, 'center', 'center', white);
DrawFormattedText(window, taskName, 'center', 350, white); %shift up
% Task instructions
Screen('TextSize', window, 24);
Screen('TextFont', window, 'Courier');
%lower_third = screenYpixels / 3 * 2 + 50;
lower_third = 600;
cCenter = xCenter - length(taskIntruct); %change
%DrawFormattedText(window, taskIntruct, 'center', lower_third, white); % %centers nicely - not justified
DrawFormattedText(window, taskIntruct, cCenter, 'center', white); %shift up
%DrawFormattedText(window, taskIntruct, cCenter, lower_third, white);

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
    pause
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
    pause
elseif pace == 3
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
if myTrials(ExpTrial).blockNum == 14 && myTrials(ExpTrial).trialnum == 1 || myTrials(ExpTrial).blockNum == 15 && myTrials(ExpTrial).trialnum == 1
    Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter e4 - 220])
    %Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter 350]);
else
DrawFormattedText(window, taskIntruct, cCenter, 350, white);
end%test
% Flip to the screen 
Screen('Flip', window);% fix cross on screen waiting for response
t_fix = GetSecs
%[secs, keyCode, deltaSecs] = KbWait;
%WaitSecs(time_to_respond)

if pace == 1
    pause
elseif pace == 3 % 
    %For the control task, fix cross instead of the confusing prompt
    if myTrials(ExpTrial).blockNum == 14 && myTrials(ExpTrial).trialnum == 1 || myTrials(ExpTrial).blockNum == 15 && myTrials(ExpTrial).trialnum == 1
            WaitSecs(1);
   elseif myTrials(ExpTrial).trialnum <= 3 % for the first three practise trials, KBWAIT
    RestrictKeysForKbCheck([30;31;32;33]);
   [secs button_press c] = KbWait(-1);
    myTrials(ExpTrial).RT = secs - t_fix; 
    myTrials(ExpTrial).response = kbnames(find(button_press == 1));
    RestrictKeysForKbCheck([44]);
    elseif myTrials(ExpTrial).trialnum > 3 % after third one, impose time limit
        isDown = 0;
      while GetSecs < t_fix + rsps_time && isDown == 0 % if they press the button before the time limit, screw it, move on. 
    RestrictKeysForKbCheck([30;31;32;33]);
   [isDown secs button_press c] = KbCheck(-1);
    myTrials(ExpTrial).RT = secs - t_fix; 
    myTrials(ExpTrial).response = kbnames(find(button_press == 1));
    RestrictKeysForKbCheck([44]);
      end
    end
end
end 
%end
%%

%PressedKey = keyNames{find(keyCode,'1')};
%myTrials(ExpTrial).response = PressedKey;
%myTrials(ExpTrial).RT = t_pressed - t_presented;

% Wait for two secondsl
%WaitSecs(myTrials(ExpTrial).ISI); % screen is black for a period of time specified in myTrials.ISI
%ExpTrial = ExpTrial+1;
       
end % End of the self-paced portion of the experiment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%END OF SELF PACED PORTION OF THE EXPERIMENT%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% transition screen to test
myTrials_selfPaced = myTrials;
text = 'Great Job! The Task should be clear by now\nFor the last section we move to a timed portion of this experiment!\nPress SPACE to start'
Screen('TextSize', window, 28);
Screen('TextFont', window, 'Courier');
%taskName = 'Hello, this is sample text'
DrawFormattedText(window, text, 'center', 'center', white);
Screen('Flip', window);
RestrictKeysForKbCheck([44]);
KbWait(-1)
%% intermediate save
expName = strcat(subjID, {'_Results_SLF_PACE.mat'});
wrkspc = strcat(subjID, {'_workspace_SLF_PACE.mat'});
save(expName{1,1},'myTrials');
save(wrkspc{1,1})
%% phase 2: timed test phase 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pace = 2;
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
    pause
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
    pause
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
    pause
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
   
%% Comments after cleanup, too attached to delete 'em :(
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
% endsca


% 1 = self paced, 2 = timed, 3 = newPractice
%% for debbuging 
% numBlocks = 13; % how many blocks to run    n      mm      in experiment if 15 = all blocks will be presented in a random order, if less, a random subset of tasks will be selected
% numTrials = 25; % number of faces to be shown per block
% instruct_time = 1; %time in seconds that instructions are on the screen (if not self paced)  
% t_fixCross = 0.5; % time that fixation cross is on the screen
% StimTime = 0.5;
% time_to_respond = 0.5;
% %% numBlocks * numTrials /
% fmriblocks = 25;
% fmriTrials = 13;
%%%%%%%%%%%%%%%%%%%%%%%%%
%%

% control and monument tasks defined below
%% Tasks
% Task{1,1} = 'Di che colore sono i capelli di questa persona?'; %Control or baseline
% Task{1,2} = '1 = Biondi\n2 = Scuri\n3 = Altro\n4 = La persona ? calva';
% Task{2,1} = 'Quanti anni avevi quando hai sentito parlare\ndi questa persona per la prima volta?'; %episodic
% Task{2,2} = '1 = Meno di 7 anni\n2 = Tra 8 e 17\n3 = Tra 18 ed ora\n4 = Non ne ho mai sentito parlare';
% Task{3,1} = 'Quanto ritieni sia fisicamente attraente questa persona?';
% Task{3,2} = '1 = Molto attraente\n2 = Attraente\n3 = Nella media\n4 = Non proprio attraente';
% Task{4,1} = 'Quanto ritieni sia amichevole questa persona?';
% Task{4,2} = '1 = Molto amichevole\n2 = Amichevole\n3 = Non proprio amichevole\n4 = Non mi avvicinerei';
% Task{5,1} = 'Quanto ritieni sia affidabile questa persona?';
% Task{5,2} = '1 = Molto affidabile\n2 = Abbastanza affidabile\n3 = Non proprio affidabile\n4 = Assolutamente non affidabile';
% Task{6,1} = 'Associ questa persona ad emozioni pi? positive o pi? negative?';
% Task{6,2} = '1 = Emozioni molto positive\n2 = Emozioni in qualche modo positive\n3 = Emozioni in qualche modo negative\n4 = Emozioni negative';
% Task{7,1} = 'Hai mai visto questa persona prima?/Riconosci il suo volto?'; % semantic access 1
% Task{7,2} = '1 = S?\n2 = No, mai vista prima';
% Task{8,1} = 'Se ti chiedessero di scrivere un tema\nsu questa persona, quanto potresti scrivere?';%semantic access 2
% Task{8,2} = '1 = Una pagina\n2 = Un paragrafo\n3 = Una frase\n4 = Niente';
% Task{9,1} = 'Quanto ? comune il nome proprio di questa persona?';
% Task{9,2} = '1 = Molto comune\n2 = Non molto comune\n3 = E? l?unica persona che conosco con quel nome\n4 = Non conosco il nome di questa persona';
% Task{10,1} = 'Quanti fatti riesci a ricordare di questa persona?';
% Task{10,2} = '1 = Pi? di 5 compreso il suo nome\n2 = Quattro o cinque\n3 = Due o tre\n4 = Non conosco questa persona';
% Task{11,1} = 'Chi ? questa persona?';
% Task{11,2} = '1 = Personaggio televisivo/Attore\n2 = Cantante/Musicista\n3 = Politico/Uomo d?affari\n4 = Altro/Non so';
% Task{12,1} = 'Quanto ? distintivo e distinguibile il volto di questa persona?';
% Task{12,2} = '1 = Non lo confonderei con nessun altro\n2 = Abbastanza distintivo\n3 = Confondibile\n4 = Potrebbe essere tranquillamente confuso\n    con qualcun altro';
% Task{13,1} = 'Considerate tutte le informazioni a tua disposizione\n(se conosci o meno questa persona);\nQuanto ritieni sia brava o cattiva questa persona?';
% Task{13,2} = '1 = Brava persona\n2 = Sopra la media / una persona per bene\n3 = Sotto la media/non proprio una persona per bene\n4 = Brutta persona';
% Task{14,1} = 'E? lo stesso volto rispetto al precedente?'; %control
% Task{14,2} = '1 = Volto diverso\n2 = Stesso volto';
% Task{15,1} = 'Is this the same monument as the one before?';
% Task{15,2} = '1 = yes, same\n2 = no, different';

% control_task = 14; % which task is control task?
% monuments_task = 15;
% 
% n_rep = ceil(numTrials / 3); % how many repetitions in the control task?

%Task{1,1} = 'What colour is this persons hair?'; %Control or baseline
%Task{1,2} = '1 = Blond\n2 = Dark\n3 = Other\n4 = Person has no hair';
%Task{2,1} = 'How old were you when you first heard of this person?'; %episodic
%Task{2,2} = '1 = Less than 7 years old\n2 = Between 8 and 17\n3 = Between 18 and now\n4 = Never seen the person before';
%Task{3,1} = 'How attractive do you find this persons face?';
%Task{3,2} = '1 = Very attractive\n2 = Attractive\n3 = Average\n4 = Not really attractive';
%Task{4,1} = 'How friendly is this person?';
%Task{4,2} = '1 = Very friendly\n2 = Friendly\n3 = Not really friendly\n4 = Would not approach';
%Task{5,1} = 'How trustworthy is this person?';
%Task{5,2} = '1 = very trustworthy\n2 = quite trustworthy\n3 = not really trustworthy\n4 = not at all trustworthy';
%Task{6,1} = 'Do you associate this person more with positive or negative emotions?';
%Task{6,2} = '1 = Very postive emotions\n2 = somewhat positive emotions\n3 = somewhat negative emotions\n4 = negative emotions';
%Task{7,1} = 'Have you seen this person before'; % semantic access 1
%Task{7,2} = '1 = xYes, I have\n2 = No, never seen them before';
%Task{8,1} = 'If asked to write an essay about this person\nHow much could you write about them?';%semantic access 2
%Task{8,2} = '1 = Page\n2 = Paragraph\n3 = Sentence\n4 = None';
%Task{9,1} = 'How common is this persons name?'
%Task{9,2} = '1 = Very common\n2 = Not very common\n3 = They are the only person I know with that name\n4 = I dont know this persons name'
%Task{10,1} = 'How many facts can you remember about this person'
%Task{10,2} = '1 = More than 5 as well as their name\n2 = Four or Five\n3 = Two or three\n4 = Dont know the person'
%Task{11,1} = 'Who is this person?'
%Task{11,2} = '1 = TV/Movie persona\n2 = Singer/Musician\n3 = Politian/Businessman\n4 = Other/Dont know'
%Task{12,1} = 'How distinct / distinguishable is this persons face to you?'
%Task{12,2} = '1 = Would not confuse it with anyone else\n2 = Quite distinct\n3 = Confusable\n4 = Would easily confuse with someone else'
%Task{13,1} = 'Consider all the information available to you (whether you know the person or not);\nHow good/bad as a person do you think they are?'
%Task{13,2} = '1 = Good person\n2 = Above average / Decent person\n3 = Below average / Not a good person\n4 = Bad person'
%Task{14,1} = 'How old were you when you first heard of this person?'; %episodic
%Task{14,2} = '1 = Ive known them for as long as I can remember\n2 = I was in my teenage years\n3 = As an adult\n4 = Ive Never seen the person before';
%Task{15,1} = 'Is this the same face as the one before?' %control
%Task{15,2} = '1 = Different face\n2 = Same face
