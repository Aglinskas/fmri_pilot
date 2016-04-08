function mix = shuffle_conds(v)
%%
n_cog = v(1:10);
fc_task = v(11:13);
mn_task = v(14:16);

% Mix it up
mix = [];
mix(1:2:length(n_cog)*2) = Shuffle(n_cog); %randi([1 2],1)
mix = mix;  
% insert face task
cc_sl = find(mix == 0);
cc = Shuffle(cc_sl(1:2:end)); % Face inds
mn = Shuffle(cc_sl(2:2:end)); % Monument inds
mix(cc(1:3)) = fc_task; % Inserts face tasks
mix(mn(1:3)) = mn_task; % inserts monuments task
mix(mix == 0) = []; % clear zeros
mix = mix';
end