


clear all
close all
clc

path='E:\H\WMprecision\';
pathout='C:\WMprecision\ERSP\noERP\';
eeglab;
trigger={'111','112','121','122','213','223'};
time=[-0.2         2.1];

sub=[1:6 8:14 16:33];
for i =1:length(sub)
    pathin = [path,'sub',num2str(sub(i)),'\'];
    load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
    fname=['sub',num2str(sub(i)),'_resample_ref_filt_allepochs_int_removeICs.set'];
    EEG = pop_loadset('filename',fname,'filepath',pathin); 
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200    0]);
    EEG = eeg_checkset( EEG );
        NeturalLeftArtFreeTrialnum = setdiff(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalArtFreeRightTrialnum);
        NeturalRightArtFreeTrialnum = setdiff(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalArtFreeLeftTrialnum);
        ValidLeftArtFreeTrialnum = setdiff(setdiff(ValidTrialnum,RejArtTrialnum),ValidArtFreeRightTrialnum);
        ValidRightArtFreeTrialnum = setdiff(setdiff(ValidTrialnum,RejArtTrialnum),ValidArtFreeLeftTrialnum);
        NeturalLeftERP(i,:,:) = squeeze(mean(EEG.data(:,:,NeturalLeftArtFreeTrialnum),3));
        NeturalRightERP(i,:,:) = squeeze(mean(EEG.data(:,:,NeturalRightArtFreeTrialnum),3));
        ValidLeftERP(i,:,:) = squeeze(mean(EEG.data(:,:,ValidLeftArtFreeTrialnum),3));
        ValidRightERP(i,:,:) = squeeze(mean(EEG.data(:,:,ValidRightArtFreeTrialnum),3));
        clear NeturalLeftArtFreeTrialnum NeturalRightArtFreeTrialnum ValidLeftArtFreeTrialnum ValidRightArtFreeTrialnum EEG
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
NeturalCon = squeeze(mean(NeturalLeftERP(:,[48:50 56:57],:),2))+squeeze(mean(NeturalRightERP(:,[42:44 51:52],:),2));
ValidCon=  squeeze(mean(ValidLeftERP(:,[48:50 56:57],:),2))+squeeze(mean(ValidRightERP(:,[42:44 51:52],:),2));

NeturalIps = squeeze(mean(NeturalLeftERP(:,[42:44 51:52],:),2))+squeeze(mean(NeturalRightERP(:,[48:50 56:57],:),2));
ValidIps=  squeeze(mean(ValidLeftERP(:,[42:44 51:52],:),2))+squeeze(mean(ValidRightERP(:,[48:50 56:57],:),2));

NeturalDif = NeturalCon-NeturalIps;
ValidDif = ValidCon-ValidIps;

neutral = squeeze(mean(NeturalDif,1));
valid = squeeze(mean(ValidDif,1));
NeutralConAvg = squeeze(mean(NeturalCon,1));
NeutralIpsAvg = squeeze(mean(NeturalIps,1));
ValidConAvg = squeeze(mean(ValidCon,1));
ValidIpsAvg = squeeze(mean(ValidIps,1));
figure;
plot(times,squeeze(mean(NeturalDif,1)),'r');
hold on;
plot(times,squeeze(mean(ValidDif,1)),'b');
legend('Netural','Valid')
axis([-200,2000,-1 1]);

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


    topodif=squeeze(mean(mean(ValidLeftERP(:,:,109:143),1),3))-squeeze(mean(mean(ValidRightERP(:,:,109:143),1),3));

    figure;
       topoplot( topodif, 'Channel_64.sfp', 'electrodes','on', 'maplimits',[-0.3,0.3], 'plotrad',0.7,'headrad',0.69,'noplot','off' );
       colormap(othercolor('BuDRd_18'));
       colorbar;
%        title(['ERPDif']);

statsValid = squeeze(mean(mean(ValidERP(:,[9 10 11 18 19 20 27 28 29],200:350),2),3));
statsNeutral = squeeze(mean(mean(NeturalERP(:,[9 10 11 18 19 20 27 28 29],250:300),2),3));
       
       