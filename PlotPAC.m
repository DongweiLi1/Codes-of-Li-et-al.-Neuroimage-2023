
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
            ampl=squeeze(mean(ValidalphaAmp([42:57 59 60 61],20:360,itrial),1));
            [~,binIdx]=histc(squeeze(mean(ValidthetaPhase([10],20:360,itrial),1)),binEdges);
            for bin=1:18
               if any(binIdx==bin)
                  amplBin(itrial,bin)=mean(ampl(binIdx==bin));
               end
            end
            
            clear ampl binIdx
        end 
        
    amp2Bin=zeros(size(NeutralalphaAmp,3),18);

        for itrial= 1:size(NeutralalphaAmp,3)
            amp2=squeeze(mean(NeutralalphaAmp([42:57 59 60 61],20:360,itrial),1));
            [~,binIdx]=histc(squeeze(mean(NeutralthetaPhase([10],20:360,itrial),1)),binEdges);
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


figure;
plot(mean(ValidThetaAlphaAmp,1)./norm(ValidThetaAlphaAmp),'r','LineWidth',1.5)
hold on;
plot(mean(NeturalThetaAlphaAmp,1)./norm(NeturalThetaAlphaAmp),'b','LineWidth',1.5)
for i=1:34
figure;
plot(ValidThetaAlphaAmp(9,:)./norm(ValidThetaAlphaAmp(9,:)),'r','LineWidth',1.5)
hold on;
plot(NeturalThetaAlphaAmp(9,:)./norm(NeturalThetaAlphaAmp(9,:)),'b','LineWidth',1.5)
end


clear all
clc

path='D:\WMprecision_load4\';
pathout='D:\WMprecision_load4\ERSP\noERP\';

binEdges=linspace(-pi,pi,18+1);
binCenters=binEdges(1:end-1)-diff(binEdges)/2;

sub=[2:5, 7:10, 12:17 20:36];
for n =1:length(sub)
    pathin = [path,'sub',num2str(sub(n)),'\'];
    load([pathin,'sub',num2str(sub(n)),'_Data_for_PAC.mat']); 
    load([pathout,'sub',num2str(sub(n)),'_ArtificalTrialnum.mat']);
    
    amplBin=zeros(size(LowGammaAmp,3),18);

        for itrial= 1:size(LowGammaAmp,3)
            ampl=squeeze(mean(LowGammaAmp([42 44 46 48 50 51 54 57 59 60 61],1076:1576,itrial),1));
            [~,binIdx]=histc(squeeze(mean(thetaPhase([10],1076:1576,itrial),1)),binEdges);
            for bin=1:18
               if any(binIdx==bin)
                  amplBin(itrial,bin)=mean(ampl(binIdx==bin));
               end
            end
            
            clear ampl binIdx
        end 
 
    
     NeturalArtFreeTrialnum = setdiff(NeturalTrialnum,RejArtTrialnum);
     ValidArtFreeTrialnum = setdiff(ValidTrialnum,RejArtTrialnum);
     
     NeturalDeltaAlphaAmp(n,:) = squeeze(mean(amplBin(NeturalArtFreeTrialnum,:),1));
     ValidDeltaAlphaAmp(n,:) = squeeze(mean(amplBin(ValidArtFreeTrialnum,:),1));
     clear NeturalArtFreeTrialnum ValidArtFreeTrialnum NeturalTrialnum RejArtTrialnum ValidTrialnum amplBin alphaAmp deltaPhase
    
end

% save([path,'Data_PAC.mat'],'NeturalThetaAlphaMI','ValidThetaAlphaMI', 'NeturalThetaBetaMI', 'ValidThetaBetaMI', 'NeturalThetaGammaMI', 'ValidThetaGammaMI', 'NeturalAlphaBetaMI', 'ValidAlphaBetaMI','NeturalAlphaGammaMI','ValidAlphaGammaMI','NeturalThetaAlphadistKL','ValidThetaAlphadistKL','NeturalThetaBetadistKL','ValidThetaBetadistKL','NeturalThetaGammadistKL','ValidThetaGammadistKL','NeturalAlphaBetadistKL','ValidAlphaBetadistKL','NeturalAlphaGammadistKL','ValidAlphaGammadistKL');   


figure;
plot(mean(ValidDeltaAlphaAmp,1)/sum(mean(ValidDeltaAlphaAmp,1)),'r','LineWidth',1.5)
hold on;
plot(mean(NeturalDeltaAlphaAmp,1)/sum(mean(NeturalDeltaAlphaAmp,1)),'b','LineWidth',1.5)



clear all
clc

path='D:\WMprecision_load4\';
pathout='D:\WMprecision_load4\ERSP\noERP\';

binEdges=linspace(-pi,pi,18+1);
binCenters=binEdges(1:end-1)-diff(binEdges)/2;

sub=[2:5, 7:10, 12:17 20:36];
for n =1:length(sub)
    pathin = [path,'sub',num2str(sub(n)),'\'];
    load([pathin,'sub',num2str(sub(n)),'_Data_for_PAC.mat']); 
    load([pathout,'sub',num2str(sub(n)),'_ArtificalTrialnum.mat']);
    
    amplBin=zeros(size(LowGammaAmp,3),18);

        for itrial= 1:size(LowGammaAmp,3)
            ampl=squeeze(mean(LowGammaAmp([42 44 46 48 50 51 54 57 59 60 61],1076:1576,itrial),1));
            [~,binIdx]=histc(squeeze(mean(alphaPhase([12],1076:1576,itrial),1)),binEdges);
            for bin=1:18
               if any(binIdx==bin)
                  amplBin(itrial,bin)=mean(ampl(binIdx==bin));
               end
            end
            
            clear ampl binIdx
        end 
 
    
     NeturalArtFreeTrialnum = setdiff(NeturalTrialnum,RejArtTrialnum);
     ValidArtFreeTrialnum = setdiff(ValidTrialnum,RejArtTrialnum);
     
     NeturalDeltaAlphaAmp(n,:) = squeeze(mean(amplBin(NeturalArtFreeTrialnum,:),1));
     ValidDeltaAlphaAmp(n,:) = squeeze(mean(amplBin(ValidArtFreeTrialnum,:),1));
     clear NeturalArtFreeTrialnum ValidArtFreeTrialnum NeturalTrialnum RejArtTrialnum ValidTrialnum amplBin alphaAmp deltaPhase
    
end

% save([path,'Data_PAC.mat'],'NeturalThetaAlphaMI','ValidThetaAlphaMI', 'NeturalThetaBetaMI', 'ValidThetaBetaMI', 'NeturalThetaGammaMI', 'ValidThetaGammaMI', 'NeturalAlphaBetaMI', 'ValidAlphaBetaMI','NeturalAlphaGammaMI','ValidAlphaGammaMI','NeturalThetaAlphadistKL','ValidThetaAlphadistKL','NeturalThetaBetadistKL','ValidThetaBetadistKL','NeturalThetaGammadistKL','ValidThetaGammadistKL','NeturalAlphaBetadistKL','ValidAlphaBetadistKL','NeturalAlphaGammadistKL','ValidAlphaGammadistKL');   


figure;
plot(mean(ValidDeltaAlphaAmp,1)/sum(mean(ValidDeltaAlphaAmp,1)),'r','LineWidth',1.5)
hold on;
plot(mean(NeturalDeltaAlphaAmp,1)/sum(mean(NeturalDeltaAlphaAmp,1)),'b','LineWidth',1.5)





clear all
clc

path='D:\H\WMprecision\';
pathout='E:\WMprecision\ERSP\noERP\';

binEdges=linspace(-pi,pi,18+1);
binCenters=binEdges(1:end-1)-diff(binEdges)/2;

sub=[1:6 8:14 17:36];
for n =1:length(sub)
    pathin = [path,'sub',num2str(sub(n)),'\'];
    load([pathin,'sub',num2str(sub(n)),'_Data_for_PAC.mat']); 
    load([pathout,'sub',num2str(sub(n)),'_ArtificalTrialnum.mat']);
    
    amplBin=zeros(size(alphaAmp,3),18);

        for itrial= 1:size(alphaAmp,3)
            ampl=squeeze(mean(alphaAmp([42:57 59 60 61],1201:1951,itrial),1));
            [~,binIdx]=histc(squeeze(mean(thetaPhase([10],1201:1951,itrial),1)),binEdges);
            for bin=1:18
               if any(binIdx==bin)
                  amplBin(itrial,bin)=mean(ampl(binIdx==bin));
               end
            end
            
            clear ampl binIdx
        end 
 
    if n<32
     NeturalArtFreeTrialnum = setdiff(NeturalTrialnum,RejArtTrialnum);
     ValidArtFreeTrialnum = setdiff(ValidTrialnum,RejArtTrialnum);
    else
     NeturalArtFreeTrialnum = setdiff(NeutralTrialNum,RejArtTrialnum);
     ValidArtFreeTrialnum = setdiff(ValidTrialNum,RejArtTrialnum);
    end        
     NeturalDeltaAlphaAmp(n,:) = squeeze(mean(amplBin(NeturalArtFreeTrialnum,:),1));
     ValidDeltaAlphaAmp(n,:) = squeeze(mean(amplBin(ValidArtFreeTrialnum,:),1));
     clear NeturalArtFreeTrialnum ValidArtFreeTrialnum NeturalTrialnum RejArtTrialnum ValidTrialnum amplBin alphaAmp deltaPhase
    
end

% save([path,'Data_PAC.mat'],'NeturalThetaAlphaMI','ValidThetaAlphaMI', 'NeturalThetaBetaMI', 'ValidThetaBetaMI', 'NeturalThetaGammaMI', 'ValidThetaGammaMI', 'NeturalAlphaBetaMI', 'ValidAlphaBetaMI','NeturalAlphaGammaMI','ValidAlphaGammaMI','NeturalThetaAlphadistKL','ValidThetaAlphadistKL','NeturalThetaBetadistKL','ValidThetaBetadistKL','NeturalThetaGammadistKL','ValidThetaGammadistKL','NeturalAlphaBetadistKL','ValidAlphaBetadistKL','NeturalAlphaGammadistKL','ValidAlphaGammadistKL');   


figure;
plot(mean(ValidDeltaAlphaAmp,1)/sum(mean(ValidDeltaAlphaAmp,1)),'r','LineWidth',1.5)
hold on;
plot(mean(NeturalDeltaAlphaAmp,1)/sum(mean(NeturalDeltaAlphaAmp,1)),'b','LineWidth',1.5)



