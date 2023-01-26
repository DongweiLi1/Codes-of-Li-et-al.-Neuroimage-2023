

clear all
close all
clc

delete(gcp)
parpool

path='D:\H\WMprecision\';
pathout='E:\WMprecision\ERSP\noERP\';
eeglab;
trigger={'111','112','121','122','213','223'};
time=[-1.8         2.4];
channels = [1:57 59:61];
sub=[34:36];
for i =1:length(sub)
    pathin = [path,'sub',num2str(sub(i)),'\'];
    load([pathin,'sub',num2str(sub(i)),'_Precision.mat']);
     for j = 1:length(Data)
        condition(j) = Data(j).Condition;
     end
     NeturalTrialnum = find(condition==0);
     ValidTrialnum = find(condition==1);
     
    fname=['sub',num2str(sub(i)),'_filter_ref_int_allepochs_removeICs.set'];
    EEG = pop_loadset('filename',fname,'filepath',pathin); 
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200    0]);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegthresh(EEG,1,channels,-75,75,-0.2,1.5,0,0);
    EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
    RejArtTrialnum = find(EEG.reject.rejglobal);
    ValidArtFreeTrialnum = setdiff(ValidTrialnum,RejArtTrialnum);
    NeturalArtFreeTrialnum = setdiff(NeturalTrialnum,RejArtTrialnum);
%     save([pathout 'sub',num2str(sub(i)),'_ArtificalTrialnum.mat'],'RejArtTrialnum','NeturalTrialnum','ValidTrialnum');
    for validnum =1:length(ValidArtFreeTrialnum)
                EEG.data(:,:,ValidArtFreeTrialnum(validnum)) = (EEG.data(:,:,ValidArtFreeTrialnum(validnum)) - squeeze(mean(EEG.data(:,:,ValidArtFreeTrialnum),3)));
    end
     for neturalnum =1:length(NeturalArtFreeTrialnum)
                EEG.data(:,:,NeturalArtFreeTrialnum(neturalnum)) = (EEG.data(:,:,NeturalArtFreeTrialnum(neturalnum)) - squeeze(mean(EEG.data(:,:,NeturalArtFreeTrialnum),3)));
     end   
    for cn=1:60
        tic
        channelnum=channels(cn);
        disp(['Processing subject ' num2str(sub(i)) ' out of Channel ' num2str(channelnum)]);
       for trialnum=1:EEG.trials
            [ersp itc powbase times frequencies]=newtimef( EEG.data(channelnum,:,trialnum), EEG.pnts, [EEG.xmin EEG.xmax], EEG.srate , [0] , 'baseline',[NaN],...
             'scale', 'abs', 'freqs', [[2 30]], 'timesout', 900, 'padratio', 4, 'winsize', 250, 'newfig', 'off', 'plotersp', 'off', 'plotitc', 'off', 'plotphasesign', 'off');
              ERSP(trialnum,:,:)=ersp;
              clear ersp itc powbase   
        end
        save([pathout,'Data_sub',num2str(sub(i)),'_channel',num2str(channelnum),'_singletrial_ERSP.mat'],'ERSP','times', 'frequencies');   
        clear ERSP
       toc
    end
%     NeturalERSP(i,:,:,:) = squeeze(mean(ERSP(:,NeturalArtFreeTrialnum,:,:),2));
%     ValidERSP(i,:,:,:) = squeeze(mean(ERSP(:,ValidArtFreeTrialnum,:,:),2));
    
   clear RejArtTrialnum Data condition ValidArtFreeTrialnum NeturalArtFreeTrialnum
end

