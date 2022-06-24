
%AnalysisParamScript

global analysisParam;

fprintf(1, '%s called to define params\n',mfilename);

%% All Plates (For FindLimitsData)
analysisParam.dataSegmentation = 'AllpeaksPlates_BGNorm_SmallerBG.mat';
analysisParam.NumofPlates = 1;
analysisParam.NamesConditions ={{'Ctrl','Erg','Rapa','Erg+Rapa'}};              
analysisParam.nCon = {4};
analysisParam.conNamesPlot = {{'Ctrl','Erg','Rapa','Erg+Rapa'}};  
% analysisParam.conNamesPlot = {{'mTeSR', '0-48h'};{'BMP', '0-4h'};{'BMP', '0-8h'};{'BMP', '0-16h'};{'BMP', '0-24h'};{'BMP', '0-32h'};{'BMP', '0-40h'};{'BMP', '0-48h'}};
analysisParam.ConditionOrder = [1,2,3,4];
analysisParam.nChannels = 3;
analysisParam.ChannelOrder = [1,2,3]; 
analysisParam.Channels = {'Nanog','Oct4','Sox2'};

analysisParam.figDir = 'figures';
mkdir(['/Users/elenacamachoaguilar/Dropbox (Warmflash Lab)/LabFiles/Elena/211014_ErgRapa_ESI/MaxProj/Matlab_Analysis_Segmentation' filesep analysisParam.figDir])




%% For violin plot

analysisParam.angleticks = 0;%30;


%% For heat scatter plot

analysisParam.distance = 0.05;
analysisParam.ChannelOrder3D = [1,2,3];