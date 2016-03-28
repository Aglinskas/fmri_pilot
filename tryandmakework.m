conds =[1 2 3 4 5 6 7 8 9 10 11 11 11 12 12 12];
while 1
    conds=Shuffle(conds);
    if min(abs(diff(conds)))>0
        break
    end
end
   conds
   
   
   %rand_fmri_b = [Shuffle(1:16),Shuffle(17:32),Shuffle(33:48),Shuffle(49:64),Shuffle(65:80)]';
   rand_fmri_b = [Shuffle(1:16),Shuffle(17:32),Shuffle(33:48),Shuffle(49:64),Shuffle(65:80)]';
  Shuffle([(1:10) 11 11 11 12 12 12])