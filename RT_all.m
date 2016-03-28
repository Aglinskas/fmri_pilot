addpath(genpath('/Users/aidas_el_cap/Documents/MATLAB/altmany-export_fig_f/'));
D_f(1:length(D_f)) = []
D_s(1:length(D_s)) = []
D_both(1:length(D_both)) = []
for subID = 1:12
Override = 1;
dr = '/Users/aidas_el_cap/Desktop/BehaviouralPilot/'; % where the files are stored
%% the script should be able to take over from here
%dir_names & filenames
sub_str = num2str(subID,'%02i');
fln = ['New_Pilot_subject_test_S' sub_str ];%what the files are called
first_run = '_Results_SLF_PACE.mat';
second_run = '_Results_2run.mat';
ext = {first_run second_run};
Tasks_eng = {'Hair_Color' 'First_memory' 'Attractiveness' 'Friendliness' 'Trustworthiness' 'Positive_Emotions' 'Familiarity' 'How_much_write' 'Common_name' 'How_many_facts' 'Occupation' 'Distinctiveness_of_face' 'Integrity' 'Same_Face' 'Same_monument'};
lbls = {'Hair Color' 'First memory' 'Attractiveness' 'Friendliness' 'Trustworthiness' 'Positive Emotions' 'Familiarity' 'How much write' 'Common name' 'How many facts' 'Occupation' 'Distinctiveness of face' 'Integrity' 'Same Face' 'Same monument'};
%% self paced half
load(fullfile(dr,['S' sub_str],[fln first_run]));
% %%
% if subID == 1
% end

for i = 1:max([myTrials.blockNum]);
D_f(i).blocknum = i;
D_f(i).Task = Tasks_eng{i};
D_f(i).average = [D_f(i).average nanmean([myTrials(find([myTrials.blockNum] == i)).RT])];
D_f(i).median = [D_f(i).median nanmedian([myTrials(find([myTrials.blockNum] == i)).RT])];
D_f(i).max = [D_f(i).max nanmax([myTrials(find([myTrials.blockNum] == i)).RT])];
D_f(i).min = [D_f(i).min nanmin([myTrials(find([myTrials.blockNum] == i)).RT])];
D_f(i).std = [D_f(i).std nanstd([myTrials(find([myTrials.blockNum] == i)).RT])];
D_f(i).missed = [D_f(i).missed length(find([myTrials.blockNum] == i & isempty([myTrials.response]) == 1))];
D_f(i).portion = 'First Half';
end
end
%% second half
%All_face = [];
load(fullfile(dr,['S' sub_str],[fln second_run]));
% %% Descriptives
for i = 1:max([myTrials.blockNum]);
D_s(i).blocknum = i;
D_s(i).Task = Tasks_eng{i};
D_s(i).average = [D_s(i).average nanmean([myTrials(find([myTrials.blockNum] == i)).RT])];
D_s(i).median = [D_s(i).median nanmedian([myTrials(find([myTrials.blockNum] == i)).RT])];
D_s(i).max = [D_s(i).max nanmax([myTrials(find([myTrials.blockNum] == i)).RT])];
D_s(i).min = [D_s(i).min nanmin([myTrials(find([myTrials.blockNum] == i)).RT])];
D_s(i).std = [D_s(i).std nanstd([myTrials(find([myTrials.blockNum] == i)).RT])];
D_s(i).missed = length(find([myTrials.blockNum] == i & isempty([myTrials.response]) == 1));
D_s(i).portion = 'Second Half'
end
D_both = [D_s D_f];


% 
% 
% 




