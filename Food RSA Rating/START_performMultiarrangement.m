% START_performMultiarrangement
clear; close all hidden;

addpath([pwd '/multiarrangement'])
%% control variables
options.sessionI=1;  
options.axisUnits='normalized'; % images resized
options.maxSessionLength_min=28;
options.analysisFigs=false;

%% get subject initials                                         
options.subjectInitials=inputdlg('Subject initials:');
options.subjectInitials=options.subjectInitials{1};


%% load stimuli
% load('myStimuli.mat');
load('FoodStim.mat');

%         stimuli=rmfield(stimuli,'alpha');
for ii=1:length(stimuli)
    if ndims(stimuli(ii).alpha)==3
    stimuli(ii).alpha=rgb2gray(stimuli(ii).alpha);
    
    end
end

stimuli=stimuli(1:numel(stimuli));


%% prepare output directory
files=dir('similarityJudgementData');
if size(files,1)==0
    % folder 'similarityJudgementData' doesn't exist within current folder: make it
    mkdir('similarityJudgementData');  
end
cd('similarityJudgementData');


%% administer session
options.dateAndTime_start=clock;

% MULTI-ARRANGEMENT (MA)
[estimate_dissimMat_ltv_MA,simulationResults_ignore,story_MA]=simJudgmentByMultiArrangement_circArena_liftTheWeakest_SLF(stimuli,'Please arrange these objects according to their similarity',options);


%% save experimental data from the current subject
save([options.subjectInitials,'_session',num2str(options.sessionI),'_',dateAndTimeStringNoSec_nk,'_workspace']);


%% display representational dissimilarity matrix (RDM)
showSimmats(estimate_dissimMat_ltv_MA);
addHeadingAndPrint('multiple-trial RDM','figures');


%% plot stimuli in multidimensional-scaling (MDS) arrangement
criterion='metricstress';
[pats_mds_2D,stress,disparities]=mdscale(estimate_dissimMat_ltv_MA,2,'criterion',criterion);

pageFigure(400); subplot(2,1,1); 
drawImageArrangement(stimuli,pats_mds_2D,1,[1 1 1]);
title({'\fontsize{14}stimulus images in MDS arrangement\fontsize{11}',[' (',criterion,')']});
shepardPlot(estimate_dissimMat_ltv_MA,disparities,pdist(pats_mds_2D),[400 2 1 2],['\fontsize{14}shepard plot\fontsize{11}',' (',criterion,')']);
addHeadingAndPrint('multiple-trial MDS plot','figures');


%% revert to original directory
cd('..');


%% display message DONE
h=msgbox('You are done :)');

