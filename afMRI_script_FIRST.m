% Clear the workspace
close all;
%clear all;
% scanning=true;
scanning= false;
Screen('Preference', 'SkipSyncTests', 1); % disable if script crashes. 
sca

%% parameters
% to change instruction language,change variable 'ins' in edit func_testTrials
% to change between all faces and top40 faces, change exprm = 2; in edit func_getpic5
%ins_position = 2; % if 2,. instructins replace the fix cross, 1 is default     
%subjID = input('input participant number ','s')
%subjID = datestr(date)
subjID = 'S99'
numBlocks = 16; % how many blocks to run in experiment if 15 = all blocks will be presented in a random order, if less, a random subset of tasks will be selected
numTrials = 40; % number of faces to be shown per block
instruct_time = 6; %time in seconds that instructions are on the screen (if not self paced)  
t_fixCross = 4; % time that fixation cross is on the screen
StimTime = 0.5;
time_to_respond = 2.5 - StimTime;
fmriblocks = 80;
fmriTrials = 8;
debug_mode = 0;
TR = 2.5;
%% load random pics for the experiment
myTrials = func_testTrials; %getTrials

%load('test_myTrials.mat');
if debug_mode
  time_to_respond = 0.1;
    instruct_time = 5; %time in seconds that instructions are on the screen (if not self paced)  
t_fixCross = 0.1; % time that fixation cross is on the screen
StimTime = 0.1;
end
    
%myTrials = func_getmyTrials2(numBlocks, numTrials,Task, time_to_respond, fmriblocks, fmriTrials,control_task, monuments_task);
%myTrials2 = func_getmyTrials2(numBlocks, numTrials, Task, instruct_time, t_fixCross, StimTime, time_to_respond, fmriblocks, fmriTrials);
%% Set up KbCheck and keyboard related things
enabledKeyes = [30;31;32;33;44];
responseKeyes = [30;31;32;33];
spaceKey = [44];
keyNames = KbName('KeyNames');
RestrictKeysForKbCheck(enabledKeyes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PTB CODE

% set up defaults
%PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');


screenNumber = max(screens); % Draw to the external screen if avaliable
%screenNumber = min(screens); % always draws on the main screen 


% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;

%% set up sizes
%[xCenter, yCenter] = RectCenter(windowRect);

% Open an on screen window
%Takes over the screen
%[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
%% SLF try
[window, windowRect] = Screen(screenNumber, 'openwindow',[128 128 128]);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%theImageLocation = [PsychtoolboxRoot 'PsychDemos' filesep...
 %   'AlphaImageDemo' filesep 'konijntjes1024x768.jpg'];
%theImage = imread(theImageLocation);
%% SLF
%rng(GetSecs);
% %randTask = randperm(length(Task)); %this is where task vector is randomized
% randTask = 1 : 15;
% % Prefill task names so control condition doesnt crash
% for block_prefill = 1 : numBlocks
% for line_prefill = block_prefill * numTrials - (numTrials - 1) : block_prefill * numTrials;
%     myTrials(line_prefill).TaskName = Task{randTask(block_prefill),1};
%     myTrials(line_prefill).taskIntruct = Task{randTask(block_prefill),2};
% end
% end
% % Sort control task and monunments task mess here.
% %% Code for the Control Task [Randomly repeats some of the pictures]
% % n_rep has been moved to top of code, next to the parameters
% c_block = find([myTrials.blockNum] == 14);
% c_block(length(c_block))
% %if CurrentTask{1,1}{1,1} == control_task;
% r_cb = Shuffle(c_block);  
%     for i_OW = 1 : n_rep %repeats some of the faces
%         myTrials(r_cb(i_OW) + 1).filenames = myTrials(r_cb(i_OW)).filenames
%     end
% 
% % end of Control Task code
% 
% %% Monuments task code 
% m_block = find([myTrials.blockNum] == 15);
% for i = 1 : numTrials
%     myTrials(m_block(1) + i - 1).filenames = myTrials(i).monuments;
% end
% m_block(length(m_block)) = []
% %if CurrentTask{1,1}{1,1} == control_task;
% r_cm = Shuffle(m_block);  
%     for i_OM = 1 : n_rep %repeats some of the faces
%         myTrials(r_cm(i_OM) + 1).filenames = myTrials(r_cm(i_OM)).filenames
%     end
% % fmriblocks
% %prep = length(myTrials) / fmriblocks
% 
% 
% %monuments_task = Task{15,1}
% %n_rep = ceil(numTrials / 3); 
% % c_task_monuments = []; %if CurrentTask{1,1}{1,1} == control_task; if
% strcmp(CurrentTask{1,1}{1,1}, monuments_task) == 1
%     % code to put monuments in the right place try cc_trial =
%     length([myTrials.time_presented]); catch cc_trial = 0 end for m_i = 1
%     : numTrials
%         myTrials(cc_trial + m_i).filenames =  myTrials(m_i).monuments
%     end % Code below repeats some of the pictures total_lines =
%     length(myTrials); for b_line = 1 : total_lines
%         if strcmp(myTrials(b_line).TaskName,monuments_task) == 1
%             
%             c_task_monuments(length(c_task_monuments) + 1) = b_line
%             
%         end
%     end c_task_monuments(length(c_task_monuments)) = []; % delete the
%     last item (because the last pic cant be repeated, it would end up
%     being in the next trials) Shuffled_monuments =
%     Shuffle(c_task_monuments);
%     
%     for i_OWm = 1 : n_rep %repeats some of the faces
%         myTrials(Shuffled_monuments(i_OWm) + 1).filenames =
%         myTrials(Shuffled_monuments(i_OWm)).filenames
%     end
% end
% end of Monuments code
%rf_block = ;
% rf_block = 1:75;
%% set up corners
theImageLocation = myTrials(1).filepath; % gets picture from myTrials
theImage = imread(theImageLocation);
[s1, s2, s3] = size(theImage);
e1 = xCenter - s2/2; % right edge of picture
e2 = xCenter + s2/2; % left edgle of picture
e3 = yCenter - s1/2 - 150; % top of picture
e4 = yCenter + s1/2 - 150; % bottom of picture
%%
%% scanner 
% Wait for first pulse
if scanning
    try 
    a=instrfind('Tag', 'SerialResponseBox');fclose(a);
end
    Cfg.ScannerSynchShowDefaultMessage = 1;
    Cfg.synchToScannerPort = 'SERIAL';
    Cfg.responseDevice = 'LUMINASERIAL';
    Cfg.serialPortName = 'COM1'
    Cfg = InitResponseDevice(Cfg); %LUMINA box: ASCII + highest baud rate (115200)

    DrawFormattedText (window, 'WAITING FOR THE SCANNER','center','center');
    Screen('flip',window);
    ASF_WaitForScannerSynch([], Cfg);
    firstPulse=GetSecs;
    Screen('flip',window);
end
%% abandoning
% 
% Cfg.scannerSynchTimeOutMs = inf
% hSerial=Cfg.hardware.serial.oSerial;
% timeoutMilliSeconds=Cfg.scannerSynchTimeOutMs;
%  
%  
% contflag = 1;
% tStart = GetSecs;
% while contflag
%     if hSerial.BytesAvailable
%         sbuttons = str2num(fscanf(hSerial)); %#ok<ST2NM>
%         %CLEAN UP IN CASE MONKEY GOES WILD
%         while hSerial.BytesAvailable
%             junk = fscanf(hSerial); % #ok<NASGU>
%         end
%         if sbuttons == 5
%             contflag = 0;
%         end
%     else
%         %NOTHING AVAILABLE, CHECK TIMEOUT
%         if (GetSecs - tStart) > timeoutMilliSeconds/1000
%             return;
%         end
%     end
% end
%%
ExpStart = GetSecs;
 

%%  BLOCKS here
% Beginning of a block, task instructions, fixation cross
for expBlock = 1 : fmriblocks
    %% Sets up the task and prompts
    save(subjID,'myTrials')
    if expBlock == 17
        save(subjID)
        break
    end
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
   taskName = myTrials(expBlock * fmriTrials - fmriTrials + 1).TaskName;
   taskIntruct = myTrials(expBlock * fmriTrials - fmriTrials + 1).taskIntruct;
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
DrawFormattedText(window, taskName, 'center', 'center', white);
% Task instructions
Screen('TextSize', window, 24);
Screen('TextFont', window, 'Courier');
%lower_third = screenYpixels / 3 * 2 + 50;
lower_third = 600;
cCenter = xCenter - length(taskIntruct); %change
%DrawFormattedText(window, taskIntruct, 'center', lower_third, white); % %centers nicely - not justified
DrawFormattedText(window, taskIntruct, cCenter, lower_third, white);

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
WaitSecs(instruct_time); % length of time that task and instructions are on the screen
%end
fixCrossDimPix = 40;

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

WaitSecs(t_fixCross); % Time that fixation cross is on the screen
%
%a_t = ceil(GetSecs - ExpStart);%
a_t = ceil((GetSecs - ExpStart)/TR)*TR;
while GetSecs - ExpStart < a_t
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EXPERIMENTAL RUN. 1 loop of code below = 1 trial
%fmriblocks
  % specify number of iterations
%for numBlocks * numTrials - 4 = 1 : numBlocks * numTrials
for ExpTrial = expBlock * fmriTrials - (fmriTrials - 1) : expBlock * fmriTrials; % code that matches blocks, trials, and trials per block
    %for ExpTrial = 1 : fmriTrials
    pressed=0;
theImageLocation = myTrials(ExpTrial).filepath; % gets picture from myTrials
theImage = imread(theImageLocation);
% time_to_respond = myTrials(ExpTrial).time_to_respond;
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
  
 e1 = xCenter - s2/2;
 e2 = xCenter + s2/2;
 e3 = yCenter - s1/2 - 150;
 e4 = yCenter + s1/2 - 150;
 
 
Screen('DrawTexture', window, imageTexture, [], [e1 e3 e2 e4],0);                                     
%Screen('DrawTexture', window, imageTexture, [], [e1 - 25 e3 - 33 e2 + 25 e4 + 25],0);                                        
%Screen('DrawTexture', window, imagecTexture, [], [570 150 870 550],0); % only works on 1440 * 900 screen 
%570 870 250 650
%Screen('DrawTexture', window, imageTexture, [255 255 0], [255 255 0], 0);%
lower_third = 600;

%DrawFormattedText(window, taskIntruct, 'left', cCenter, white, [],[],[],[],[],[600 600 840 700]); % instructions below the image
%DrawFormattedText(window, taskIntruct, cCenter, lower_third, white); % instructions below the image
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
%WaitSecs(myTrials(ExpTrial).time_to_respond); %stimulus is on the screen for a time period specified in myTrials
WaitSecs(StimTime);
% Now fill the screen GREY
Screen('FillRect', window, grey); % screen  is now blanc
Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter e4 - 220]); % fix cross after face
% DrawFormattedText(window, taskIntruct, cCenter, lower_third, white); % instructions below the fix cross
%DrawFormattedText(window, taskIntruct, cCenter, 350, white)
% Flip to the screen
Screen('Flip', window); % fix cross on screen waiting for response
%[secs, keyCode, deltaSecs] = KbWait;
%WaitSecs(time_to_respond)
%GetSecs - ExpStart < ceil(time_to_respond+t_presented + 0.5 - ExpStart)
while GetSecs<time_to_respond+t_presented + 0.5 %0.5 offset seems important, dunno why tho
%% scanner button reposne
% in a while loop when you want to collect the response
if scanning == true
if Cfg.hardware.serial.oSerial.BytesAvailable
    sbuttons = str2num(fscanf(Cfg.hardware.serial.oSerial)); %
    if pressed==0
        switch sbuttons
            case {1, 2, 3, 4}
RT = GetSecs-t_presented;
                pressed = 1;
                response = sbuttons;
   myTrials(ExpTrial).resp=response;
        %disp([int2str(response) ', ' num2str(RT,4)])
        myTrials(ExpTrial).RT=RT;
        end
    end
end 
end
if scanning == false 
        [a, RT,key] = KbCheck;
        if a == 1;
        myTrials(ExpTrial).response = keyNames{find(key,'1')};
        myTrials(ExpTrial).RT = RT - t_presented;
        %myTrials(ExpTrial).RT
        clear a;clear key; clear RT;
        end
end
end
%myTrials(ExpTrial).duration = GetSecs - t_presented;
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
%end
%writetable(struct2tabhle(myTrials),strcat(num2str(subjID), '.csv')) % after all loops are finished. Save myTrials as csv
expName = strcat(subjID, {'_Results.mat'});
wrkspc = strcat(subjID, {'_workspace.mat'});
save(expName{1,1},'myTrials');
save(wrkspc{1,1})
% Clear the screen
sca;

%to name the variables:
% for i = 1 : length([myTrials])
%    a = strsplit(myTrials(i).filepath, '/');
%     myTrials(i).name = a{2};
%     myTrials(i).stimKind = a{1};
% end


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