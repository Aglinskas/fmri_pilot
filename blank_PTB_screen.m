close all;
%clear all;
Screen('Preference', 'SkipSyncTests', 1); % disable if script crashes. 
sca; %
myTrials = func_myPracticeTrials(7,1); %ins = 2, gives english instructions, 1= italian
%% parameters
%subjID = input('input participant number ','s')
subjID = 'Silvia_9th_March'
numBlocks = 15; % how many blocks                                                                      1112 2224  3233               w22222222  1222  1112o run in experiment if 15 = all blocks will be presented in a random order, if less, a random subset of tasks will be selected
numTrials = length(myTrials) / 15; % number of faces to be shown per block
instruct_time = 4; %time in seconds that instructions are on the screen (if not self paced)  
t_fixCross = 2; % time that fix at nnmn sd ion cross is on the screen
StimTime = 0.5;
% time_to_respond = 1;  
rsps_time = 2.5 - StimTime;  
debug_mode = 0;
pace = 3;
encourage = 1;
do_MIA = 1 % Multi Item Arrangement launches after the script is done.
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
%% PsychDefaultSetup(2);
% Get the screen numbers
screens = Screen('Screens');

screenNumber = max(screens); % Draw to the external screen if avaliable
%screenNumber = min(screens); % always draws on the main screen 
%screenNumber = 0 % overwr      ite
% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;

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
%% scanner 
% Wait for first pulse


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
%         
%%







%% how to respond gif
% gif_dir = '/Users/aidas_el_cap/Desktop/00_fmri_pilot_final/Other/how_to_respond/';
% gif_fls = dir([gif_dir '*jpg'])
% [m1 m2 m3] = size(imread(fullfile(gif_dir,gif_fls(1).name)));
% gif_coords = [windowRect(3)-m2/1.5 windowRect(4)-m1/1.5 windowRect(3) windowRect(4)]
% ts = [2 2 1 0.15 0.15 0.15 0.15 0.15 0.15 0.15 1 0.15 0.15 0.15 0.15 0.15 0.15 0.15 1 0.15 0.15 0.15 0.15 0.15 0.15 0.15 1 0.15 0.15 0.15 0.15 0.15 0.15 0.15];
% 
% pressed = 0
% while pressed == 0
% for i = 1: length(gif_fls)
% [pressed secs button_press c] = KbCheck(-1);
% theImageLocation = fullfile(fullfile(gif_dir,gif_fls(i).name));
% theImage = imread(theImageLocation);
% imageTexture = Screen('MakeTexture', window, theImage);
% Screen('DrawTexture', window, imageTexture, [],gif_coords,0)
% Screen('Flip', window);
% [pressed secs button_press c] = KbCheck(-1);
% t = GetSecs;
% while GetSecs < t+ts(i) && pressed == 0
% [pressed secs button_press c] = KbCheck(-1);
% end
% end
% i = 1;
% end



%