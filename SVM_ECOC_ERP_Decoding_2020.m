% 
clear    

%  function SVM_ECOC_ERP_Decoding(subs)

% Parallelization: This script utilizes Matlab parallelization ...
% if parallelization is not possible, change "parfor" to "for-loop"
delete(gcp)
parpool


%% Subject List: 
%  if nargin ==0
    
subs=[2 4 5 7:10 12 14:17 20:23 25:37];

%  end

nSubs = length(subs); %number of subjects

%% Subject Filename(s)

% Load Subject Datafiles 
dataLocation = pwd; % set directory of data set (default: pwd)
fName = ['\sub']; % subject filename (subject # appended at end)

% Save Decoding results
saveLocation = pwd; % set save directory of data set (default: pwd)
savName = ['\ValidDecoding_ERPbased_Target_']; 

%% Parameters to set
% Main structure is svmECOC. The output file is composed of svmECOC struct

svmECOC.nBins = 8; % # of stimulus bins

svmECOC.nIter = 10; % # of iterations

svmECOC.nBlocks = 3; % # of blocks for cross-validation

svmECOC.dataTime.pre = -1900; % Set epoch start (from imported data)
svmECOC.dataTime.post = 2495; % Set epoch end (from imported data)

svmECOC.time = -1900:20:2495; % time points of interest in the analysis
% the time-points of interest is a resampling of preprocessed data
% the time steps (20ms) here change the data to 1 data point per 20ms

% Timepoints/sampling rate of preprocessed/loaded data
svmECOC.window = 5; % 1 data point per 4 ms in the preprocessed data
svmECOC.Fs = 200; % samplring rate of in the preprocessed data for filtering

% Equalalize trials across bins? 
equalT = 1; % equal trials acr bin = 1; use as many trials within bin = 0

% The electrode channel list is mapped 1:1 with respect to your 
% electrode channel configuration (e.g., channel 1 is FP1 in our EEG cap)
% Check if the label for each electrode corresponds to the electrode
% labeling of your own EEG system
%ReleventChan = sort([1:91]); %electrodes
 ReleventChan = sort([1:57 59:61]); %electrodes
% here, we removed external EOG electrodes & mastoid ref, for 27 electrodes

svmECOC.nElectrodes = length(ReleventChan); % # of electrode included in the analysis


% for brevity in analysis
nBins = svmECOC.nBins;

ogWin = svmECOC.window;

nIter = svmECOC.nIter;

nBlocks = svmECOC.nBlocks;

dataTime = svmECOC.dataTime;

times = svmECOC.time;

nElectrodes = svmECOC.nElectrodes;

nSamps = length(svmECOC.time);


%% Step 9: Loop through participants
for s = 1:nSubs %decoding is performed within each subject independently
    sn = subs(s);
    
    %progress output to command window
    fprintf('Subject:\t%d\n',sn)
    
    %% Parameters to set per subject 
    currentSub = num2str(sn);
    loadThis = strcat(dataLocation,fName,currentSub,'_ValidforTargetDecoding_ERP.mat');
    % where to save decoding output file name. 
    % File (.mat) will contain decoding results.
    OutputfName = strcat(saveLocation,savName,currentSub,'.mat');
    
    
    %% Data Loading/preallocation per subject 
    % loads bin_organized data
    load(loadThis)
    
    % grab EEG data from bin-list organized data 
    eegs = binorgEEG.binwise_data;
    nPerBin = binorgEEG.n_trials_this_bin;
    
    % set up time points
    % we create index of timpoint of interests from original data
    tois = ismember(dataTime.pre:ogWin:dataTime.post,svmECOC.time); 
    
    % # of trials
    svmECOC.nTrials = (sum(nPerBin)); 
    
    % Preallocate Matrices
    svm_predict = nan(nIter,nSamps,nBlocks,nBins); % a matrix to save prediction from SVM
    tst_target = nan(nIter,nSamps,nBlocks,nBins);  % a matrix to save true target values
    
    % create svmECOC.block structure to save block assignments
    svmECOC.blocks=struct();
    
    if nBins ~= max(size(eegs))
        error('Error. nBins dne # of bins in dataset!');
        % Code to be used on a bin-epoched dataset for one
        % class only (e.g. Orientation). Users may
        % try to bin multiple classes in one BDF.
        % This is not currently allowed.
    end
    
    
    %% Step 8: Loop through each iteration with random shuffling
    tic % start timing iteration loop
    
    for iter = 1:nIter
        
        %% Obtaining AVG. EEG (ERP spatial dist) 
        % within each block at each time point 
        % stored in blockDat_filtData
        
        %preallocate & rewrite per each iteration      
        blockDat_filtData = nan(nBins*nBlocks,nElectrodes,nSamps);   
        labels = nan(nBins*nBlocks,1);     % bin labels for averaged & filtered EEG data
        blockNum = nan(nBins*nBlocks,1);   % block numbers for averaged & filtered EEG data
        bCnt = 1; %initialize binblock counter 
        
        % this code operates and creates ERPs at each bin 
        % and organizes that into approprate block 
        
        %% shuffling, binning, & averaging
        for bin = 1:nBins 
            
            if equalT == 1 %equal trials across bins 
                % find bin with fewest trial
                minCnt = min(nPerBin);
                
                % max # of trials such that # of trials for each bin ...
                % can be equated within each block 
                nPerBinBlock = floor(minCnt/nBlocks); 
                
                %Obtain index within each shuffled bin
                shuffBin = randperm((nPerBinBlock*nBlocks))';
                
                %Preallocate arrays               
                blocks = nan(size(shuffBin));
                shuffBlocks = nan(size(shuffBin));
                
                %arrage block order within bins
                x = repmat((1:nBlocks)',nPerBinBlock,1);
                shuffBlocks(shuffBin) = x;
                
                
            else 
                % We will use as many possible trials per
                % bin having accounted already for artifacts
                
                %Drop excess trials
                nPerBinBlock = floor(nPerBin/nBlocks); %array for nPerBin
                
                %Obtain index within each shuffled bin
                shuffBin = randperm((nPerBinBlock(bin))*nBlocks)';
                
                %Preallocate arrays
                
                blocks = nan(size(shuffBin));
                shuffBlocks = nan(size(shuffBin));
                
                %arrage block order within bins
                x = repmat((1:nBlocks)',nPerBinBlock(bin),1);
                shuffBlocks(shuffBin) = x;
            end
            
            %unshuffled block assignment
            blocks(shuffBin) = shuffBlocks;
            
            % save block assignment
            blockID = ['iter' num2str(iter) 'bin' num2str(bin)];
           
            svmECOC.blocks.(blockID) = blocks; % block assignment
            
            
            %create ERP average and place into blockDat_filtData struct          
            %grab current bin with correct # of electrodes & samps
            eeg_now = eegs(bin).data(ReleventChan,:,:);
            
            %here, we create blockDat_filtData. 
            %this results in nBins*nBlocks amount of ERP spatial
            %distributions (across nChans) at each sample/timepoint
            
            %% Step 1: computing ERPs based on random subset of trials for each block 
            for bl = 1:nBlocks
                
                blockDat_filtData(bCnt,:,:) = squeeze(mean(eeg_now(:,tois,blocks==bl),3));
                
                labels(bCnt) = bin; %used for arranging classification obj.
                
                blockNum(bCnt) = bl;
                
                bCnt = bCnt+1;
                
            end
            
        end
        

        %% Step 7: Loop through each timepoint 
        % Do SVM_ECOC at each time point
        for t = 1:nSamps
            toi = ismember(times,times(t)-svmECOC.window:times(t)+svmECOC.window);
            dataAtTimeT = squeeze(mean(blockDat_filtData(:,:,toi),3));
 
            %% Step 6: Cross-validation for-loop 
            for i=1:nBlocks % loop through blocks, holding each out as the test set
                %% Step 2 & Step 4: Assigning training and testing data sets
                trnl = labels(blockNum~=i); % training labels
                
                tstl = labels(blockNum==i); % test labels
                
                trnD = dataAtTimeT(blockNum~=i,:);    % training data
                
                tstD = dataAtTimeT(blockNum==i,:);    % test data
                
                %% Step 3: Training 
                mdl = fitcecoc(trnD,trnl, 'Coding','onevsall','Learners','SVM' );   %train support vector mahcine
%                 saveWeight(iter,t,i,:) = covariance(trnD)*(mdl.BinaryLearners{1,1}.Beta+mdl.BinaryLearners{2,1}.Beta+mdl.BinaryLearners{3,1}.Beta+mdl.BinaryLearners{4,1}.Beta+mdl.BinaryLearners{5,1}.Beta+mdl.BinaryLearners{6,1}.Beta+mdl.BinaryLearners{7,1}.Beta+mdl.BinaryLearners{8,1}.Beta)/8;
                %% Step 5: Testing
                LabelPredicted = predict(mdl, tstD);       % predict classes for new data
                
               svm_predict(iter,t,i,:) = LabelPredicted;  % save predicted labels
                
                tst_target(iter,t,i,:) = tstl;             % save true target labels
                
                
            end % end of block: Step 6: cross-validation
   
        end % end of time points: Step 7: Decoding each time point
        
    end % end of iteration: Step 8: iteration with random shuffling
    
    toc % stop timing the iteration loop
    
    %output decoding results in main svmECOC structure
    svmECOC.targets = tst_target;
    svmECOC.modelPredict = svm_predict;    
    svmECOC.nBlocks = nBlocks;
    
    save(OutputfName,'svmECOC');
%     clear saveWeight
end % end of subject loop: Step 9: Decoding for each participant 



