
clear all
close all
clc

path='D:\H\WMprecision\';
pathout='E:\WMprecision\ERSP\noERP\';
pout='E:\WMprecision\Decoding\';
eeglab;
trigger={'111','112','121','122','213','223'};
time=[-0.2         2.3];
Clr = [21;234;197;133];

sub=[1:6 8:14 16:33];
for i =1:length(sub)
    for freq = 3:30
        pathin = [path,'sub',num2str(sub(i)),'\'];
        load([pathin,'sub',num2str(sub(i)),'_Precision.mat']);
        %   load([pathin,'sub',num2str(sub(i)),'_TargetOri.mat']);
        load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
        
        for itrial = 1:length(Data)
            if Data(itrial).TestClr(1)==Data(itrial).Leftcolor(1)
               ClrIds(itrial)=find(Data(itrial).Rightcolor(1)==Clr);
            elseif Data(itrial).TestClr(1)==Data(itrial).Rightcolor(1)
               ClrIds(itrial)=find(Data(itrial).Leftcolor(1)==Clr);
            end
        end
        fname=['sub',num2str(sub(i)),'_resample_ref_filt_allepochs_int_removeICs.set'];
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_resample( EEG, 200);
        EEG = eeg_checkset( EEG );
        EEG=pop_eegfiltnew(EEG,freq-1,freq+1,[],0,0,0);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        %     EEG = pop_eegthresh(EEG,1,1:62,-75,75,-0.2,1.5,0,0);
        %     EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        %     RejArtTrialnum = find(EEG.reject.rejglobal);
        ValidArtfreeColor1 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),find(ClrIds == 1));
        ValidArtfreeColor2 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),find(ClrIds == 2));
        ValidArtfreeColor3 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),find(ClrIds == 3));
        ValidArtfreeColor4 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),find(ClrIds == 4));
        
        NeturalArtfreeColor1 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),find(ClrIds == 1));
        NeturalArtfreeColor2 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),find(ClrIds == 2));
        NeturalArtfreeColor3 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),find(ClrIds == 3));
        NeturalArtfreeColor4 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),find(ClrIds == 4));
        %     save([pout 'sub',num2str(sub(i)),'_TrialnumforColorDecoding.mat'],'ValidArtfreeColor1','ValidArtfreeColor2','ValidArtfreeColor3','ValidArtfreeColor4','NeturalArtfreeColor1','NeturalArtfreeColor2','NeturalArtfreeColor3','NeturalArtfreeColor4');
        binorgEEG.binwise_data(1).data=EEG.data(:,:,NeturalArtfreeColor1);
        binorgEEG.binwise_data(2).data=EEG.data(:,:,NeturalArtfreeColor2);
        binorgEEG.binwise_data(3).data=EEG.data(:,:,NeturalArtfreeColor3);
        binorgEEG.binwise_data(4).data=EEG.data(:,:,NeturalArtfreeColor4);
        
        binorgEEG.n_trials_this_bin(1)=length(NeturalArtfreeColor1);
        binorgEEG.n_trials_this_bin(2)=length(NeturalArtfreeColor2);
        binorgEEG.n_trials_this_bin(3)=length(NeturalArtfreeColor3);
        binorgEEG.n_trials_this_bin(4)=length(NeturalArtfreeColor4);
        
        save([pout 'sub',num2str(sub(i)),'_NeturalforColorDecoding_',num2str(freq),'Hz.mat'],'binorgEEG');
        clear binorgEEG
        binorgEEG.binwise_data(1).data=EEG.data(:,:,ValidArtfreeColor1);
        binorgEEG.binwise_data(2).data=EEG.data(:,:,ValidArtfreeColor2);
        binorgEEG.binwise_data(3).data=EEG.data(:,:,ValidArtfreeColor3);
        binorgEEG.binwise_data(4).data=EEG.data(:,:,ValidArtfreeColor4);
        
        binorgEEG.n_trials_this_bin(1)=length(ValidArtfreeColor1);
        binorgEEG.n_trials_this_bin(2)=length(ValidArtfreeColor2);
        binorgEEG.n_trials_this_bin(3)=length(ValidArtfreeColor3);
        binorgEEG.n_trials_this_bin(4)=length(ValidArtfreeColor4);
        
        save([pout 'sub',num2str(sub(i)),'_ValidforColorDecoding_',num2str(freq),'Hz.mat'],'binorgEEG');
        clear binorgEEG
        
        clear Data ClrIds ValidArtfreeColor1 ValidArtfreeColor2 ValidArtfreeColor3 ValidArtfreeColor4 NeturalArtfreeColor1 NeturalArtfreeColor2 ValidArtfreeColor3 NeturalArtfreeColor4
    end
    
end



clear all
close all
clc

path='E:\H\WMprecision\';
pathout='D:\WMprecision\ERSP\noERP\';
pout='D:\WMprecision\Decoding\';
eeglab;
trigger={'111','112','121','122','213','223'};
time=[-0.2         2.3];

sub=[1:6 8:14 16:33];
for i =1:length(sub)
    for freq = 3:30
        pathin = [path,'sub',num2str(sub(i)),'\'];
        load([pathin,'sub',num2str(sub(i)),'_Precision.mat']);
        %     load([pathin,'sub',num2str(sub(i)),'_TargetOri.mat']);
        load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
        
        for itrial = 1:length(Data)
            if Data(itrial).AnswerAng == Data(itrial).LeftOri
                OriIds(itrial)=1;
            else
                OriIds(itrial)=2;
            end
        end
        fname=['sub',num2str(sub(i)),'_resample_ref_filt_allepochs_int_removeICs.set'];
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_resample( EEG, 200);
        EEG = eeg_checkset( EEG );
        EEG=pop_eegfiltnew(EEG,freq-1,freq+1,[],0,0,0);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        %     EEG = pop_eegthresh(EEG,1,1:62,-75,75,-0.2,1.5,0,0);
        %     EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        %     RejArtTrialnum = find(EEG.reject.rejglobal);
        ValidArtfreeOri1 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),find(OriIds == 1));
        ValidArtfreeOri2 = intersect(setdiff(ValidTrialnum,RejArtTrialnum),find(OriIds == 2));
        
        NeturalArtfreeOri1 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),find(OriIds == 1));
        NeturalArtfreeOri2 = intersect(setdiff(NeturalTrialnum,RejArtTrialnum),find(OriIds == 2));
        %     save([pout 'sub',num2str(sub(i)),'_TrialnumforSpaceDecoding.mat'],'ValidArtfreeOri1','ValidArtfreeOri2','NeturalArtfreeOri1','NeturalArtfreeOri2');
        binorgEEG.binwise_data(1).data=EEG.data(:,:,NeturalArtfreeOri1);
        binorgEEG.binwise_data(2).data=EEG.data(:,:,NeturalArtfreeOri2);
        
        binorgEEG.n_trials_this_bin(1)=length(NeturalArtfreeOri1);
        binorgEEG.n_trials_this_bin(2)=length(NeturalArtfreeOri2);
        
        save([pout 'sub',num2str(sub(i)),'_NeturalforSpaceDecoding_',num2str(freq),'Hz.mat'],'binorgEEG');
        clear binorgEEG
        binorgEEG.binwise_data(1).data=EEG.data(:,:,ValidArtfreeOri1);
        binorgEEG.binwise_data(2).data=EEG.data(:,:,ValidArtfreeOri2);
        
        binorgEEG.n_trials_this_bin(1)=length(ValidArtfreeOri1);
        binorgEEG.n_trials_this_bin(2)=length(ValidArtfreeOri2);
        
        save([pout 'sub',num2str(sub(i)),'_ValidforSpaceDecoding_',num2str(freq),'Hz.mat'],'binorgEEG');
        clear binorgEEG
        
        clear Data OriIds ValidArtfreeOri1 ValidArtfreeOri2 NeturalArtfreeOri1 NeturalArtfreeOri2
    end
    
end




clear all
close all
clc

path='E:\H\WMprecision\';
pathout='D:\WMprecision\ERSP\noERP\';
pout='D:\WMprecision\Decoding\';
eeglab;
trigger={'111','112','121','122','213','223'};
time=[-0.2         2.3];
Clr = [21;234;197;133];

sub=[34:36];
for i =1:length(sub)
    for freq = 3:30
        pathin = [path,'sub',num2str(sub(i)),'\'];
        load([pathin,'sub',num2str(sub(i)),'_Precision.mat']);
        %   load([pathin,'sub',num2str(sub(i)),'_TargetOri.mat']);
        load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
        
        for itrial = 1:length(Data)
            ClrIds(itrial)=find(Data(itrial).TestClr(1)==Clr);
        end
        fname=['sub',num2str(sub(i)),'_filter_ref_int_allepochs_removeICs.set'];
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_resample( EEG, 200);
        EEG = eeg_checkset( EEG );
        EEG=pop_eegfiltnew(EEG,freq-1,freq+1,[],0,0,0);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        %     EEG = pop_eegthresh(EEG,1,1:62,-75,75,-0.2,1.5,0,0);
        %     EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        %     RejArtTrialnum = find(EEG.reject.rejglobal);
        ValidArtfreeColor1 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),find(ClrIds == 1));
        ValidArtfreeColor2 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),find(ClrIds == 2));
        ValidArtfreeColor3 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),find(ClrIds == 3));
        ValidArtfreeColor4 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),find(ClrIds == 4));
        
        NeturalArtfreeColor1 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),find(ClrIds == 1));
        NeturalArtfreeColor2 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),find(ClrIds == 2));
        NeturalArtfreeColor3 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),find(ClrIds == 3));
        NeturalArtfreeColor4 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),find(ClrIds == 4));
        %     save([pout 'sub',num2str(sub(i)),'_TrialnumforColorDecoding.mat'],'ValidArtfreeColor1','ValidArtfreeColor2','ValidArtfreeColor3','ValidArtfreeColor4','NeturalArtfreeColor1','NeturalArtfreeColor2','NeturalArtfreeColor3','NeturalArtfreeColor4');
        binorgEEG.binwise_data(1).data=EEG.data(:,:,NeturalArtfreeColor1);
        binorgEEG.binwise_data(2).data=EEG.data(:,:,NeturalArtfreeColor2);
        binorgEEG.binwise_data(3).data=EEG.data(:,:,NeturalArtfreeColor3);
        binorgEEG.binwise_data(4).data=EEG.data(:,:,NeturalArtfreeColor4);
        
        binorgEEG.n_trials_this_bin(1)=length(NeturalArtfreeColor1);
        binorgEEG.n_trials_this_bin(2)=length(NeturalArtfreeColor2);
        binorgEEG.n_trials_this_bin(3)=length(NeturalArtfreeColor3);
        binorgEEG.n_trials_this_bin(4)=length(NeturalArtfreeColor4);
        
        save([pout 'sub',num2str(sub(i)),'_NeturalforColorDecoding_',num2str(freq),'Hz.mat'],'binorgEEG');
        clear binorgEEG
        binorgEEG.binwise_data(1).data=EEG.data(:,:,ValidArtfreeColor1);
        binorgEEG.binwise_data(2).data=EEG.data(:,:,ValidArtfreeColor2);
        binorgEEG.binwise_data(3).data=EEG.data(:,:,ValidArtfreeColor3);
        binorgEEG.binwise_data(4).data=EEG.data(:,:,ValidArtfreeColor4);
        
        binorgEEG.n_trials_this_bin(1)=length(ValidArtfreeColor1);
        binorgEEG.n_trials_this_bin(2)=length(ValidArtfreeColor2);
        binorgEEG.n_trials_this_bin(3)=length(ValidArtfreeColor3);
        binorgEEG.n_trials_this_bin(4)=length(ValidArtfreeColor4);
        
        save([pout 'sub',num2str(sub(i)),'_ValidforColorDecoding_',num2str(freq),'Hz.mat'],'binorgEEG');
        clear binorgEEG
        
        clear Data ClrIds ValidArtfreeColor1 ValidArtfreeColor2 ValidArtfreeColor3 ValidArtfreeColor4 NeturalArtfreeColor1 NeturalArtfreeColor2 ValidArtfreeColor3 NeturalArtfreeColor4
    end
    
end



clear all
close all
clc

path='E:\H\WMprecision\';
pathout='D:\WMprecision\ERSP\noERP\';
pout='D:\WMprecision\Decoding\';
eeglab;
trigger={'111','112','121','122','213','223'};
time=[-0.2         2.3];

sub=[34:36];
for i =1:length(sub)
    for freq = 3:30
        pathin = [path,'sub',num2str(sub(i)),'\'];
        load([pathin,'sub',num2str(sub(i)),'_Precision.mat']);
        %     load([pathin,'sub',num2str(sub(i)),'_TargetOri.mat']);
        load([pathout,'sub',num2str(sub(i)),'_ArtificalTrialnum.mat']);
        
        for itrial = 1:length(Data)
            if Data(itrial).AnswerAng == Data(itrial).LeftOri
                OriIds(itrial)=1;
            else
                OriIds(itrial)=2;
            end
        end
        fname=['sub',num2str(sub(i)),'_filter_ref_int_allepochs_removeICs.set'];
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_resample( EEG, 200);
        EEG = eeg_checkset( EEG );
        EEG=pop_eegfiltnew(EEG,freq-1,freq+1,[],0,0,0);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, trigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        %     EEG = pop_eegthresh(EEG,1,1:62,-75,75,-0.2,1.5,0,0);
        %     EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        %     RejArtTrialnum = find(EEG.reject.rejglobal);
        ValidArtfreeOri1 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),find(OriIds == 1));
        ValidArtfreeOri2 = intersect(setdiff(ValidTrialNum,RejArtTrialnum),find(OriIds == 2));
        
        NeturalArtfreeOri1 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),find(OriIds == 1));
        NeturalArtfreeOri2 = intersect(setdiff(NeutralTrialNum,RejArtTrialnum),find(OriIds == 2));
        %     save([pout 'sub',num2str(sub(i)),'_TrialnumforSpaceDecoding.mat'],'ValidArtfreeOri1','ValidArtfreeOri2','NeturalArtfreeOri1','NeturalArtfreeOri2');
        binorgEEG.binwise_data(1).data=EEG.data(:,:,NeturalArtfreeOri1);
        binorgEEG.binwise_data(2).data=EEG.data(:,:,NeturalArtfreeOri2);
        
        binorgEEG.n_trials_this_bin(1)=length(NeturalArtfreeOri1);
        binorgEEG.n_trials_this_bin(2)=length(NeturalArtfreeOri2);
        
        save([pout 'sub',num2str(sub(i)),'_NeturalforSpaceDecoding_',num2str(freq),'Hz.mat'],'binorgEEG');
        clear binorgEEG
        binorgEEG.binwise_data(1).data=EEG.data(:,:,ValidArtfreeOri1);
        binorgEEG.binwise_data(2).data=EEG.data(:,:,ValidArtfreeOri2);
        
        binorgEEG.n_trials_this_bin(1)=length(ValidArtfreeOri1);
        binorgEEG.n_trials_this_bin(2)=length(ValidArtfreeOri2);
        
        save([pout 'sub',num2str(sub(i)),'_ValidforSpaceDecoding_',num2str(freq),'Hz.mat'],'binorgEEG');
        clear binorgEEG
        
        clear Data OriIds ValidArtfreeOri1 ValidArtfreeOri2 NeturalArtfreeOri1 NeturalArtfreeOri2
    end
    
end



