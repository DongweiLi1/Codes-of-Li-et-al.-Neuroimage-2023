


clear all
close all
clc

path='D:\WMprecision\ERSP\noERP\';
eeglab;
trigger={'111','112','121','122','213','223'};
time=[-2         2.5];
channelnum =[1:57 59:61];
sub=[1:6 8:14,16:36]; 
for i =1:length(sub)
    load([path,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
    for channel =1:length(channelnum)
        load([path,'Data_sub',num2str(sub(i)),'_channel',num2str(channelnum(channel)),'_singletrial_ERSP.mat']);
        NeturalArtFreeTrialnum = setdiff(NeturalTrialnum,RejArtTrialnum);
        ValidArtFreeTrialnum = setdiff(ValidTrialnum,RejArtTrialnum);
        NeturalERSP(i,channel,:,:) = squeeze(mean(ERSP(NeturalArtFreeTrialnum,:,:),1));
        ValidERSP(i,channel,:,:) = squeeze(mean(ERSP(ValidArtFreeTrialnum,:,:),1));
        clear NeturalArtFreeTrialnum ValidArtFreeTrialnum ERSP
    end
end

for i=1:length(sub)
    for j=1:60
        for m=1:57
            for n=1:900
                SubNetural(i,j,m,n)=10*log10(NeturalERSP(i,j,m,n)/squeeze(mean(NeturalERSP(i,j,m,1:36),4)));
                SubValid(i,j,m,n)=10*log10(ValidERSP(i,j,m,n)/squeeze(mean(ValidERSP(i,j,m,1:36),4)));
            end
        end
    end
end


Netural = squeeze(mean(SubNetural,1));
Valid = squeeze(mean(SubValid,1));


for k = 1:900
    for cc = 1:60
        for ff=1:57
     [tfdif(k,cc,ff),tfp(k,cc,ff)] = ttest(squeeze(mean(mean(mean(SubValid(:,cc,ff,k),2),3),4)) ,squeeze(mean(mean(mean(SubNetural(:,cc,ff,k),2),3),4)));
        end
    end
%     figure;
%        topoplot( squeeze(ptheta(k,:)), 'Channel_64.sfp', 'electrodes','on', 'maplimits',[0,1], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
%        colormap(parula);
%        colorbar;
%        title(['theta',num2str(k)]);
%        figure;
%        topoplot( squeeze(palpha(k,:)), 'Channel_64.sfp', 'electrodes','on', 'maplimits',[0,1], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
%        colormap(parula);
%        colorbar;
%        title(['alpha',num2str(k)]);
end

% 
% for tt = 1:900
%     for cc = 1:60
%         for ff=1:57
%              if tfp(tt,cc,ff)>0.1
%                  tfp(tt,cc,ff)=1;
%              else
%                  tfp(tt,cc,ff)=tfp(tt,cc,ff);
%              end
%         end
%     end
% end
% 
% 
% for tt = 1:900
%     for cc = 1:60
%         for ff=1:57
%         [cor(tt,cc,ff),pp(tt,cc,ff)] = corr(rtdif,squeeze(SubValid(:,cc,ff,tt))-squeeze(SubNetural(:,cc,ff,tt)),'type','Spearman');
%         end
%     end
% end
% 
% for tt = 1:900
%     for cc = 1:60
%         for ff=1:57
%              if pp(tt,cc,ff)>0.05
%                  pp_cor(tt,cc,ff)=1;
%              else
%                  pp_cor(tt,cc,ff)=pp(tt,cc,ff);
%              end
%         end
%     end
% end


for c=1:60
    
% figure;
% h=surf(times,frequencies,squeeze(tfp(:,c,:))');
% set(h,'edgecolor','none');
% colormap(parula);
% colorbar;
% axis([-1.55,2.25, 2, 30]);
% caxis([0,0.1]);
% title(['Valid - Neutral channel',num2str(c)]);  
% %     
    
figure;
h=surf(times,frequencies,squeeze(Valid(c,:,:))-squeeze(Netural(c,:,:)));
set(h,'edgecolor','none');
colormap(parula);
colorbar;
axis([-1.25,1.85, 2, 30]);
caxis([-0.6,0.6]);
title(['Valid - Neutral channel',num2str(c)]);  

end


figure;
  topoplot(squeeze(mean(mean(Valid(:,27:47,416:558),2),3))-squeeze(mean(mean(Netural(:,27:47,416:558),2),3)), 'Channel_64.sfp', 'electrodes','on', 'maplimits',[-0.5,0], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
  colormap(parula);
  colorbar;

figure;
  topoplot(squeeze(mean(mean(Valid(:,13:21,451:524),2),3))-squeeze(mean(mean(Netural(:,13:21,451:524),2),3)), 'Channel_64.sfp', 'electrodes','on', 'maplimits',[-1.2,1.2], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
  colormap(othercolor('BuDRd_18'));
  colorbar;
  
  
stastValid = squeeze(mean(mean(mean(SubValid([1 2 3:8 10:34],[42:60],13:21,450:524),2),3),4));
stastNeutral = squeeze(mean(mean(mean(SubNetural([1 2 3:8 10:34],[42:60],13:21,450:524),2),3),4));
stastValid = squeeze(mean(mean(mean(SubValid(:,[42:60],13:21,450:524),2),3),4));
stastNeutral = squeeze(mean(mean(mean(SubNetural(:,[42:60],13:21,450:524),2),3),4));

for i=1:190
[r(i),p(i)]=corr(squeeze(mean(subValidThetaAlphaMI([1 2 3:8 10:34],[42:57 59:61]),2))-squeeze(mean(subNeturalThetaAlphaMI([1 2 3:8 10:34],[42:57 59:61]),2)),ValidAverageAccuracy([1 2 3:8 10:34],i)-NeutralAverageAccuracy([1 2 3:8 10:34],i));
end
figure
plot(p)

for i=1:125
[r(i),p(i)]=corr(SubValiddif([1 3:8 10:34]),SpaceValidACC([1 3:8 10:34],i),'type','Spearman');
end
for i=1:125
[r(i),p(i)]=corr(SubValiddif([1 2 3:8 10:34]),SpaceValidACC([1 2 3:8 10:34],i));
end
a=squeeze(mean(SpaceValidACC([1 2 3:8 10:34],36:61),2));
aa=squeeze(mean(SpaceNeutralACC([1 2 3:8 10:34],36:61),2));
aaa=squeeze(mean(SpaceValidACC([1 2 3:8 10:34],101:111),2));
aaaa=squeeze(mean(SpaceNeutralACC([1 2 3:8 10:34],101:111),2));

b=squeeze(mean(ColorValidACC([1 2 3:8 10:34],16:36),2));
bb=squeeze(mean(ColorNeutralACC([1 2 3:8 10:34],16:36),2));
bbb=squeeze(mean(ColorValidACC([1 2 3:8 10:34],96:106),2));
bbbb=squeeze(mean(ColorNeutralACC([1 2 3:8 10:34],96:106),2));
for i=1:190
[r(i),p(i)]=corr(squeeze(mean(subValidThetaAlphaMI([1 2 3:8 10:34],[42:57 59:61]),2)),ValidAverageAccuracy([1 2 3:8 10:34],i));
end

for i=1:190
[r(i),p(i)]=corr(SubValiddif([1 2 3:8 10:34]),ValidAverageAccuracy([1 2 3:8 10:34],i));
end
clear p
figure
plot(p)
[r,p]=corr(SubNeturaldif([1 2 3:8 10:34]),squeeze(mean(NeutralAverageAccuracy([1 2 3:8 10:34],[101:116]),2)))
plot(p)
for i=1:190
[r(i),p(i)]=corr(stastValid-stastNeutral,squeeze(ValidAverageAccuracy([1 2 3:8 10:34],i))-squeeze(NeutralAverageAccuracy([1 2 3:8 10:34],i)));
end
for i=1:190
[r(i),p(i)]=corr(stastValid,squeeze(ValidAverageAccuracy([1 2 3:8 10:34],i)));
end
clear p
for i=1:125
[r(i),p(i)]=corr(stastValid,squeeze(SpaceValidACC([1 3:8 10:34],i)));
end
[r,p]=corr(stastValid,squeeze(mean(ValidAverageAccuracy([1 3:8 10:34],[52:61]),2)))
[r,p]=corr(stastNeutral,squeeze(mean(NeutralAverageAccuracy([1 3:8 10:34],[52:61]),2)))
[r,p]=corr(stastValid-stastNeutral,SubValiddif([1 2 3:8 10:34])-SubNeturaldif([1 2 3:8 10:34]))
[r,p]=corr(stastValid-stastNeutral,SubValidRT([1 2 3:8 10:34])-SubNeturalRT([1 2 3:8 10:34]))
[r,p]=corr(stastValid,SubValidRT([1 2 3:8 10:34]))

for i=1:190
[r(i),p(i)]=corr(SubValiddif([1 3:8 10:34]),squeeze(ValidAverageAccuracy([1 3:8 10:34],i)));
end
[r,p]=corr(SubValiddif([1 3:8 10:34]),squeeze(mean(ValidAverageAccuracy([1 3:8 10:34],[101:111]),2)))


[r,p]=corr(stastValid-stastNeutral,squeeze(mean(ValidAverageAccuracy([1 3:8 10:34],[86:96]),2))-squeeze(mean(NeutralAverageAccuracy([1 3:8 10:34],[86:96]),2)))
figure;
h=surf(times,frequencies,squeeze(mean(Netural([42:60],:,:),1)));
set(h,'edgecolor','none');
colormap(othercolor('BuDRd_18'));
colorbar;
axis([-0.5,1.5, 2, 30]);
caxis([-2.5,2.5]);

seValid = squeeze(std(squeeze(mean(mean(SubValid([1 3:8 10:34],[42:60],13:21,:),2),3)),1))/sqrt(32);
seNeutral = squeeze(std(squeeze(mean(mean(SubNetural([1 3:8 10:34],[42:60],13:21,:),2),3)),1))/sqrt(32);
figure;
cl=colormap(othercolor('Blues6'));
plot(times,squeeze(mean(mean(mean(SubValid([1 3:8 10:34],[42:60],13:21,:),1),2),3)));
boundedline(times,squeeze(mean(mean(mean(SubValid([1 3:8 10:34],[42:60],13:21,:),1),2),3)),seValid,'cmap',cl(246,:),'alpha','transparency',0.35)
hold on;
cl=colormap(othercolor('Greys6'));
plot(times,squeeze(mean(mean(mean(SubNetural([1 3:8 10:34],[42:60],13:21,:),1),2),3)));
boundedline(times,squeeze(mean(mean(mean(SubNetural([1 3:8 10:34],[42:60],13:21,:),1),2),3)),seValid,'cmap',cl(246,:),'alpha','transparency',0.35)
axis([-0.5 1.5 -4,1]);
caxis([-4,4]);

figure;
h=surf(times,frequencies,squeeze(mean(Valid([47 48 55 56 57 59],:,:),1))-squeeze(mean(Netural([47 48 55 56 57 59],:,:),1)));
set(h,'edgecolor','none');
colormap(parula);
colorbar;
axis([-0.5,1.5, 2, 30]);
caxis([-1,5,1.5]);
title(['Valid - Neutral channel',num2str(c)]);  
