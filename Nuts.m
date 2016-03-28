
close all
load('/Users/aidas_el_cap/Desktop/BehaviouralPilot/Face_rating_all_subs.mat')
Tasks_eng = {'Hair_Color' 'First_memory' 'Attractiveness' 'Friendliness' 'Trustworthiness' 'Positive_Emotions' 'Familiarity' 'How_much_write' 'Common_name' 'How_many_facts' 'Occupation' 'Distinctiveness_of_face' 'Integrity' 'Same_Face' 'Same_monument'};
for Q=1:13
    subCC=0;
    for sub=1:2:24
        subCC=subCC+1;
        for identity=1:10
        temp=fc_allsubs(identity).(Tasks_eng{Q});
       
        outPut(subCC,Q,identity)= nanmean(temp(sub:sub+1));
        end
    end
end

for Q=1:13
    subCC=0;
    for sub=1:2:24
        subCC=subCC+1;
        
        for identity=1:10
       if isnan(outPut(subCC,Q,identity))
           outPut(subCC,Q,identity)=nanmean( outPut(:,Q));
       end
       end
    end
end


for Q=1:13
  
for sub=1:12
    find(sub==[1:12])
    x(Q,sub)=corr(squeeze(outPut(find(sub==[1:12]),Q,:)),squeeze(mean(outPut(find(sub~=[1:12]),Q,:))));
   plot(squeeze(outPut(find(sub==[1:12]),Q,:)),squeeze(mean(outPut(find(sub~=[1:12]),Q,:))),'x')
   pause(.5)
end
end