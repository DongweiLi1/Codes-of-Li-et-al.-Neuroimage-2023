


clear all
close all
clc

path='D:\H\WMprecision\';
pathout='E:\WMprecision\ERSP\noERP\';
eeglab;
trigger={'111','112','121','122','213','223'};
time=[-0.2         2.1];

sub=[1:6 8:14,16:36];
for i =32:length(sub)
    pathin = [path,'sub',num2str(sub(i)),'\'];
    load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
    fname=['sub',num2str(sub(i)),'_filter_ref_int_allepochs_removeICs.set'];
    EEG = pop_loadset('filename',fname,'filepath',pathin); 
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_resample( EEG, 256);
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200    0]);
    EEG = eeg_checkset( EEG );
        NeturalArtFreeTrialnum = setdiff(NeutralTrialNum,RejArtTrialnum);
        ValidArtFreeTrialnum = setdiff(ValidTrialNum,RejArtTrialnum);
        NeturalERP(i,:,:) = squeeze(mean(EEG.data(:,:,NeturalArtFreeTrialnum),3));
        ValidERP(i,:,:) = squeeze(mean(EEG.data(:,:,ValidArtFreeTrialnum),3));
        clear NeturalArtFreeTrialnum ValidArtFreeTrialnum EEG
    end

% 
% for k = 200
%      for cc = 1:62
%      [ERPdif(k,cc),pERP(k,cc)] = ttest(squeeze(mean(mean(ValidERP(:,cc,k:k+200),2),3)) ,squeeze(mean(mean(NeturalERP(:,cc,k:k+200),2),3))); 
%      if pERP(k,cc) >0.05
%          pERP(k,cc) = 1;
%      end
%      end
%     figure;
%        topoplot( squeeze(pERP(k,:)), 'Channel_64.sfp', 'electrodes','on', 'maplimits',[0,1], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
%        colormap(parula);
%        colorbar;
%        title(['ERP',num2str(k*3.905-200)]);
% 
% end
% 

NeturalERPavg = squeeze(mean(mean(NeturalERP(:,[9 10 11 18 19 20 27 28 29],:),1),2));
ValidERPPavg = squeeze(mean(mean(ValidERP(:,[9 10 11 18 19 20 27 28 29],:),1),2));

figure;
plot(times,NeturalERPavg,'r');
hold on;
plot(times,ValidERPPavg,'b');
legend('Netural','Valid')
axis([-200,2100,-6 6]);

% 
% 
% for cc = [1:62]
%      for k = 1:589
%      [corERP(k,cc),corpERP(k,cc)] = corr(dif,squeeze(mean(mean(ValidERP(:,cc,k),2),3))-squeeze(mean(mean(NeturalERP(:,cc,k),2),3)),'type','Spearman'); 
%      if corpERP(k,cc) >0.05
%          corpERP(k,cc) = 1;
%      end
%      end
%      figure;
%      plot(corpERP(:,cc));
%      title(num2str(cc));
% end
% 


    topodif=squeeze(mean(mean(ValidERP(:,:,200:300),1),3))-squeeze(mean(mean(NeturalERP(:,:,200:300),1),3));

    figure;
       topoplot( topodif, 'Channel_64.sfp', 'electrodes','on', 'maplimits',[-2,2], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
       colormap(othercolor('BuDRd_18'));
       colorbar;
%        title(['ERPDif']);

statsValid = squeeze(mean(mean(ValidERP(:,[9 10 11 18 19 20 27 28 29],206:359),2),3));
statsNeutral = squeeze(mean(mean(NeturalERP(:,[9 10 11 18 19 20 27 28 29],206:359),2),3));
       
for i=1:589
[r(i),p(i)]=corr(squeeze(mean(ValidERP([1 2 3:8 10:34],[9 10 11 18 19 20 27 28 29],i),2))-squeeze(mean(NeturalERP([1 2 3:8 10:34],[9 10 11 18 19 20 27 28 29],i),2)),SubValiddif([1 2 3:8 10:34])-SubNeturaldif([1 2 3:8 10:34]));
end
plot(p)   