
clear all
close all
clc

path='D:\H\WMprecision\';
pathout='E:\WMprecision\ERSP\noERP\';
eeglab;
Vtrigger={'111','112','121','122'};
Ntrigger={'213','223'};
time=[-1.8         2.4];

sub=[1:6 8:14,16:33]; 

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
        EEG = pop_rejepoch_0( EEG);
        EEG=pop_eegfiltnew(EEG,3,7,[],0,0,0);
        for channelnum=[1:57 59:61]
            for trialnum =1:size(EEG.data,3)
                x= hilbert(EEG.data(channelnum,:,trialnum));
                ValidthetaPhase(channelnum,:,trialnum)=angle(x(462:846));
                clear x
            end
        end
%         clear EEG
%         EEG = pop_loadset('filename',fname,'filepath',pathin);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_epoch( EEG, Vtrigger, time, 'newname',fname, 'epochinfo', 'yes');
%         EEG = eeg_checkset( EEG );
%         EEG = pop_rmbase( EEG, [-200    0]);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
%         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%         EEG = pop_rejepoch_0( EEG);
%         EEG=pop_eegfiltnew(EEG,8,12,[],0,0,0);
%         for channelnum=[1:57 59:61]
%             for trialnum =1:size(EEG.data,3)
%                 x= hilbert(EEG.data(channelnum,462:846,trialnum));
%                 ValidalphaPhase(channelnum,:,trialnum)=angle(x);
%                 clear x
%             end
%         end
%         clear EEG
%         EEG = pop_loadset('filename',fname,'filepath',pathin);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_epoch( EEG, Vtrigger, time, 'newname',fname, 'epochinfo', 'yes');
%         EEG = eeg_checkset( EEG );
%         EEG = pop_rmbase( EEG, [-200    0]);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
%         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%         EEG = pop_rejepoch_0( EEG);
%         EEG=pop_eegfiltnew(EEG,15,25,[],0,0,0);
%         for channelnum=[1:57 59:61]
%             for trialnum =1:size(EEG.data,3)
%                 x= hilbert(EEG.data(channelnum,462:846,trialnum));
%                 ValidbetaAmp(channelnum,:,trialnum)=abs(x);
%                 clear x
%             end
%         end
%         clear EEG        
%         
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, Vtrigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
        EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        EEG = pop_rejepoch_0( EEG);
        EEG=pop_eegfiltnew(EEG,8,12,[],0,0,0);
        for channelnum=[1:57 59:61]
            for trialnum =1:size(EEG.data,3)
                x= hilbert(EEG.data(channelnum,:,trialnum));
                ValidalphaAmp(channelnum,:,trialnum)=abs(x(462:846));
                clear x
            end
        end
        clear EEG        
        
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
        EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        EEG = pop_rejepoch_0( EEG);
        EEG=pop_eegfiltnew(EEG,3,7,[],0,0,0);
        for channelnum=[1:57 59:61]
            for trialnum =1:size(EEG.data,3)
                x= hilbert(EEG.data(channelnum,:,trialnum));
                NeutralthetaPhase(channelnum,:,trialnum)=angle(x(462:846));
                clear x
            end
        end
        clear EEG
        
%         EEG = pop_loadset('filename',fname,'filepath',pathin);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
%         EEG = eeg_checkset( EEG );
%         EEG = pop_rmbase( EEG, [-200    0]);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
%         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%         EEG = pop_rejepoch_0( EEG);
%         EEG=pop_eegfiltnew(EEG,8,12,[],0,0,0);
%         for channelnum=[1:57 59:61]
%             for trialnum =1:size(EEG.data,3)
%                 x= hilbert(EEG.data(channelnum,462:846,trialnum));
%                 NeutralalphaPhase(channelnum,:,trialnum)=angle(x);
%                 clear x
%             end
%         end
%         clear EEG
%         
%         EEG = pop_loadset('filename',fname,'filepath',pathin);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
%         EEG = eeg_checkset( EEG );
%         EEG = pop_rmbase( EEG, [-200    0]);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
%         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%         EEG = pop_rejepoch_0( EEG);
%         EEG=pop_eegfiltnew(EEG,15,25,[],0,0,0);
%         for channelnum=[1:57 59:61]
%             for trialnum =1:size(EEG.data,3)
%                 x= hilbert(EEG.data(channelnum,462:846,trialnum));
%                 NeutralbetaAmp(channelnum,:,trialnum)=abs(x);
%                 clear x
%             end
%         end
%         clear EEG        
%         
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
        EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        EEG = pop_rejepoch_0( EEG);
        EEG=pop_eegfiltnew(EEG,8,12,[],0,0,0);
        for channelnum=[1:57 59:61]
            for trialnum =1:size(EEG.data,3)
                x= hilbert(EEG.data(channelnum,:,trialnum));
                NeutralalphaAmp(channelnum,:,trialnum)=abs(x(462:846));
                clear x
            end
        end
        clear EEG       
       
       save([pathout,'Data_sub',num2str(sub(i)),'_forPAC.mat'],'ValidthetaPhase', 'ValidalphaAmp', 'NeutralthetaPhase', 'NeutralalphaAmp');

end

clear all
close all
clc

path='D:\H\WMprecision\';
pathout='E:\WMprecision\ERSP\noERP\';
eeglab;
Vtrigger={'111','112','121','122'};
Ntrigger={'213','223'};
time=[-1.8         2.4];

sub=[34:36]; 

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
        EEG = pop_rejepoch_0( EEG);
        EEG=pop_eegfiltnew(EEG,3,7,[],0,0,0);
        for channelnum=[1:57 59:61]
            for trialnum =1:size(EEG.data,3)
                x= hilbert(EEG.data(channelnum,:,trialnum));
                ValidthetaPhase(channelnum,:,trialnum)=angle(x(901:1651));
                clear x
            end
        end
        clear EEG
%         EEG = pop_loadset('filename',fname,'filepath',pathin);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_epoch( EEG, Vtrigger, time, 'newname',fname, 'epochinfo', 'yes');
%         EEG = eeg_checkset( EEG );
%         EEG = pop_rmbase( EEG, [-200    0]);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
%         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%         EEG = pop_rejepoch_0( EEG);
%         EEG=pop_eegfiltnew(EEG,8,12,[],0,0,0);
%         for channelnum=[1:57 59:61]
%             for trialnum =1:size(EEG.data,3)
%                 x= hilbert(EEG.data(channelnum,901:1651,trialnum));
%                 ValidalphaPhase(channelnum,:,trialnum)=angle(x);
%                 clear x
%             end
%         end
%         clear EEG
%         EEG = pop_loadset('filename',fname,'filepath',pathin);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_epoch( EEG, Vtrigger, time, 'newname',fname, 'epochinfo', 'yes');
%         EEG = eeg_checkset( EEG );
%         EEG = pop_rmbase( EEG, [-200    0]);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
%         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%         EEG = pop_rejepoch_0( EEG);
%         EEG=pop_eegfiltnew(EEG,15,25,[],0,0,0);
%         for channelnum=[1:57 59:61]
%             for trialnum =1:size(EEG.data,3)
%                 x= hilbert(EEG.data(channelnum,901:1651,trialnum));
%                 ValidbetaAmp(channelnum,:,trialnum)=abs(x);
%                 clear x
%             end
%         end
%         clear EEG        
%         
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, Vtrigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
        EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        EEG = pop_rejepoch_0( EEG);
        EEG=pop_eegfiltnew(EEG,8,12,[],0,0,0);
        for channelnum=[1:57 59:61]
            for trialnum =1:size(EEG.data,3)
                x= hilbert(EEG.data(channelnum,:,trialnum));
                ValidalphaAmp(channelnum,:,trialnum)=abs(x(901:1651));
                clear x
            end
        end
        clear EEG        
        
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
        EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        EEG = pop_rejepoch_0( EEG);
        EEG=pop_eegfiltnew(EEG,3,7,[],0,0,0);
        for channelnum=[1:57 59:61]
            for trialnum =1:size(EEG.data,3)
                x= hilbert(EEG.data(channelnum,:,trialnum));
                NeutralthetaPhase(channelnum,:,trialnum)=angle(x(901:1651));
                clear x
            end
        end
        clear EEG
        
%         EEG = pop_loadset('filename',fname,'filepath',pathin);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
%         EEG = eeg_checkset( EEG );
%         EEG = pop_rmbase( EEG, [-200    0]);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
%         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%         EEG = pop_rejepoch_0( EEG);
%         EEG=pop_eegfiltnew(EEG,8,12,[],0,0,0);
%         for channelnum=[1:57 59:61]
%             for trialnum =1:size(EEG.data,3)
%                 x= hilbert(EEG.data(channelnum,901:1651,trialnum));
%                 NeutralalphaPhase(channelnum,:,trialnum)=angle(x);
%                 clear x
%             end
%         end
%         clear EEG
%         
%         EEG = pop_loadset('filename',fname,'filepath',pathin);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
%         EEG = eeg_checkset( EEG );
%         EEG = pop_rmbase( EEG, [-200    0]);
%         EEG = eeg_checkset( EEG );
%         EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
%         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
%         EEG = pop_rejepoch_0( EEG);
%         EEG=pop_eegfiltnew(EEG,15,25,[],0,0,0);
%         for channelnum=[1:57 59:61]
%             for trialnum =1:size(EEG.data,3)
%                 x= hilbert(EEG.data(channelnum,901:1651,trialnum));
%                 NeutralbetaAmp(channelnum,:,trialnum)=abs(x);
%                 clear x
%             end
%         end
%         clear EEG        
%         
        EEG = pop_loadset('filename',fname,'filepath',pathin);
        EEG = eeg_checkset( EEG );
        EEG = pop_epoch( EEG, Ntrigger, time, 'newname',fname, 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, [-200    0]);
        EEG = eeg_checkset( EEG );
        EEG = pop_eegthresh(EEG,1,[1:57 59:61],-80,80,-0.2,1.5,0,0);
        EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
        EEG = pop_rejepoch_0( EEG);
        EEG=pop_eegfiltnew(EEG,8,12,[],0,0,0);
        for channelnum=[1:57 59:61]
            for trialnum =1:size(EEG.data,3)
                x= hilbert(EEG.data(channelnum,:,trialnum));
                NeutralalphaAmp(channelnum,:,trialnum)=abs(x(901:1651));
                clear x
            end
        end
        clear EEG       
       
       save([pathout,'Data_sub',num2str(sub(i)),'_forPAC.mat'],'ValidthetaPhase', 'ValidalphaAmp', 'NeutralthetaPhase',  'NeutralalphaAmp');

end


clear all
close all
clc

path='E:\WMprecision\ERSP\noERP\';
% pathout='D:\WMprecision_load4\ERSP\noERP\';

binEdges=linspace(-pi,pi,18+1);
binCenters=binEdges(1:end-1)-diff(binEdges)/2;

sub=[1:6 8:14 16:36];
for n =1:length(sub)
%     pathin = [path,'sub',num2str(sub(n)),'\'];
    load([path,'Data_sub',num2str(sub(n)),'_forPAC.mat']); 
%     load([pathout,'sub',num2str(sub(n)),'_ArtificalTrialnum.mat']);
    
    amplBin=zeros(size(ValidalphaAmp,3),18);

        for itrial= 1:size(ValidalphaAmp,3)
            ampl=squeeze(mean(ValidalphaAmp([42:57 59 60 61],:,itrial),1));
            [~,binIdx]=histc(squeeze(mean(ValidthetaPhase([10],:,itrial),1)),binEdges);
            for bin=1:18
               if any(binIdx==bin)
                  amplBin(itrial,bin)=mean(ampl(binIdx==bin));
               end
            end
            
            clear ampl binIdx
        end 
        
    amp2Bin=zeros(size(NeutralalphaAmp,3),18);

        for itrial= 1:size(NeutralalphaAmp,3)
            amp2=squeeze(mean(NeutralalphaAmp([42:57 59 60 61],:,itrial),1));
            [~,binIdx]=histc(squeeze(mean(NeutralthetaPhase([10],:,itrial),1)),binEdges);
            for bin=1:18
               if any(binIdx==bin)
                  amp2Bin(itrial,bin)=mean(amp2(binIdx==bin));
               end
            end
            
            clear amp2 binIdx
        end  
%     
%      NeturalArtFreeTrialnum = setdiff(NeturalTrialnum,RejArtTrialnum);
%      ValidArtFreeTrialnum = setdiff(ValidTrialnum,RejArtTrialnum);
     
     NeturalThetaAlphaAmp(n,:) = squeeze(mean(amp2Bin,1));
     ValidThetaAlphaAmp(n,:) = squeeze(mean(amplBin,1));
     clear amplBin amp2Bin NeutralthetaPhase NeutralalphaAmp ValidthetaPhase ValidalphaAmp
    
end

% save([path,'Data_PAC.mat'],'NeturalThetaAlphaMI','ValidThetaAlphaMI', 'NeturalThetaBetaMI', 'ValidThetaBetaMI', 'NeturalThetaGammaMI', 'ValidThetaGammaMI', 'NeturalAlphaBetaMI', 'ValidAlphaBetaMI','NeturalAlphaGammaMI','ValidAlphaGammaMI','NeturalThetaAlphadistKL','ValidThetaAlphadistKL','NeturalThetaBetadistKL','ValidThetaBetadistKL','NeturalThetaGammadistKL','ValidThetaGammadistKL','NeturalAlphaBetadistKL','ValidAlphaBetadistKL','NeturalAlphaGammadistKL','ValidAlphaGammadistKL');   

figure;
plot(mean(ValidThetaAlphaAmp([1:8 10:34],:),1)/sum(mean(ValidThetaAlphaAmp([1:8 10:34],:),1)),'r','LineWidth',1.5)
hold on;
plot(mean(NeturalThetaAlphaAmp([1:8 10:34],:),1)/sum(mean(NeturalThetaAlphaAmp([1:8 10:34],:),1)),'b','LineWidth',1.5)
