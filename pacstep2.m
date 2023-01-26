
clear all
close all
clc

path='D:\WMprecision\ERSP\noERP\';
pathout='D:\WMprecision\ERSP\noERP\';

sub=[1:6 8:14,16:36]; 

for n =1:length(sub)
%     pathin = [path,'sub',num2str(sub(n)),'\'];
    load([path,'Data_sub',num2str(sub(n)),'_forPAC.mat']); 
%     load([pathout,'sub',num2str(sub(n)),'_ArtificalTrialnum.mat']);
    for channel=1:61
        for itrial= 1:size(NeutralalphaAmp,3)
            [NeturalthetaalphaMI_9(channel,itrial),NeturalthetaalphadistKL_9(channel,itrial)]=modulationIndex(NeutralalphaAmp(channel,:,itrial),NeutralthetaPhase(9,:,itrial));
            [NeturalthetaalphaMI_11(channel,itrial),NeturalthetaalphadistKL_11(channel,itrial)]=modulationIndex(NeutralalphaAmp(channel,:,itrial),NeutralthetaPhase(11,:,itrial));
            [NeturalthetaalphaMI_18(channel,itrial),NeturalthetaalphadistKL_18(channel,itrial)]=modulationIndex(NeutralalphaAmp(channel,:,itrial),NeutralthetaPhase(18,:,itrial));
            [NeturalthetaalphaMI_19(channel,itrial),NeturalthetaalphadistKL_19(channel,itrial)]=modulationIndex(NeutralalphaAmp(channel,:,itrial),NeutralthetaPhase(19,:,itrial));
            [NeturalthetaalphaMI_20(channel,itrial),NeturalthetaalphadistKL_20(channel,itrial)]=modulationIndex(NeutralalphaAmp(channel,:,itrial),NeutralthetaPhase(20,:,itrial));
%             [NeturalthetabetaMI(channel,itrial),NeturalthetabetadistKL(channel,itrial)]=modulationIndex(NeutralbetaAmp(channel,:,itrial),NeutralthetaPhase(10,:,itrial));
%             [NeturalalphabetaMI(channel,itrial),NeturalalphabetadistKL(channel,itrial)]=modulationIndex(NeutralbetaAmp(channel,:,itrial),NeutralalphaPhase(10,:,itrial));
        end 
    end
    for channel=1:61
        for itrial= 1:size(ValidalphaAmp,3)
            [ValidthetaalphaMI_9(channel,itrial),ValidthetaalphadistKL_9(channel,itrial)]=modulationIndex(ValidalphaAmp(channel,:,itrial),ValidthetaPhase(9,:,itrial));
            [ValidthetaalphaMI_11(channel,itrial),ValidthetaalphadistKL_11(channel,itrial)]=modulationIndex(ValidalphaAmp(channel,:,itrial),ValidthetaPhase(11,:,itrial));
            [ValidthetaalphaMI_18(channel,itrial),ValidthetaalphadistKL_18(channel,itrial)]=modulationIndex(ValidalphaAmp(channel,:,itrial),ValidthetaPhase(18,:,itrial));
            [ValidthetaalphaMI_19(channel,itrial),ValidthetaalphadistKL_19(channel,itrial)]=modulationIndex(ValidalphaAmp(channel,:,itrial),ValidthetaPhase(19,:,itrial));
            [ValidthetaalphaMI_20(channel,itrial),ValidthetaalphadistKL_20(channel,itrial)]=modulationIndex(ValidalphaAmp(channel,:,itrial),ValidthetaPhase(20,:,itrial));
%             [ValidthetabetaMI(channel,itrial),ValidthetabetadistKL(channel,itrial)]=modulationIndex(ValidbetaAmp(channel,:,itrial),ValidthetaPhase(10,:,itrial));
%             [ValidalphabetaMI(channel,itrial),ValidalphabetadistKL(channel,itrial)]=modulationIndex(ValidbetaAmp(channel,:,itrial),ValidalphaPhase(10,:,itrial));
        end 
    end
   
    subNeturalThetaAlphaMI_9(n,:) = squeeze(mean(NeturalthetaalphaMI_9,2));
    subNeturalThetaAlphaMI_11(n,:) = squeeze(mean(NeturalthetaalphaMI_11,2));
    subNeturalThetaAlphaMI_18(n,:) = squeeze(mean(NeturalthetaalphaMI_18,2));
    subNeturalThetaAlphaMI_19(n,:) = squeeze(mean(NeturalthetaalphaMI_19,2));
    subNeturalThetaAlphaMI_20(n,:) = squeeze(mean(NeturalthetaalphaMI_20,2));
%     subNeturalThetaBetaMI(n,:) = squeeze(mean(NeturalthetabetaMI,2));
%     subNeturalAlphaBetaMI(n,:) = squeeze(mean(NeturalalphabetaMI,2));
    subValidThetaAlphaMI_9(n,:) = squeeze(mean(ValidthetaalphaMI_9,2));
    subValidThetaAlphaMI_11(n,:) = squeeze(mean(ValidthetaalphaMI_11,2));
    subValidThetaAlphaMI_18(n,:) = squeeze(mean(ValidthetaalphaMI_18,2));
    subValidThetaAlphaMI_19(n,:) = squeeze(mean(ValidthetaalphaMI_19,2));
    subValidThetaAlphaMI_20(n,:) = squeeze(mean(ValidthetaalphaMI_20,2));
%     subValidThetaBetaMI(n,:) = squeeze(mean(ValidthetabetaMI,2));
%     subValidAlphaBetaMI(n,:) = squeeze(mean(ValidalphabetaMI,2));
    
    subNeturalthetaalphadistKL_9(n,:) = squeeze(mean(NeturalthetaalphadistKL_9,2));
    subNeturalthetaalphadistKL_11(n,:) = squeeze(mean(NeturalthetaalphadistKL_11,2));
    subNeturalthetaalphadistKL_18(n,:) = squeeze(mean(NeturalthetaalphadistKL_18,2));
    subNeturalthetaalphadistKL_19(n,:) = squeeze(mean(NeturalthetaalphadistKL_19,2));
    subNeturalthetaalphadistKL_20(n,:) = squeeze(mean(NeturalthetaalphadistKL_20,2));
%     subNeturalthetabetadistKL(n,:) = squeeze(mean(NeturalthetabetadistKL,2));
%     subNeturalalphabetadistKL(n,:) = squeeze(mean(NeturalalphabetadistKL,2));
    subValidthetaalphadistKL_9(n,:) = squeeze(mean(ValidthetaalphadistKL_9,2));
    subValidthetaalphadistKL_11(n,:) = squeeze(mean(ValidthetaalphadistKL_11,2));
    subValidthetaalphadistKL_18(n,:) = squeeze(mean(ValidthetaalphadistKL_18,2));
    subValidthetaalphadistKL_19(n,:) = squeeze(mean(ValidthetaalphadistKL_19,2));
    subValidthetaalphadistKL_20(n,:) = squeeze(mean(ValidthetaalphadistKL_20,2));
%     subValidthetabetadistKL(n,:) = squeeze(mean(ValidthetabetadistKL,2));
%     subValidalphabetadistKL(n,:) = squeeze(mean(ValidalphabetadistKL,2));
    
%   clear ValidalphabetadistKL NeturalthetaalphadistKL NeturalthetabetadistKL NeturalalphabetadistKL ValidthetaalphadistKL ValidthetabetadistKL NeturalthetaalphaMI NeturalthetabetaMI NeturalalphabetaMI ValidthetaalphaMI ValidthetabetaMI ValidalphabetaMI NeutralalphaAmp NeutralbetaAmp ValidalphaAmp ValidbetaAmp ValidthetaPhase ValidalphaPhase NeutralthetaPhase NeutralalphaPhase
  clear NeturalthetaalphaMI_9 ValidthetaalphaMI_9 NeturalthetaalphadistKL_9 ValidthetaalphadistKL_9  
  clear NeturalthetaalphaMI_11 ValidthetaalphaMI_11 NeturalthetaalphadistKL_11 ValidthetaalphadistKL_11  
  clear NeturalthetaalphaMI_18 ValidthetaalphaMI_18 NeturalthetaalphadistKL_18 ValidthetaalphadistKL_18  
  clear NeturalthetaalphaMI_19 ValidthetaalphaMI_19 NeturalthetaalphadistKL_19 ValidthetaalphadistKL_19  
  clear NeturalthetaalphaMI_20 ValidthetaalphaMI_20 NeturalthetaalphadistKL_20 ValidthetaalphadistKL_20  

  
  
  

%      NeturalArtFreeTrialnum = setdiff(NeturalTrialnum,RejArtTrialnum);
%      ValidArtFreeTrialnum = setdiff(ValidTrialnum,RejArtTrialnum);
     
%      NeturalDeltaAlphaMI(n,:) = squeeze(mean(deltaalphaMI(:,NeturalArtFreeTrialnum),2));
%      NeturalDeltaAlphadistKL(n,:) = squeeze(mean(deltaalphadistKL(:,NeturalArtFreeTrialnum),2));
%      ValidDeltaAlphaMI(n,:) = squeeze(mean(deltaalphaMI(:,ValidArtFreeTrialnum),2));
%      ValidDeltaAlphadistKL(n,:) = squeeze(mean(deltaalphadistKL(:,ValidArtFreeTrialnum),2));
%      
%      NeturalThetaAlphaMI(n,:) = squeeze(mean(thetaalphaMI(:,NeturalArtFreeTrialnum),2));
%      NeturalThetaAlphadistKL(n,:) = squeeze(mean(thetaalphadistKL(:,NeturalArtFreeTrialnum),2));
%      ValidThetaAlphaMI(n,:) = squeeze(mean(thetaalphaMI(:,ValidArtFreeTrialnum),2));
%      ValidThetaAlphadistKL(n,:) = squeeze(mean(thetaalphadistKL(:,ValidArtFreeTrialnum),2));
% 
%      NeturalThetaBetaMI(n,:) = squeeze(mean(thetabetaMI(:,NeturalArtFreeTrialnum),2));
%      NeturalThetaBetadistKL(n,:) = squeeze(mean(thetabetadistKL(:,NeturalArtFreeTrialnum),2));
%      ValidThetaBetaMI(n,:) = squeeze(mean(thetabetaMI(:,ValidArtFreeTrialnum),2));
%      ValidThetaBetadistKL(n,:) = squeeze(mean(thetabetadistKL(:,ValidArtFreeTrialnum),2));

%      NeturalThetaGammaMI(n,:) = squeeze(mean(thetagammaMI(:,NeturalArtFreeTrialnum),2));
%      NeturalThetaGammadistKL(n,:) = squeeze(mean(thetagammadistKL(:,NeturalArtFreeTrialnum),2));
%      ValidThetaGammaMI(n,:) = squeeze(mean(thetagammaMI(:,ValidArtFreeTrialnum),2));
%      ValidThetaGammadistKL(n,:) = squeeze(mean(thetagammadistKL(:,ValidArtFreeTrialnum),2));
% 
%      NeturalAlphaBetaMI(n,:) = squeeze(mean(alphabetaMI(:,NeturalArtFreeTrialnum),2));
%      NeturalAlphaBetadistKL(n,:) = squeeze(mean(alphabetadistKL(:,NeturalArtFreeTrialnum),2));
%      ValidAlphaBetaMI(n,:) = squeeze(mean(alphabetaMI(:,ValidArtFreeTrialnum),2));
%      ValidAlphaBetadistKL(n,:) = squeeze(mean(alphabetadistKL(:,ValidArtFreeTrialnum),2));
% 
%      NeturalAlphaGammaMI(n,:) = squeeze(mean(alphagammaMI(:,NeturalArtFreeTrialnum),2));
%      NeturalAlphaGammadistKL(n,:) = squeeze(mean(alphagammadistKL(:,NeturalArtFreeTrialnum),2));
%      ValidAlphaGammaMI(n,:) = squeeze(mean(alphagammaMI(:,ValidArtFreeTrialnum),2));
%      ValidAlphaGammadistKL(n,:) = squeeze(mean(alphagammadistKL(:,ValidArtFreeTrialnum),2));
%      clear NeturalArtFreeTrialnum ValidArtFreeTrialnum NeturalTrialnum RejArtTrialnum ValidTrialnum deltaalphaMI deltaalphadistKL alphagammaMI alphabetaMI thetagammaMI thetabetaMI thetaalphaMI thetaalphadistKL thetabetadistKL thetagammadistKL alphabetadistKL alphagammadistKL
%      clear alphaAmp betaAmp gammaAmp thetaPhase alphaPhase gammaPhase thetaAmp deltaPhase deltaAmp
end
save([path,'Data_PAC_FtoPcoupling_moreF.mat'],'subNeturalThetaAlphaMI_9', 'subValidThetaAlphaMI_9','subNeturalthetaalphadistKL_9','subValidthetaalphadistKL_9','subNeturalThetaAlphaMI_11', 'subValidThetaAlphaMI_11','subNeturalthetaalphadistKL_11','subValidthetaalphadistKL_11','subNeturalThetaAlphaMI_18', 'subValidThetaAlphaMI_18','subNeturalthetaalphadistKL_18','subValidthetaalphadistKL_18','subNeturalThetaAlphaMI_19', 'subValidThetaAlphaMI_19','subNeturalthetaalphadistKL_19','subValidthetaalphadistKL_19','subNeturalThetaAlphaMI_20', 'subValidThetaAlphaMI_20','subNeturalthetaalphadistKL_20','subValidthetaalphadistKL_20');   


function [MI,distKL]=modulationIndex(ampl,phas,nBins)
%
% function [MI,distKL]=modulationIndex(phas,ampl,nBins)
%
% Computes the Modulation Index (MI), a measure of the amount of
% phase-amplitude coupling between two signals. Phase angles are expected 
% to be in radians. MI is derived from the Kullbach-Leibner distance, which
% is the second, optional, output of the function. The third, optional, 
% input to the function is the number of bins in which to discretize phase 
% (default: 18 bins, giving a 20-degree resolution).
%
% Ref.:
% Tort AB, Komorowski R, Eichenbaum H, Kopell N. Measuring phase-amplitude
% coupling between neuronal oscillations of different frequencies. J
% Neurophysiol. 2010 Aug;104(2):1195-210. doi: 10.1152/jn.00106.2010. Epub
% 2010 May 12. Erratum in: J Neurophysiol. 2010 Oct;104(4):2302. PubMed
% PMID: 20463205; PubMed Central PMCID: PMC2941206.
%
% Example:
%
%   phas=rand(100,1)*2*pi-pi;
%   ampl=randn(100,1)*30+100;
%   [MI,distKL]=modulationIndex(ampl,phas);
%
% pierre.megevand@gmail.com


%% parse inputs
if nargin<2
    error('At least 2 inputs (phase and amplitude) need to be provided.');
end

if ~isvector(phas)||~isvector(ampl)|| ...
        ~isnumeric(phas)||~isnumeric(ampl)|| ...
        length(phas)~=length(ampl)
    error('The phase and amplitude inputs need to be numeric vectors of the same length.');
end

if nargin<3
    nBins=18; % default value
else
    if ~isscalar(nBins)||nBins<=0||rem(nBins,1)~=0
        error('The number of bins must be a natural number above 0.');
    end
end


%% bin the amplitudes according to the phases

binEdges=linspace(-pi,pi,nBins+1);
binCenters=binEdges(1:end-1)-diff(binEdges)/2;

% [phasSort,phasSortIdx]=sort(phas);
% amplSort=ampl(phasSortIdx);
% [n,bin]=histc(phasSort,linspace(-pi,pi,nBins));

[~,binIdx]=histc(phas,binEdges);

amplBin=zeros(1,nBins);
for bin=1:nBins
    if any(binIdx==bin)
        amplBin(bin)=mean(ampl(binIdx==bin));
    end
end

amplP=amplBin/sum(amplBin);

%bar([binCenters binCenters+2*pi],[amplP amplP]);

%% compute Kullback-Leibler distance and modulation index (MI)

amplQ=ones(1,nBins)./nBins;

% amplP=amplQ;
% amplP=[1 zeros(1,nBins-1)];

% in the special case where observed probability in a bin is 0, this tweak
% allows computing a meaningful KL distance nonetheless
if any(amplP==0)
    amplP(amplP==0)=eps;
end

distKL=sum(amplP.*log(amplP./amplQ));

MI=distKL./log(nBins);
end

