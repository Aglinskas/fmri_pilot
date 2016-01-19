%source(1).filepaths{1,1} %surce(i) name counter, filepaths{i,1} picture counter
%myTrials = source

function myTrials = loc_func_testTrials;

%ISI = 3;
%time_to_respond = 0.7;
monuments = 'Monuments/*.jpg';% directory of the faces folder
monuments2 = 'Monuments';
names = dir(monuments);
names = names(arrayfun(@(x) ~strcmp(x.name(1),'.'),names));

source = loc_func_getpic5();
%rng((rand * GetSecs));
%% parameters, fix to feed to the func
numTrials = 80;
numBlocks = 2;
num_fmriTrials = 16; % has to divide evenly by numTrials
num_fmriBlocks = 10;% total number of trials / fmriTrials
num_fmriRuns = 1 ;
sort = 1; % 1 myTrials in fmri sequence puts, elses
%control_task = Task{14,1};% which task is control task?
%monuments_task = Task{15,1};
n_rep = ceil(numTrials / 3);

Task{1,1} = 'E lo stesso volto rispetto al precedente?'; %control
Task{1,2} = '1 = Volto diverso\n2 = Stesso volto';
Task{2,1} = 'E lo stesso monumento del precedente?';
Task{2,2} = '1 = Monumento diverso\n2 = Stesso monumento';
%%
%% Task names and task instructions
randTask = 1 : length(Task);
%randTask = randperm(length(Task));
for b_count = 1 : numBlocks
for l_count = b_count * numTrials - (numTrials - 1) : b_count * numTrials;
    myTrials(l_count).TaskName = Task{randTask(b_count),1};
    myTrials(l_count).taskIntruct = Task{randTask(b_count),2};
end
end

start_line = 1;
for block_counter = 1: numBlocks

    pres_order = randperm(length(source)); %shuffles presentation order 
   
   for trial = start_line : start_line + numTrials - 1
       name = source(pres_order(trial)).name;
       unshown_pics = find(source(pres_order(trial)).imShow == 0);
       
      if isempty(unshown_pics) == 1;
         source(pres_order(trial)).imShow = zeros(1,length(source(pres_order(trial)).imShow));
          unshown_pics = find(source(pres_order(trial)).imShow == 0);
       end
       
       select_pic_to_show_ind = randi(length(unshown_pics),1);
       select_pic_to_show = unshown_pics(select_pic_to_show_ind);
       pic_to_show = source(pres_order(trial)).filepaths{select_pic_to_show,1};
       
       write_line = trial + block_counter * numTrials - numTrials;
       myTrials(write_line).filepath = pic_to_show{1,1};
       source(pres_order(trial)).imShow(select_pic_to_show) = 1;
       myTrials(write_line).blockNum = block_counter;
       myTrials(write_line).trialnum = trial;
   end
end



%function a = func_getmon();
%numTrials = 40;
%a = struct;

for mb = 2
mon_task_index = find([myTrials.blockNum] == mb);
norm_ll = 1 : numTrials;
s_ll = Shuffle(norm_ll);
for ll = 1 : numTrials;
% a(ll).name = names(ll).name;
myTrials(mon_task_index(ll)).filepath = strcat(monuments2, '/',names(s_ll(ll)).name);
end
end




    % Adds repetition for control and monuments tasks
   %% Code for the Control Task [Randomly repeats some of the pictures]
% n_rep has been moved to top of code, next to the parameters
c_block = find([myTrials.blockNum] == 1);
c_block(length(c_block)) = [];
%if CurrentTask{1,1}{1,1} == control_task;
r_cb = Shuffle(c_block); 
    for i_OW = 1 : n_rep; %repeats some of the faces
        myTrials(r_cb(i_OW) + 1).filepath = myTrials(r_cb(i_OW)).filepath;
    end

% end of Control Task code

%% Monuments task code
for mb = 2
m_block = find([myTrials.blockNum] == mb);
% for i = 1 : numTrials
%     myTrials(m_block(1) + i - 1).filenames = myTrials(i).monuments;
% end
m_block(length(m_block)) = [];
%if CurrentTask{1,1}{1,1} == control_task;
r_cm = Shuffle(m_block);  
    for i_OM = 1 : n_rep %repeats some of the faces
        myTrials(r_cm(i_OM) + 1).filepath = myTrials(r_cm(i_OM)).filepath;
    end
end

% fmriblocks
% 


%%

% for i = 1 : length(myTrials);
% %myTrials(i).ISI = ISI;
% myTrials(i).time_to_respond = time_to_respond;
% end

% %% Skips first trials of control tasks
% % for monuments task
%  mon_counter1 = find([myTrials.blockNum] == 15);
%  mon_counter2 = [myTrials(mon_counter1(1):mon_counter1(length(mon_counter1))).fmriblock];
%  umf = unique(mon_counter2); % fmri blocks for the monuments task
% 
%  for i = 1 : length(umf);
%   mon_counter = find ([myTrials.fmriblock] == umf(i));
%  %myTrials(mon_counter(1)).ISI = 0.3;
%  myTrials(mon_counter(1)).time_to_respond = 0.3;
%  end
%  
%  face_counter1 = find([myTrials.blockNum] == 14);
%  face_counter2 = [myTrials(face_counter1(1):face_counter1(length(face_counter1))).fmriblock];
%  uff = unique(face_counter2); % fmri blocks for the monuments task
% 
%  for i = 1 : length(uff);
%   face_counter = find ([myTrials.fmriblock] == uff(i));
%  %myTrials(face_counter(1)).ISI = 0.3;
%  myTrials(face_counter(1)).time_to_respond = 0.3;
%  end
%  
 
%  
%  %for faces control task
%  faces_counter(1,:) = find([myTrials.blockNum] == 14);
%  faces_counter(2,:) = [myTrials(faces_counter(1):faces_counter(length(faces_counter))).fmriblock];
%  ucf = unique(faces_counter(2,:)); % fmri blocks for the monuments task
% 
%  for i = 1 : length(ucf)
%   faces_counter = find ([myTrials.fmriblock] == ucf(i))
%  myTrials(faces_counter(1)).ISI = 0.2
%  myTrials(faces_counter(1)).time_to_respond = 0.2
%  end
%  
%sorting should be left as the last step
%%
% % does fMRI RUNS
% s_line = [0;8;16;24;32];
%    %r_fmri_blocks = randperm(num_fmriBlocks);
%   r_fmri_run = 1:5;
% for k = 1 : 5;
%      %r_fmri_blocks = Shuffle(1:15);
%      for o = 0 : 16
% for i = 1 : num_fmriTrials;
%     myTrials(s_line(k) + i + o*40).fmriRun = r_fmri_run(k);
% end
% end
% end
% [~,index] = sortrows([myTrials.fmriRun].'); myTrials = myTrials(index); clear index;
% % deals with fMRI runs
%%
% does fMRI BLOCKS
%rand_fmri_b = [Shuffle(1:15),Shuffle(16:30),Shuffle(31:45),Shuffle(46:60),Shuffle(61:75)]';
%rand_fmri_b = [Shuffle(1:17),Shuffle(18:34),Shuffle(35:51),Shuffle(52:68),Shuffle(69:85)]';
rand_fmri_b = [1:2:num_fmriBlocks, 2:2:num_fmriBlocks]; %randomisation of blocks
s_line = 0;
for i = 1 : num_fmriBlocks;
    for k = 1: num_fmriTrials;
        myTrials(s_line + k).fmriBlock = rand_fmri_b(i);
    end
    s_line = s_line + num_fmriTrials;
end


if sort == 1;
    [~,index] = sortrows([myTrials.fmriBlock].'); myTrials = myTrials(index); clear index;
end


end % ends the function


%source(pres_order(1)).filepaths{1,1}
%for block_prefill2 = 1 : numBlocks
%for line_prefill2 = block_prefill2 * numTrials - (numTrials - 1) : block_prefill2 * numTrials;
   
   
    %pres_order(line_prefill2)
    %myTrials(line_prefill2).line_prefill2 = line_prefill2;
    %myTrials(line_prefill2).block_prefill2 = block_prefill2;
    %myTrials(line_prefill).TaskName = Task{randTask(block_prefill),1};
%end
%end
    

