
clear all
close all
clc

path='D:\WMprecision_load4\4Decoding\WM_LoadFour\Behavior\';
pathout='D:\WMprecision_load4\';
pout='D:\WMprecision_load4\Decoding\';
eeglab;
% trigger={'111','112','121','122','213','223'};
trigger={'131','132','133','134','235'};
time=[-1.9         2.5];

sub=[2:5 7:10 12:17 20:37];
for i =1:length(sub)
%     for freq = 2:30
    pathin = [pathout,'sub',num2str(sub(i)),'\'];
    load([path,'sub',num2str(sub(i)),'_Precision.mat']);
    load([path,'sub',num2str(sub(i)),'_TargetOri.mat']);
%     load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
     
    fname=['sub',num2str(sub(i)),'_filter_ref_int_allepochs_ICA_removeICs.set'];
    EEG = pop_loadset('filename',fname,'filepath',pathin); 
    EEG = eeg_checkset( EEG );
    EEG = pop_resample( EEG, 200);
    EEG = eeg_checkset( EEG );
%         EEG=pop_eegfiltnew(EEG,freq-1,freq+1,[],0,0,0);
%         EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200    0]);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
    EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
    RejArtTrialnum = find(EEG.reject.rejglobal);
    ValidArtfreeOri_7875 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri_7875);
    ValidArtfreeOri_5625 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri_5625);
    ValidArtfreeOri_3375 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri_3375);
    ValidArtfreeOri_1125 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri_1125);
    ValidArtfreeOri1125 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri1125);
    ValidArtfreeOri3375 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri3375);
    ValidArtfreeOri5625 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri5625);
    ValidArtfreeOri7875 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri7875);
    
    NeturalArtfreeOri_7875 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri_7875);
    NeturalArtfreeOri_5625 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri_5625);
    NeturalArtfreeOri_3375 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri_3375);
    NeturalArtfreeOri_1125 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri_1125);
    NeturalArtfreeOri1125 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri1125);
    NeturalArtfreeOri3375 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri3375);
    NeturalArtfreeOri5625 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri5625);
    NeturalArtfreeOri7875 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri7875);
%     save([pout 'sub',num2str(sub(i)),'_ArtificalFreeTrialnumforTargetDecoding_ERP.mat'],'ValidArtfreeOri_7875','ValidArtfreeOri_5625','ValidArtfreeOri_3375','ValidArtfreeOri_1125','ValidArtfreeOri1125','ValidArtfreeOri3375','ValidArtfreeOri5625','ValidArtfreeOri7875','NeturalArtfreeOri_7875','NeturalArtfreeOri_5625','NeturalArtfreeOri_3375','NeturalArtfreeOri_1125','NeturalArtfreeOri1125','NeturalArtfreeOri3375','NeturalArtfreeOri5625','NeturalArtfreeOri7875');
    binorgEEG.binwise_data(1).data=EEG.data(:,:,NeturalArtfreeOri_7875);
    binorgEEG.binwise_data(2).data=EEG.data(:,:,NeturalArtfreeOri_5625);
    binorgEEG.binwise_data(3).data=EEG.data(:,:,NeturalArtfreeOri_3375);
    binorgEEG.binwise_data(4).data=EEG.data(:,:,NeturalArtfreeOri_1125);
    binorgEEG.binwise_data(5).data=EEG.data(:,:,NeturalArtfreeOri1125);
    binorgEEG.binwise_data(6).data=EEG.data(:,:,NeturalArtfreeOri3375);
    binorgEEG.binwise_data(7).data=EEG.data(:,:,NeturalArtfreeOri5625);
    binorgEEG.binwise_data(8).data=EEG.data(:,:,NeturalArtfreeOri7875);
    
    binorgEEG.n_trials_this_bin(1)=length(NeturalArtfreeOri_7875);
    binorgEEG.n_trials_this_bin(2)=length(NeturalArtfreeOri_5625);
    binorgEEG.n_trials_this_bin(3)=length(NeturalArtfreeOri_3375);
    binorgEEG.n_trials_this_bin(4)=length(NeturalArtfreeOri_1125);
    binorgEEG.n_trials_this_bin(5)=length(NeturalArtfreeOri1125);
    binorgEEG.n_trials_this_bin(6)=length(NeturalArtfreeOri3375);
    binorgEEG.n_trials_this_bin(7)=length(NeturalArtfreeOri5625);
    binorgEEG.n_trials_this_bin(8)=length(NeturalArtfreeOri7875);
    
    save([pout 'sub',num2str(sub(i)),'_NeturalforTargetDecoding_ERP.mat'],'binorgEEG');
    clear binorgEEG
    binorgEEG.binwise_data(1).data=EEG.data(:,:,ValidArtfreeOri_7875);
    binorgEEG.binwise_data(2).data=EEG.data(:,:,ValidArtfreeOri_5625);
    binorgEEG.binwise_data(3).data=EEG.data(:,:,ValidArtfreeOri_3375);
    binorgEEG.binwise_data(4).data=EEG.data(:,:,ValidArtfreeOri_1125);
    binorgEEG.binwise_data(5).data=EEG.data(:,:,ValidArtfreeOri1125);
    binorgEEG.binwise_data(6).data=EEG.data(:,:,ValidArtfreeOri3375);
    binorgEEG.binwise_data(7).data=EEG.data(:,:,ValidArtfreeOri5625);
    binorgEEG.binwise_data(8).data=EEG.data(:,:,ValidArtfreeOri7875);
   
    binorgEEG.n_trials_this_bin(1)=length(ValidArtfreeOri_7875);
    binorgEEG.n_trials_this_bin(2)=length(ValidArtfreeOri_5625);
    binorgEEG.n_trials_this_bin(3)=length(ValidArtfreeOri_3375);
    binorgEEG.n_trials_this_bin(4)=length(ValidArtfreeOri_1125);
    binorgEEG.n_trials_this_bin(5)=length(ValidArtfreeOri1125);
    binorgEEG.n_trials_this_bin(6)=length(ValidArtfreeOri3375);
    binorgEEG.n_trials_this_bin(7)=length(ValidArtfreeOri5625);
    binorgEEG.n_trials_this_bin(8)=length(ValidArtfreeOri7875);
    
    save([pout 'sub',num2str(sub(i)),'_ValidforTargetDecoding_ERP.mat'],'binorgEEG');
    clear binorgEEG

    clear Data  ValidArtfreeOri_7875 ValidArtfreeOri_5625 ValidArtfreeOri_3375 ValidArtfreeOri_1125 ValidArtfreeOri1125 ValidArtfreeOri3375 ValidArtfreeOri5625 ValidArtfreeOri7875 NeturalArtfreeOri_7875 NeturalArtfreeOri_5625 NeturalArtfreeOri_3375 NeturalArtfreeOri_1125 NeturalArtfreeOri1125 NeturalArtfreeOri3375 NeturalArtfreeOri7875 NeturalArtfreeOri5625
%     end
    
end
    
    
% %     
% 
% clear all
% close all
% clc
% 
% path='E:\H\WMprecision\';
% pathout='D:\WMprecision\ERSP\noERP\';
% pout='E:\H\WMprecision\Decoding\';
% eeglab;
% trigger={'111','112','121','122','213','223'};
% time=[-1.5         2.3];
% 
% sub=[33];
% for i =1:length(sub)
%     for freq = 2:30
%     pathin = [path,'sub',num2str(sub(i)),'\'];
%     load([pathin,'sub',num2str(sub(i)),'_Precision.mat']);
%     load([pathin,'sub',num2str(sub(i)),'_DistractorOri.mat']);
%     load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
%      
%     fname=['sub',num2str(sub(i)),'_resample_ref_filt_allepochs_int_removeICs.set'];
%     EEG = pop_loadset('filename',fname,'filepath',pathin); 
%     EEG = eeg_checkset( EEG );
%     EEG = pop_resample( EEG, 200);
%     EEG = eeg_checkset( EEG );
%     EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
%     EEG = eeg_checkset( EEG );
%     EEG = pop_rmbase( EEG, [-200    0]);
%     EEG = eeg_checkset( EEG );
%     EEG = pop_eegthresh(EEG,1,[1:57 59:61],-75,75,-0.2,1.5,0,0);
%     EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%     RejArtTrialnum = find(EEG.reject.rejglobal);
%     ValidArtfreeOri_7875 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri_7875);
%     ValidArtfreeOri_5625 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri_5625);
%     ValidArtfreeOri_3375 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri_3375);
%     ValidArtfreeOri_1125 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri_1125);
%     ValidArtfreeOri1125 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri1125);
%     ValidArtfreeOri3375 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri3375);
%     ValidArtfreeOri5625 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri5625);
%     ValidArtfreeOri7875 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),ValidTargetOri7875);
%     
%     NeturalArtfreeOri_7875 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri_7875);
%     NeturalArtfreeOri_5625 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri_5625);
%     NeturalArtfreeOri_3375 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri_3375);
%     NeturalArtfreeOri_1125 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri_1125);
%     NeturalArtfreeOri1125 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri1125);
%     NeturalArtfreeOri3375 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri3375);
%     NeturalArtfreeOri5625 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri5625);
%     NeturalArtfreeOri7875 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),NeturalTargetOri7875);
% %     save([pout 'sub',num2str(sub(i)),'_ArtificalFreeTrialnumforDistractorDecoding_ERP.mat'],'ValidArtfreeOri_7875','ValidArtfreeOri_5625','ValidArtfreeOri_3375','ValidArtfreeOri_1125','ValidArtfreeOri1125','ValidArtfreeOri3375','ValidArtfreeOri5625','ValidArtfreeOri7875','NeturalArtfreeOri_7875','NeturalArtfreeOri_5625','NeturalArtfreeOri_3375','NeturalArtfreeOri_1125','NeturalArtfreeOri1125','NeturalArtfreeOri3375','NeturalArtfreeOri5625','NeturalArtfreeOri7875');
%     binorgEEG.binwise_data(1).data=EEG.data(:,:,NeturalArtfreeOri_7875);
%     binorgEEG.binwise_data(2).data=EEG.data(:,:,NeturalArtfreeOri_5625);
%     binorgEEG.binwise_data(3).data=EEG.data(:,:,NeturalArtfreeOri_3375);
%     binorgEEG.binwise_data(4).data=EEG.data(:,:,NeturalArtfreeOri_1125);
%     binorgEEG.binwise_data(5).data=EEG.data(:,:,NeturalArtfreeOri1125);
%     binorgEEG.binwise_data(6).data=EEG.data(:,:,NeturalArtfreeOri3375);
%     binorgEEG.binwise_data(7).data=EEG.data(:,:,NeturalArtfreeOri5625);
%     binorgEEG.binwise_data(8).data=EEG.data(:,:,NeturalArtfreeOri7875);
%     
%     binorgEEG.n_trials_this_bin(1)=length(NeturalArtfreeOri_7875);
%     binorgEEG.n_trials_this_bin(2)=length(NeturalArtfreeOri_5625);
%     binorgEEG.n_trials_this_bin(3)=length(NeturalArtfreeOri_3375);
%     binorgEEG.n_trials_this_bin(4)=length(NeturalArtfreeOri_1125);
%     binorgEEG.n_trials_this_bin(5)=length(NeturalArtfreeOri1125);
%     binorgEEG.n_trials_this_bin(6)=length(NeturalArtfreeOri3375);
%     binorgEEG.n_trials_this_bin(7)=length(NeturalArtfreeOri5625);
%     binorgEEG.n_trials_this_bin(8)=length(NeturalArtfreeOri7875);
%     
%     save([pout 'sub',num2str(sub(i)),'_NeturalforDistractorDecoding_ERP_',num2str(freq),'Hz.mat'],'binorgEEG');
%     clear binorgEEG
%     binorgEEG.binwise_data(1).data=EEG.data(:,:,ValidArtfreeOri_7875);
%     binorgEEG.binwise_data(2).data=EEG.data(:,:,ValidArtfreeOri_5625);
%     binorgEEG.binwise_data(3).data=EEG.data(:,:,ValidArtfreeOri_3375);
%     binorgEEG.binwise_data(4).data=EEG.data(:,:,ValidArtfreeOri_1125);
%     binorgEEG.binwise_data(5).data=EEG.data(:,:,ValidArtfreeOri1125);
%     binorgEEG.binwise_data(6).data=EEG.data(:,:,ValidArtfreeOri3375);
%     binorgEEG.binwise_data(7).data=EEG.data(:,:,ValidArtfreeOri5625);
%     binorgEEG.binwise_data(8).data=EEG.data(:,:,ValidArtfreeOri7875);
%    
%     binorgEEG.n_trials_this_bin(1)=length(ValidArtfreeOri_7875);
%     binorgEEG.n_trials_this_bin(2)=length(ValidArtfreeOri_5625);
%     binorgEEG.n_trials_this_bin(3)=length(ValidArtfreeOri_3375);
%     binorgEEG.n_trials_this_bin(4)=length(ValidArtfreeOri_1125);
%     binorgEEG.n_trials_this_bin(5)=length(ValidArtfreeOri1125);
%     binorgEEG.n_trials_this_bin(6)=length(ValidArtfreeOri3375);
%     binorgEEG.n_trials_this_bin(7)=length(ValidArtfreeOri5625);
%     binorgEEG.n_trials_this_bin(8)=length(ValidArtfreeOri7875);
%     
%     save([pout 'sub',num2str(sub(i)),'_ValidforDistractorDecoding_ERP_',num2str(freq),'Hz.mat'],'binorgEEG');
%     clear binorgEEG
% 
%     clear Data  ValidArtfreeOri_7875 ValidArtfreeOri_5625 ValidArtfreeOri_3375 ValidArtfreeOri_1125 ValidArtfreeOri1125 ValidArtfreeOri3375 ValidArtfreeOri5625 ValidArtfreeOri7875 NeturalArtfreeOri_7875 NeturalArtfreeOri_5625 NeturalArtfreeOri_3375 NeturalArtfreeOri_1125 NeturalArtfreeOri1125 NeturalArtfreeOri3375 NeturalArtfreeOri7875 NeturalArtfreeOri5625
%     end
%     
% end
%     
%     
%     
%     
%     
%     
%     
    
%     
% 
% clear all
% close all
% clc
% 
% path='E:\H\WMprecision\';
% pathout='D:\WMprecision\ERSP\noERP\';
% pout='E:\H\WMprecision\Decoding\';
% eeglab;
% trigger={'111','112','121','122','213','223'};
% time=[-1.5         2.3];
% 
% sub=[36];
% for i =1:length(sub)
%     for freq = 2:30
%     pathin = [path,'sub',num2str(sub(i)),'\'];
%     load([pathin,'sub',num2str(sub(i)),'_Precision.mat']);
%     load([pathin,'sub',num2str(sub(i)),'_TargetOri.mat']);
%     load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
%      
%     fname=['sub',num2str(sub(i)),'_filter_ref_int_allepochs_removeICs.set'];
%     EEG = pop_loadset('filename',fname,'filepath',pathin); 
%     EEG = eeg_checkset( EEG );
%     EEG = pop_resample( EEG, 200);
%     EEG = eeg_checkset( EEG );
%         EEG=pop_eegfiltnew(EEG,freq-1,freq+1,[],0,0,0);
%         EEG = eeg_checkset( EEG );
%     EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
%     EEG = eeg_checkset( EEG );
%     EEG = pop_rmbase( EEG, [-200    0]);
%     EEG = eeg_checkset( EEG );
% %     EEG = pop_eegthresh(EEG,1,[1:57 59:61],-75,75,-0.2,1.5,0,0);
% %     EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
% %     RejArtTrialnum = find(EEG.reject.rejglobal);
%     ValidArtfreeOri_7875 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri_7875);
%     ValidArtfreeOri_5625 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri_5625);
%     ValidArtfreeOri_3375 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri_3375);
%     ValidArtfreeOri_1125 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri_1125);
%     ValidArtfreeOri1125 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri1125);
%     ValidArtfreeOri3375 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri3375);
%     ValidArtfreeOri5625 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri5625);
%     ValidArtfreeOri7875 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri7875);
%     
%     NeturalArtfreeOri_7875 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri_7875);
%     NeturalArtfreeOri_5625 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri_5625);
%     NeturalArtfreeOri_3375 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri_3375);
%     NeturalArtfreeOri_1125 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri_1125);
%     NeturalArtfreeOri1125 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri1125);
%     NeturalArtfreeOri3375 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri3375);
%     NeturalArtfreeOri5625 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri5625);
%     NeturalArtfreeOri7875 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri7875);
% %     save([pout 'sub',num2str(sub(i)),'_ArtificalFreeTrialnumforTargetDecoding_ERP.mat'],'ValidArtfreeOri_7875','ValidArtfreeOri_5625','ValidArtfreeOri_3375','ValidArtfreeOri_1125','ValidArtfreeOri1125','ValidArtfreeOri3375','ValidArtfreeOri5625','ValidArtfreeOri7875','NeturalArtfreeOri_7875','NeturalArtfreeOri_5625','NeturalArtfreeOri_3375','NeturalArtfreeOri_1125','NeturalArtfreeOri1125','NeturalArtfreeOri3375','NeturalArtfreeOri5625','NeturalArtfreeOri7875');
%     binorgEEG.binwise_data(1).data=EEG.data(:,:,NeturalArtfreeOri_7875);
%     binorgEEG.binwise_data(2).data=EEG.data(:,:,NeturalArtfreeOri_5625);
%     binorgEEG.binwise_data(3).data=EEG.data(:,:,NeturalArtfreeOri_3375);
%     binorgEEG.binwise_data(4).data=EEG.data(:,:,NeturalArtfreeOri_1125);
%     binorgEEG.binwise_data(5).data=EEG.data(:,:,NeturalArtfreeOri1125);
%     binorgEEG.binwise_data(6).data=EEG.data(:,:,NeturalArtfreeOri3375);
%     binorgEEG.binwise_data(7).data=EEG.data(:,:,NeturalArtfreeOri5625);
%     binorgEEG.binwise_data(8).data=EEG.data(:,:,NeturalArtfreeOri7875);
%     
%     binorgEEG.n_trials_this_bin(1)=length(NeturalArtfreeOri_7875);
%     binorgEEG.n_trials_this_bin(2)=length(NeturalArtfreeOri_5625);
%     binorgEEG.n_trials_this_bin(3)=length(NeturalArtfreeOri_3375);
%     binorgEEG.n_trials_this_bin(4)=length(NeturalArtfreeOri_1125);
%     binorgEEG.n_trials_this_bin(5)=length(NeturalArtfreeOri1125);
%     binorgEEG.n_trials_this_bin(6)=length(NeturalArtfreeOri3375);
%     binorgEEG.n_trials_this_bin(7)=length(NeturalArtfreeOri5625);
%     binorgEEG.n_trials_this_bin(8)=length(NeturalArtfreeOri7875);
%     
%     save([pout 'sub',num2str(sub(i)),'_NeturalforTargetDecoding_ERP_',num2str(freq),'Hz.mat'],'binorgEEG');
%     clear binorgEEG
%     binorgEEG.binwise_data(1).data=EEG.data(:,:,ValidArtfreeOri_7875);
%     binorgEEG.binwise_data(2).data=EEG.data(:,:,ValidArtfreeOri_5625);
%     binorgEEG.binwise_data(3).data=EEG.data(:,:,ValidArtfreeOri_3375);
%     binorgEEG.binwise_data(4).data=EEG.data(:,:,ValidArtfreeOri_1125);
%     binorgEEG.binwise_data(5).data=EEG.data(:,:,ValidArtfreeOri1125);
%     binorgEEG.binwise_data(6).data=EEG.data(:,:,ValidArtfreeOri3375);
%     binorgEEG.binwise_data(7).data=EEG.data(:,:,ValidArtfreeOri5625);
%     binorgEEG.binwise_data(8).data=EEG.data(:,:,ValidArtfreeOri7875);
%    
%     binorgEEG.n_trials_this_bin(1)=length(ValidArtfreeOri_7875);
%     binorgEEG.n_trials_this_bin(2)=length(ValidArtfreeOri_5625);
%     binorgEEG.n_trials_this_bin(3)=length(ValidArtfreeOri_3375);
%     binorgEEG.n_trials_this_bin(4)=length(ValidArtfreeOri_1125);
%     binorgEEG.n_trials_this_bin(5)=length(ValidArtfreeOri1125);
%     binorgEEG.n_trials_this_bin(6)=length(ValidArtfreeOri3375);
%     binorgEEG.n_trials_this_bin(7)=length(ValidArtfreeOri5625);
%     binorgEEG.n_trials_this_bin(8)=length(ValidArtfreeOri7875);
%     
%     save([pout 'sub',num2str(sub(i)),'_ValidforTargetDecoding_ERP_',num2str(freq),'Hz.mat'],'binorgEEG');
%     clear binorgEEG
% 
%     clear Data  ValidArtfreeOri_7875 ValidArtfreeOri_5625 ValidArtfreeOri_3375 ValidArtfreeOri_1125 ValidArtfreeOri1125 ValidArtfreeOri3375 ValidArtfreeOri5625 ValidArtfreeOri7875 NeturalArtfreeOri_7875 NeturalArtfreeOri_5625 NeturalArtfreeOri_3375 NeturalArtfreeOri_1125 NeturalArtfreeOri1125 NeturalArtfreeOri3375 NeturalArtfreeOri7875 NeturalArtfreeOri5625
%     end
%     
% end
%     
%     
%     
% 
% clear all
% close all
% clc
% 
% path='E:\H\WMprecision\';
% pathout='D:\WMprecision\ERSP\noERP\';
% pout='E:\H\WMprecision\Decoding\';
% eeglab;
% trigger={'111','112','121','122','213','223'};
% time=[-1.5         2.3];
% 
% sub=[34:36];
% for i =1:length(sub)
%     for freq = 2:30
%     pathin = [path,'sub',num2str(sub(i)),'\'];
%     load([pathin,'sub',num2str(sub(i)),'_Precision.mat']);
%     load([pathin,'sub',num2str(sub(i)),'_DistractorOri.mat']);
%     load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
%      
%     fname=['sub',num2str(sub(i)),'_filter_ref_int_allepochs_removeICs.set'];
%     EEG = pop_loadset('filename',fname,'filepath',pathin); 
%     EEG = eeg_checkset( EEG );
%     EEG = pop_resample( EEG, 200);
%     EEG = eeg_checkset( EEG );
%     EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
%     EEG = eeg_checkset( EEG );
%     EEG = pop_rmbase( EEG, [-200    0]);
%     EEG = eeg_checkset( EEG );
%     EEG = pop_eegthresh(EEG,1,[1:57 59:61],-75,75,-0.2,1.5,0,0);
%     EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%     RejArtTrialnum = find(EEG.reject.rejglobal);
%     ValidArtfreeOri_7875 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri_7875);
%     ValidArtfreeOri_5625 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri_5625);
%     ValidArtfreeOri_3375 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri_3375);
%     ValidArtfreeOri_1125 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri_1125);
%     ValidArtfreeOri1125 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri1125);
%     ValidArtfreeOri3375 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri3375);
%     ValidArtfreeOri5625 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri5625);
%     ValidArtfreeOri7875 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),ValidTargetOri7875);
%     
%     NeturalArtfreeOri_7875 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri_7875);
%     NeturalArtfreeOri_5625 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri_5625);
%     NeturalArtfreeOri_3375 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri_3375);
%     NeturalArtfreeOri_1125 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri_1125);
%     NeturalArtfreeOri1125 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri1125);
%     NeturalArtfreeOri3375 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri3375);
%     NeturalArtfreeOri5625 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri5625);
%     NeturalArtfreeOri7875 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),NeturalTargetOri7875);
% %     save([pout 'sub',num2str(sub(i)),'_ArtificalFreeTrialnumforDistractorDecoding_ERP.mat'],'ValidArtfreeOri_7875','ValidArtfreeOri_5625','ValidArtfreeOri_3375','ValidArtfreeOri_1125','ValidArtfreeOri1125','ValidArtfreeOri3375','ValidArtfreeOri5625','ValidArtfreeOri7875','NeturalArtfreeOri_7875','NeturalArtfreeOri_5625','NeturalArtfreeOri_3375','NeturalArtfreeOri_1125','NeturalArtfreeOri1125','NeturalArtfreeOri3375','NeturalArtfreeOri5625','NeturalArtfreeOri7875');
%     binorgEEG.binwise_data(1).data=EEG.data(:,:,NeturalArtfreeOri_7875);
%     binorgEEG.binwise_data(2).data=EEG.data(:,:,NeturalArtfreeOri_5625);
%     binorgEEG.binwise_data(3).data=EEG.data(:,:,NeturalArtfreeOri_3375);
%     binorgEEG.binwise_data(4).data=EEG.data(:,:,NeturalArtfreeOri_1125);
%     binorgEEG.binwise_data(5).data=EEG.data(:,:,NeturalArtfreeOri1125);
%     binorgEEG.binwise_data(6).data=EEG.data(:,:,NeturalArtfreeOri3375);
%     binorgEEG.binwise_data(7).data=EEG.data(:,:,NeturalArtfreeOri5625);
%     binorgEEG.binwise_data(8).data=EEG.data(:,:,NeturalArtfreeOri7875);
%     
%     binorgEEG.n_trials_this_bin(1)=length(NeturalArtfreeOri_7875);
%     binorgEEG.n_trials_this_bin(2)=length(NeturalArtfreeOri_5625);
%     binorgEEG.n_trials_this_bin(3)=length(NeturalArtfreeOri_3375);
%     binorgEEG.n_trials_this_bin(4)=length(NeturalArtfreeOri_1125);
%     binorgEEG.n_trials_this_bin(5)=length(NeturalArtfreeOri1125);
%     binorgEEG.n_trials_this_bin(6)=length(NeturalArtfreeOri3375);
%     binorgEEG.n_trials_this_bin(7)=length(NeturalArtfreeOri5625);
%     binorgEEG.n_trials_this_bin(8)=length(NeturalArtfreeOri7875);
%     
%     save([pout 'sub',num2str(sub(i)),'_NeturalforDistractorDecoding_ERP_',num2str(freq),'Hz.mat'],'binorgEEG');
%     clear binorgEEG
%     binorgEEG.binwise_data(1).data=EEG.data(:,:,ValidArtfreeOri_7875);
%     binorgEEG.binwise_data(2).data=EEG.data(:,:,ValidArtfreeOri_5625);
%     binorgEEG.binwise_data(3).data=EEG.data(:,:,ValidArtfreeOri_3375);
%     binorgEEG.binwise_data(4).data=EEG.data(:,:,ValidArtfreeOri_1125);
%     binorgEEG.binwise_data(5).data=EEG.data(:,:,ValidArtfreeOri1125);
%     binorgEEG.binwise_data(6).data=EEG.data(:,:,ValidArtfreeOri3375);
%     binorgEEG.binwise_data(7).data=EEG.data(:,:,ValidArtfreeOri5625);
%     binorgEEG.binwise_data(8).data=EEG.data(:,:,ValidArtfreeOri7875);
%    
%     binorgEEG.n_trials_this_bin(1)=length(ValidArtfreeOri_7875);
%     binorgEEG.n_trials_this_bin(2)=length(ValidArtfreeOri_5625);
%     binorgEEG.n_trials_this_bin(3)=length(ValidArtfreeOri_3375);
%     binorgEEG.n_trials_this_bin(4)=length(ValidArtfreeOri_1125);
%     binorgEEG.n_trials_this_bin(5)=length(ValidArtfreeOri1125);
%     binorgEEG.n_trials_this_bin(6)=length(ValidArtfreeOri3375);
%     binorgEEG.n_trials_this_bin(7)=length(ValidArtfreeOri5625);
%     binorgEEG.n_trials_this_bin(8)=length(ValidArtfreeOri7875);
%     
%     save([pout 'sub',num2str(sub(i)),'_ValidforDistractorDecoding_ERP_',num2str(freq),'Hz.mat'],'binorgEEG');
%     clear binorgEEG
% 
%     clear Data  ValidArtfreeOri_7875 ValidArtfreeOri_5625 ValidArtfreeOri_3375 ValidArtfreeOri_1125 ValidArtfreeOri1125 ValidArtfreeOri3375 ValidArtfreeOri5625 ValidArtfreeOri7875 NeturalArtfreeOri_7875 NeturalArtfreeOri_5625 NeturalArtfreeOri_3375 NeturalArtfreeOri_1125 NeturalArtfreeOri1125 NeturalArtfreeOri3375 NeturalArtfreeOri7875 NeturalArtfreeOri5625
%     end
%     
% end
%     
%     
%     
%     
%     
%     
%     
%     
%     
