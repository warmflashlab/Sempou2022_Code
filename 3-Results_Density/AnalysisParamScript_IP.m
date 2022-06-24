global analysisParam;

fprintf(1, '%s called to define params\n',mfilename);

%% Parameters to modify

% Path to your experiment
analysisParam.pathnamesave = '/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/LabFiles/Elena/220429_KCNH6/Results';
analysisParam.pathnamedata = [analysisParam.pathnamesave,'/MaxProj']; %No need to change usually
% Number of plates
analysisParam.NumofPlates = 3;
% Plate Type
analysisParam.NumofWells = 4;
% Number of images per well
analysisParam.ImagesperWell = 3;
% Names of conditions in each well and plate
analysisParam.NamesConditions ={{'1k - Control','1k - Erg','1k - Rapa','1k - Erg+Rapa'},...
                                {'3k - mTeSR','3k - Erg','3k - Rapa','3k - Erg+Rapa'},...
                                {'7k - mTeSR','7k - Erg','7k - Rapa','7k - Erg+Rapa'}};


% % Channels in each well of the plate                
ChannelsnamesPlate1 = {'DAPI-405','OCT4-488','SOX2-555','NANOG-647'};
OrderChannelsPlate1 = {1,2,3,4};
Plate1Channels = cell(1,8);
Plate1OrderChannels = cell(1,8);
for ii=1:4
Plate1Channels{ii} = ChannelsnamesPlate1;
Plate1OrderChannels{ii} = OrderChannelsPlate1;
end


ChannelsnamesPlate2 = {'DAPI-405','CDX2-640','SOX2-555','BRA-488'};
OrderChannelsPlate2 = {1,2,3,4};
Plate2Channels = cell(1,8);
Plate2OrderChannels = cell(1,8);
for ii=1:8
Plate2Channels{ii} = ChannelsnamesPlate2;
Plate2OrderChannels{ii} = OrderChannelsPlate2;
end


analysisParam.Channelsnames = {Plate1Channels,Plate1Channels,Plate1Channels};
analysisParam.OrderChannels = {Plate1OrderChannels,Plate1OrderChannels,Plate1OrderChannels};


analysisParam.WellsWithData = {1:4,1:4,1:4};
analysisParam.ChannelMaxNum = {};
for ii=1:analysisParam.NumofPlates
    analysisParam.ChannelMaxNum{ii} = cellfun(@length,analysisParam.Channelsnames{ii});
end


%Background images:
%------------------
analysisParam.bgsubstractionopt = 2; %1: use background images given, 2: use min mean background value over images (needs segmentation!), 3: use imopen to substract background, 4: don't substract background
analysisParam.path2BGImages = analysisParam.pathnamedata;
%One image per well and per plate (in this example, the bg image is the
%same for all wells, otherwise you'll need to specify each bg image
bgimagename = 'Background_Exp37_MAXProj.tif';
analysisParam.BGImages = {repmat({bgimagename},1,8),repmat({bgimagename},1,8)};


%Image processing parameters:
%----------------------------
analysisParam.imopendiskradious = 2;%6;
analysisParam.imerodediskradious = 2;%6;
analysisParam.imdilatediskradious = 2;%6;
analysisParam.pwatershed = 0.5;%1;


%% Other parameters usually not needed to be modified
analysisParam.savingpathforData = [analysisParam.pathnamesave,'/Matlab_Analysis_Segmentation'];
analysisParam.savingpathforImages = [analysisParam.pathnamesave,'/Visualize_Images_BGSubstracted'];
mkdir(analysisParam.savingpathforData)
analysisParam.nCon = cellfun(@length,analysisParam.WellsWithData);

analysisParam.figDir = 'figures';
mkdir([analysisParam.savingpathforData filesep analysisParam.figDir])

%% Create map channels

IP_CreateMapChannels


