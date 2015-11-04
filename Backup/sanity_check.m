myTrials = func_testTrials;
a = cell(0);
for run = 1:5;
p = find([myTrials.fmriRun] == run);
%length(unique([myTrials(min(p):max(p)).blockNum],'stable'))
a{run} = (unique([myTrials(min(p):max(p)).blockNum],'stable'));
end
a{1:5}