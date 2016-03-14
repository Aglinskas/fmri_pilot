load('AidasStim.mat')

pics = '/Users/aidas_el_cap/Desktop/Work_files/Task_pics//'
ext = '*.png'
a = dir([pics ext])

for i = 1:length(a)
stimuli(i).image = imread(fullfile(pics,a(i).name));
stimuli(i).alpha = repmat(1,size(imread(fullfile(pics,a(i).name))))
end


save('AidasStim_goodSmall.mat','stimuli')