
clear all
close all
clc

path='E:\H\WMprecision\';
pathout='D:\WMprecision\ERSP\noERP\';
eeglab;
Vtrigger={'111','112','121','122'};
Ntrigger={'213','223'};
time=[-1.8         2.4];

sub=[34:36];  % tPBM dose 2
for i =1:length(sub)
    pathin = [path,'sub',num2str(sub(i)),'\'];
    fname=['sub',num2str(sub(i)),'_filter_ref_int_allepochs_removeICs.set'];
    EEG = pop_loadset('filename',fname,'filepath',pathin);
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, Vtrigger, time, 'newname',fname, 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200    0]);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
    EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
    EEG = pop_rejepoch_0(EEG);
    EEG = eeg_checkset( EEG );
    ValidData(:,:)=squeeze(mean(EEG.data,3));
    for epoch=1:size(EEG.data,3)     
        EEG.data(:,:,epoch)=EEG.data(:,:,epoch)-ValidData;
    end
    EEG = eeg_checkset( EEG );
    for channelnum=[1:57 59:61]
        [ersp itc powbase times frequencies]=pop_newtimef( EEG, 1,channelnum, [EEG.xmin*1000 EEG.xmax*1000],  [0] , 'baseline',[NaN],...
            'scale', 'abs', 'freqs', [[2 30]], 'ntimesout', 900, 'padratio', 4, 'winsize', 250, 'newfig', 'off', 'plotersp', 'off', 'plotitc', 'off', 'plotphasesign', 'off');
        ValidERSP(channelnum,:,:)=ersp;
        ValidITC(channelnum,:,:)=itc;
        clear ersp itc powbase
    end
    clear EEG ValidData
    
    EEG = pop_loadset('filename',fname,'filepath',pathin);
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200    0]);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
    EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
    EEG = pop_rejepoch_0(EEG);
    EEG = eeg_checkset( EEG );
    NeutralData(:,:)=squeeze(mean(EEG.data,3));
    for epoch=1:size(EEG.data,3)     
        EEG.data(:,:,epoch)=EEG.data(:,:,epoch)-NeutralData;
    end
    EEG = eeg_checkset( EEG );
    for channelnum=[1:57 59:61]
        [ersp itc powbase times frequencies]=pop_newtimef( EEG, 1,channelnum, [EEG.xmin*1000 EEG.xmax*1000],  [0] , 'baseline',[NaN],...
            'scale', 'abs', 'freqs', [[2 30]], 'ntimesout', 900, 'padratio', 4, 'winsize', 250, 'newfig', 'off', 'plotersp', 'off', 'plotitc', 'off', 'plotphasesign', 'off');
        NeturalERSP(channelnum,:,:)=ersp;
        NeturalITC(channelnum,:,:)=itc;
        clear ersp itc powbase
    end
    clear EEG NeutralData
 save([pathout,'Data_sub',num2str(sub(i)),'_ITC_noERP.mat'],'NeturalERSP','NeturalITC', 'ValidITC', 'ValidERSP');
      clear NeturalERSP NeturalITC ValidITC ValidERSP

end




clear all
close all
clc

path='E:\H\WMprecision\';
pathout='D:\WMprecision\ERSP\noERP\';
eeglab;
Vtrigger={'111','112','121','122'};
Ntrigger={'213','223'};
time=[-1.8         2.4];

sub=[1:6 8:14 16:33];  % tPBM dose 2
for i =1:length(sub)
    pathin = [path,'sub',num2str(sub(i)),'\'];
    fname=['sub',num2str(sub(i)),'_resample_ref_filt_allepochs_int_removeICs.set'];
    EEG = pop_loadset('filename',fname,'filepath',pathin);
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, Vtrigger, time, 'newname',fname, 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200    0]);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
    EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
    EEG = pop_rejepoch_0(EEG);
    EEG = eeg_checkset( EEG );
    ValidData(:,:)=squeeze(mean(EEG.data,3));
    for epoch=1:size(EEG.data,3)     
        EEG.data(:,:,epoch)=EEG.data(:,:,epoch)-ValidData;
    end
    EEG = eeg_checkset( EEG );
    for channelnum=[1:57 59:61]
        [ersp itc powbase times frequencies]=pop_newtimef( EEG, 1,channelnum, [EEG.xmin*1000 EEG.xmax*1000],  [0] , 'baseline',[NaN],...
            'scale', 'abs', 'freqs', [[2 30]], 'ntimesout', 900, 'padratio', 4, 'winsize', 128, 'newfig', 'off', 'plotersp', 'off', 'plotitc', 'off', 'plotphasesign', 'off');
        ValidERSP(channelnum,:,:)=ersp;
        ValidITC(channelnum,:,:)=itc;
        clear ersp itc powbase
    end
    clear EEG ValidData
    
    EEG = pop_loadset('filename',fname,'filepath',pathin);
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200    0]);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
    EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
    EEG = pop_rejepoch_0(EEG);
    EEG = eeg_checkset( EEG );
    NeutralData(:,:)=squeeze(mean(EEG.data,3));
    for epoch=1:size(EEG.data,3)     
        EEG.data(:,:,epoch)=EEG.data(:,:,epoch)-NeutralData;
    end
    EEG = eeg_checkset( EEG );
    for channelnum=[1:57 59:61]
        [ersp itc powbase times frequencies]=pop_newtimef( EEG, 1,channelnum, [EEG.xmin*1000 EEG.xmax*1000],  [0] , 'baseline',[NaN],...
            'scale', 'abs', 'freqs', [[2 30]], 'ntimesout', 900, 'padratio', 4, 'winsize', 128, 'newfig', 'off', 'plotersp', 'off', 'plotitc', 'off', 'plotphasesign', 'off');
        NeturalERSP(channelnum,:,:)=ersp;
        NeturalITC(channelnum,:,:)=itc;
        clear ersp itc powbase
    end
    clear EEG NeutralData
 save([pathout,'Data_sub',num2str(sub(i)),'_ITC_noERP.mat'],'NeturalERSP','NeturalITC', 'ValidITC', 'ValidERSP');
      clear NeturalERSP NeturalITC ValidITC ValidERSP

end



