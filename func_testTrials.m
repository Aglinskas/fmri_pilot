%source(1).filepaths{1,1} %surce(i) name counter, filepaths{i,1} picture counter
%myTrials = source

function myTrials = func_testTrials;

%ISI = 3;
time_to_respond = 3.5;
monuments = 'Monuments/*.jpg';% directory of the faces folder
monuments2 = 'Monuments';
names = dir(monuments);
names = names(arrayfun(@(x) ~strcmp(x.name(1),'.'),names));
numTrials = 40;


source = func_getpic5();
%rng((rand * GetSecs));
%% parameters, fix to feed to the func
numTrials = 40;
numBlocks = 17;
num_fmriTrials = 8; % has to divide evenly by numTrials
num_fmriBlocks = 85; % total number of trials / fmriTrials
sort = 1; % 1 myTrials in fmri sequence puts, elses
%control_task = Task{14,1};% which task is control task?
%monuments_task = Task{15,1};
n_rep = ceil(numTrials / 3);

Task{1,1} = 'Di che colore sono i capelli di questa persona?'; %Control or baseline
Task{1,2} = '1 = Biondi\n2 = Scuri\n3 = Altro\n4 = La persona è calva';
Task{2,1} = 'Quanti anni avevi quando hai sentito parlare\ndi questa persona per la prima volta?'; %episodic
Task{2,2} = '1 = Meno di 7 anni\n2 = Tra 8 e 17\n3 = Tra 18 ed ora\n4 = Non ne ho mai sentito parlare';
Task{3,1} = 'Quanto ritieni sia fisicamente attraente questa persona?';
Task{3,2} = '1 = Molto attraente\n2 = Attraente\n3 = Nella media\n4 = Non proprio attraente';
Task{4,1} = 'Quanto ritieni sia amichevole questa persona?';
Task{4,2} = '1 = Molto amichevole\n2 = Amichevole\n3 = Non proprio amichevole\n4 = Non mi avvicinerei';
Task{5,1} = 'Quanto ritieni sia affidabile questa persona?';
Task{5,2} = '1 = Molto affidabile\n2 = Abbastanza affidabile\n3 = Non proprio affidabile\n4 = Assolutamente non affidabile';
Task{6,1} = 'Associ questa persona ad emozioni più positive o più negative?';
Task{6,2} = '1 = Emozioni molto positive\n2 = Emozioni in qualche modo positive\n3 = Emozioni in qualche modo negative\n4 = Emozioni negative';
Task{7,1} = 'Hai mai visto questa persona prima?/Riconosci il suo volto?'; % semantic access 1
Task{7,2} = '1 = Sì\n2 = No, mai vista prima';
Task{8,1} = 'Se ti chiedessero di scrivere un tema\nsu questa persona, quanto potresti scrivere?';%semantic access 2
Task{8,2} = '1 = Una pagina\n2 = Un paragrafo\n3 = Una frase\n4 = Niente';
Task{9,1} = 'Quanto è comune il nome proprio di questa persona?';
Task{9,2} = '1 = Molto comune\n2 = Non molto comune\n3 = E? l?unica persona che conosco con quel nome\n4 = Non conosco il nome di questa persona';
Task{10,1} = 'Quanti fatti riesci a ricordare di questa persona?';
Task{10,2} = '1 = Più di 5 compreso il suo nome\n2 = Quattro o cinque\n3 = Due o tre\n4 = Non conosco questa persona';
Task{11,1} = 'Che lavoro fa questa persona?';
Task{11,2} = '1 = Televisivo/Attore\n2 = Cantante/Musicista\n3 = Politico/Uomo d?affari\n4 = Altro/Non so'; %1 = Personaggio televisivo/Attore\n2
Task{12,1} = 'Quanto è distintivo e distinguibile il volto di questa persona?';
Task{12,2} = '1 = Non lo confonderei con nessun altro\n2 = Abbastanza distintivo\n3 = Confondibile\n4 = Potrebbe essere tranquillamente confuso\n    con qualcun altro';
Task{13,1} = 'Considerate tutte le informazioni a tua disposizione\n(se conosci o meno questa persona);\nQuanto ritieni sia brava o cattiva questa persona?';
Task{13,2} = '1 = Brava persona\n2 = Sopra la media / una persona per bene\n3 = Sotto la media/non proprio una persona per bene\n4 = Brutta persona';
Task{14,1} = 'E lo stesso volto rispetto al precedente?'; %control
Task{14,2} = '1 = Volto diverso\n2 = Stesso volto';
Task{15,1} = 'E lo stesso monumento del precedente?';
Task{15,2} = '1 = Monumento diverso\n2 = Stesso monumento';
Task{16,1} = 'E lo stesso monumento del precedente?';
Task{16,2} = '1 = Monumento diverso\n2 = Stesso monumento';
Task{17,1} = 'E lo stesso monumento del precedente?';
Task{17,2} = '1 = Monumento diverso\n2 = Stesso monumento';
%%
%% Task names and task instructions
randTask = 1 : 17;
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
 



   %%
  
   %start_line = start_line + trial;
   %for exp_line = numBlocks * numTrials - (numTrials - 1) : numBlocks * numTrials;
   %    myTrials.line_test = exp_line
   %end
   
 %% Try monuments
% %  monuments_path = '/Users/aidas_el_cap/Desktop/Experiment/MonumentsForAidas/*.jpg';
% %    path = '/Users/aidas_el_cap/Desktop/Experiment/MonumentsForAidas/';
% %    mon_pics = dir(monuments_path);
% %    r_mon_list = randperm(length(dir(monuments_path)))';
% %    for i = 1 : numTrials;
% %    monuments_list{i} = strcat(path, mon_pics(r_mon_list(i)).name);
% %    end
% %    monuments_list = monuments_list';
% %    
% %    
% %    for i = 1 : numTrials;
% %        myTrials(i).monuments = monuments_list{i};
% %    end
  % m_start =  length(myTrials) + 1;
  % for i = m_start : m_start + numTrials
  %rng(GetSecs);
%randTask = randperm(length(Task)); %this is where task vector is randomized

  
  
%   mstart = length(myTrials)
%   for i = 1 : numTrials
%        myTrials(mstart + i).filenames = monuments_list{i};
%        myTrials(mstart + i).blockNum = 15;
%        myTrials(mstart + i).trialnum = i;s
%a = [Shuffle(1:15);Shuffle(1:15);Shuffle(1:15);Shuffle(1:15);Shuffle(1:15)];
%b=[a(:,1);a(:,2);a(:,3);a(:,4);a(:,5);a(:,6);a(:,7);a(:,8);a(:,9);a(:,10);a(:,11);a(:,12);a(:,13);a(:,14);a(:,15)];

   


% end
end



%function a = func_getmon();
%numTrials = 40;
%a = struct;

for mb = 15:17
mon_task_index = find([myTrials.blockNum] == mb);
for ll = 1 : numTrials;
% a(ll).name = names(ll).name;
myTrials(mon_task_index(ll)).filepath = strcat(monuments2, '/',names(ll).name);
end
end




    % Adds repetition for control and monuments tasks
   %% Code for the Control Task [Randomly repeats some of the pictures]
% n_rep has been moved to top of code, next to the parameters
c_block = find([myTrials.blockNum] == 14);
c_block(length(c_block)) = [];
%if CurrentTask{1,1}{1,1} == control_task;
r_cb = Shuffle(c_block); 
    for i_OW = 1 : n_rep; %repeats some of the faces
        myTrials(r_cb(i_OW) + 1).filepath = myTrials(r_cb(i_OW)).filepath;
    end

% end of Control Task code

%% Monuments task code
for mb = 15:17
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

s_line = [0;8;16;24;32];
   %r_fmri_blocks = randperm(num_fmriBlocks);
  r_fmri_run = 1:5;
for k = 1 : 5;
     %r_fmri_blocks = Shuffle(1:15);
     for o = 0 : 16
for i = 1 : num_fmriTrials;
    myTrials(s_line(k) + i + o*40).fmriRun = r_fmri_run(k);
end
end
end
[~,index] = sortrows([myTrials.fmriRun].'); myTrials = myTrials(index); clear index;

%rand_fmri_b = [Shuffle(1:15),Shuffle(16:30),Shuffle(31:45),Shuffle(46:60),Shuffle(61:75)]';
rand_fmri_b = [Shuffle(1:17),Shuffle(18:34),Shuffle(35:51),Shuffle(52:68),Shuffle(69:85)]';
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
    

