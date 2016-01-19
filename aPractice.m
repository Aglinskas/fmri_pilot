% Clear the workspace
close all;
%clear all;

Screen('Preference', 'SkipSyncTests', 1); % disable if script crashes. 
myTrials = func_myPracticeTrials;
%% parameters
%subjID = input('input participant number ','s')
subjID = datestr(date)
numBlocks = 15; % how many blocks to run in experiment if 15 = all blocks will be presented in a random order, if less, a random subset of tasks will be selected
numTrials = length(myTrials) / 15; % number of faces to be shown per block
instruct_time = 4; %time in seconds that instructions are on the screen (if not self paced)  
StimTime = 0.5;
debug_mode = 0;
%1 = self paced, 2 = timed
%% for debbuging 
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
% Task{1,2} = '1 = Biondi\n2 = Scuri\n3 = Altro\n4 = La persona è calva';
% Task{2,1} = 'Quanti anni avevi quando hai sentito parlare\ndi questa persona per la prima volta?'; %episodic
% Task{2,2} = '1 = Meno di 7 anni\n2 = Tra 8 e 17\n3 = Tra 18 ed ora\n4 = Non ne ho mai sentito parlare';
% Task{3,1} = 'Quanto ritieni sia fisicamente attraente questa persona?';
% Task{3,2} = '1 = Molto attraente\n2 = Attraente\n3 = Nella media\n4 = Non proprio attraente';
% Task{4,1} = 'Quanto ritieni sia amichevole questa persona?';
% Task{4,2} = '1 = Molto amichevole\n2 = Amichevole\n3 = Non proprio amichevole\n4 = Non mi avvicinerei';
% Task{5,1} = 'Quanto ritieni sia affidabile questa persona?';
% Task{5,2} = '1 = Molto affidabile\n2 = Abbastanza affidabile\n3 = Non proprio affidabile\n4 = Assolutamente non affidabile';
% Task{6,1} = 'Associ questa persona ad emozioni più positive o più negative?';
% Task{6,2} = '1 = Emozioni molto positive\n2 = Emozioni in qualche modo positive\n3 = Emozioni in qualche modo negative\n4 = Emozioni negative';
% Task{7,1} = 'Hai mai visto questa persona prima?/Riconosci il suo volto?'; % semantic access 1
% Task{7,2} = '1 = Sì\n2 = No, mai vista prima';
% Task{8,1} = 'Se ti chiedessero di scrivere un tema\nsu questa persona, quanto potresti scrivere?';%semantic access 2
% Task{8,2} = '1 = Una pagina\n2 = Un paragrafo\n3 = Una frase\n4 = Niente';
% Task{9,1} = 'Quanto è comune il nome proprio di questa persona?';
% Task{9,2} = '1 = Molto comune\n2 = Non molto comune\n3 = E? l?unica persona che conosco con quel nome\n4 = Non conosco il nome di questa persona';
% Task{10,1} = 'Quanti fatti riesci a ricordare di questa persona?';
% Task{10,2} = '1 = Più di 5 compreso il suo nome\n2 = Quattro o cinque\n3 = Due o tre\n4 = Non conosco questa persona';
% Task{11,1} = 'Chi è questa persona?';
% Task{11,2} = '1 = Personaggio televisivo/Attore\n2 = Cantante/Musicista\n3 = Politico/Uomo d?affari\n4 = Altro/Non so';
% Task{12,1} = 'Quanto è distintivo e distinguibile il volto di questa persona?';
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
%Task{7,2} = '1 = Yes, I have\n2 = No, never seen them before';
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
    
%myTrials = func_getmyTrials2(numBlocks, numTrials,Task, time_to_respond, fmriblocks, fmriTrials,control_task, monuments_task);
%myTrials2 = func_getmyTrials2(numBlocks, numTrials, Task, instruct_time, t_fixCross, StimTime, time_to_respond, fmriblocks, fmriTrials);
%% Set up KbCheck and keyboard related things

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PTB CODE

% set up defaults
%% PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');


screenNumber = max(screens); % Draw to the external screen if avaliable
%screenNumber = min(screens); % always draws on the main screen 


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
%         end
%     end
% end
%%
ExpStart = GetSecs;
 
%%  BLOCKS here
% Beginning of a block, task instructions, fixation cross
for expBlock = 1 : numBlocks
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
if pace == 1
else
    WaitSecs(instruct_time);
end

    
 % length of time that task and instructions are on the screen
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
Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter 350]); % change 2350 is the y coord
% fix cross %xcros
%[570 150 870 550]
% Flip to the screen
Screen('Flip', window);
if pace == 1
else
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
time_to_respond = myTrials(ExpTrial).time_to_respond;
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
%WaitSecs(myTrials(ExpTrial).time_to_respond); %stimulus is on the screen for a time period specified in myTrials
WaitSecs(StimTime);
% Now fill the screen GREY
Screen('FillRect', window, grey); % screen  is now blanc
Screen('DrawLines', window, allCoords,lineWidthPix, white, [xCenter 350]); % fix cross after face
DrawFormattedText(window, taskIntruct, cCenter, lower_third, white); % instructions below the fix cross
% Flip to the screen
Screen('Flip', window); % fix cross on screen waiting for response
%[secs, keyCode, deltaSecs] = KbWait;
%WaitSecs(time_to_respond)

if pace == 1
else WaitSecs(time_to_respond)
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
%end
%writetable(struct2tabhle(myTrials),strcat(num2str(subjID), '.csv')) % after all loops are finished. Save myTrials as csv
expName = strcat(subjID, {'_Results.mat'});
wrkspc = strcat(subjID, {'_workspace.mat'});
save(expName{1,1},'myTrials');
save(wrkspc{1,1})
% Clear the screen
sca;

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