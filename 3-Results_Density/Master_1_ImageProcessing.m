%% Master file for Image Visualization, Image Processing & Data Analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%% Customize the file AnalysisParamScript_IP and copy it to your experiment's folder. Also copy this file.

AnalysisParamScript_IP
global analysisParam

%% (If necessary) get max projection images or rename files in the format Pi_Wj_k
% Use MaxIntensityProj_SeparateFiles if files are on the format Pi_Wj_k.tif

% Use MaxIntensityProj_18WellRows if there is a file for each row of the 18
% well plate

% Use MaxIntensityProj_rename_18Well if there is a file for each position of the 8 or 18
% well plate but they are not in the format Pi_Wj_k.tif


%% Create masks in Ilastik



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                   VISUALIZE IMAGES IN COMMON LUT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Image Visualization (can run it without masks if choosing analysisParam.bgsubstractionopt = 1,3, or 4
cd(analysisParam.pathnamesave)
analysisParam.bgsubstractionopt = 2; %1: use background images given, 2: use min mean background value over images (needs segmentation!), 3: use imopen to substract background, 4: don't substract background
analysisParam.savingpathforImages = [analysisParam.pathnamesave filesep 'Visualize_Images_BGSubstracted_',num2str(analysisParam.bgsubstractionopt)];
mkdir(analysisParam.savingpathforImages)
options = {'imresizelevel',0.3,'medfiltopt',0};

IP_Visualize_Images_CommonLUT_BGSub_CMYK(options)

%% Data Visualization Conditions Choice (IP_Visualize_Images_CommonLUT_BGSub_CMYK should be run before this)
cd(analysisParam.pathnamesave)
conditionschoice = [1 1 1; 1 2 1; 1 3 1; 1 4 1]'; %[Plate Well Position; Plate Well Position;...]
filename = 'Image_1k';

analysisParam.bgsubstractionopt = 2; %1: use background images given, 2: use min mean background value over images (needs segmentation!), 3: use imopen to substract background, 4: don't substract background
analysisParam.savingpathforImages = [analysisParam.pathnamesave filesep 'Visualize_Images_BGSubstracted_',num2str(analysisParam.bgsubstractionopt)];
options = {'imresizelevel',0.9,'medfiltopt',0,'colororbw',0}; %'colororbw' = 1 if colored subimages, or 0 if BW (0 is default)

IP_TableImageVisualization(conditionschoice,filename,options)

%% Data Visualization Conditions Choice (IP_Visualize_Images_CommonLUT_BGSub_CMYK should be run before this)
cd(analysisParam.pathnamesave)
conditionschoice = [2 1 2; 2 2 2; 2 3 1; 2 4 1]'; %[Plate Well Position; Plate Well Position;...]
filename = 'Image_3k';

analysisParam.bgsubstractionopt = 2; %1: use background images given, 2: use min mean background value over images (needs segmentation!), 3: use imopen to substract background, 4: don't substract background
analysisParam.savingpathforImages = [analysisParam.pathnamesave filesep 'Visualize_Images_BGSubstracted_',num2str(analysisParam.bgsubstractionopt)];
options = {'imresizelevel',0.9,'medfiltopt',0,'colororbw',0}; %'colororbw' = 1 if colored subimages, or 0 if BW (0 is default)

IP_TableImageVisualization(conditionschoice,filename,options)

%% Data Visualization Conditions Choice (IP_Visualize_Images_CommonLUT_BGSub_CMYK should be run before this)
cd(analysisParam.pathnamesave)
conditionschoice = [3 1 2; 3 2 2; 3 3 1; 3 4 1]'; %[Plate Well Position; Plate Well Position;...]
filename = 'Image_7k';

analysisParam.bgsubstractionopt = 2; %1: use background images given, 2: use min mean background value over images (needs segmentation!), 3: use imopen to substract background, 4: don't substract background
analysisParam.savingpathforImages = [analysisParam.pathnamesave filesep 'Visualize_Images_BGSubstracted_',num2str(analysisParam.bgsubstractionopt)];
options = {'imresizelevel',0.9,'medfiltopt',0,'colororbw',0}; %'colororbw' = 1 if colored subimages, or 0 if BW (0 is default)

IP_TableImageVisualization(conditionschoice,filename,options)

%% Data Visualization Conditions Choice (IP_Visualize_Images_CommonLUT_BGSub_CMYK should be run before this)
cd(analysisParam.pathnamesave)
conditionschoice = [1 1 1; 1 2 1; 1 3 1; 1 4 1; 2 3 1; 2 4 1; 3 3 2; 3 4 3]'; %[Plate Well Position; Plate Well Position;...]
filename = 'Image_Panel_Conditions';

analysisParam.bgsubstractionopt = 2; %1: use background images given, 2: use min mean background value over images (needs segmentation!), 3: use imopen to substract background, 4: don't substract background
analysisParam.savingpathforImages = [analysisParam.pathnamesave filesep 'Visualize_Images_BGSubstracted_',num2str(analysisParam.bgsubstractionopt)];
options = {'imresizelevel',0.9,'medfiltopt',0,'colororbw',0}; %'colororbw' = 1 if colored subimages, or 0 if BW (0 is default)

IP_TableImageVisualization(conditionschoice,filename,options)


%%

AnalysisParamScript_IP
global analysisParam

cd(analysisParam.pathnamesave)
conditionschoice = [1 1 1]'; %[Plate Well Position; Plate Well Position;...]
channelschoice = [2,3,4]; %Channels to plot, numbers as given in analysisParam.MapChannels.DifferentChannelsPresent
colorschoice = [2,3,4]; %Color to plot each channel: 1 B&W, 2 CYAN, 3 Magenta, 4 Yellow, 5 Blue, 6 Red, 7 Green
filename = 'P1';

analysisParam.bgsubstractionopt = 2; %1: use background images given, 2: use min mean background value over images (needs segmentation!), 3: use imopen to substract background, 4: don't substract background
analysisParam.savingpathforImages = [analysisParam.pathnamesave filesep 'Visualize_Images_BGSubstracted_',num2str(analysisParam.bgsubstractionopt)];
options = {'imresizelevel',0.9,'medfiltopt',0,'colororbw',1}; %'colororbw' = 1 if colored subimages, or 0 if BW (0 is default)


IP_TableImageVisualization_ChannelsChoice(conditionschoice,channelschoice,colorschoice,filename,options)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                   EXTRACT DATA FROM IMAGES USING ILASTIK MASKS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Process images using masks from Ilastik
cd(analysisParam.pathnamesave)
analysisParam.bgsubstractionopt = 2; %1: use background image given, 2: use min mean background value over images, 3: use imopen to substract background, 4: don't substract background
IP_SaveDataSegmentation_220429
disp('SaveDataAnalysis done')

% Outcome: 
%       Platei_Wellj_Data.mat: alldata{position} contains
%       [xposition,yposition,rawDAPI,Channel2,Channel3,Channel4,Area] for every
%       cell

%       AllDataPlates: alldatawells{PlateNum}{WellNumber}{position} contains
%       [xposition,yposition,rawDAPI,Channel2,Channel3,Channel4,Area] for every
%       cell in PlateNum, Wellnumber, position



%% Format data into a data array and normalise by DAPI intensity
cd(analysisParam.pathnamesave)
IP_NormaliseDataDAPI

% Outcome: 
%       Platei_AllDataMatrixDAPINorm.mat: AllDataMatrix{wellnum} contains
%       [xposition,yposition,rawDAPI,Channel2,Channel3,Channel4,Area,imageposition] for every
%       cell in the well
%                                         AllDataMatrixDAPInorm{wellnum} contains
%       [xposition,yposition,rawDAPI,DAPInormalisedChannel2,DAPInormalisedChannel3,DAPInormalisedChannel4,Area,position in well] for every
%       cell in the well

disp('NormaliseDataDAPI done')



%% Save all data in each plate together
cd(analysisParam.pathnamesave)
IP_SaveAllDataExperiment
DA_FindLimitsData_Raw

% Outcome: 
%       AllDataExperiment.mat: AllDataExperiment{1,platenum}{wellnum} contains
%       [xposition,yposition,rawDAPI,DAPInormalisedChannel2,DAPInormalisedChannel3,DAPInormalisedChannel4,Area,position in well] for every
%       cell in each plate and well
%       Also finds max and min intensities of each channel and saves them
%       in limitschannels (ordered as
%       analysisParam.MapChannels.DifferentChannelsPresent)

disp('SaveAllDataExperiment done')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                   DATA ANALYSIS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Data Analysis: Clean Data
cd(analysisParam.pathnamesave)
minArea = 60;
maxArea = 1000;

minquantile = 0.0005;
maxquantile = 0.9995;

%If no Background image provided:
options = {'minlimarea',minArea,'maxlimarea',maxArea,'minquantile',minquantile,'maxquantile',maxquantile};

DA_FindLimitsData(options)



%% Data Analysis: Bar plot
cd(analysisParam.pathnamesave)

ConditionsSelection = [1 1 1 1 2 2 2 2 3 3 3 3; ... %Plate
                       1 2 3 4 1 2 3 4 1 2 3 4];    %Well     
titleplottosave='AllData_Raw';

%Optional options
raworclean = 0; %0 if RAW data, 1 if using CLEAN data (0 default)
blackBG = 0; %0 if white background, 1 if black background (0 default)
channelnums = [2,4,3]; %choose channels in analysisParam.MapChannels.DifferentChannelsPresent, (analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)} default)
stdmean = 1; %1 if plotting std of the mean, 0 if plotting std of data;
angleticks = 45; %angle for xticks in barplots
title = 'AllData_Raw';
[sidx,ordercolors]=sort(channelnums);
uniformlimits = 0;

options = {'raworclean',raworclean,'blackbg',blackBG,'channels',channelnums,'stdmean',stdmean,'angleticks',angleticks,'title',title,'uniformlimits',uniformlimits,'ordercolors',ordercolors};

DA_BarPlotsData_FixedData_ConditionsSelection(ConditionsSelection,titleplottosave,options)

%% Data Analysis: Bar plot
cd(analysisParam.pathnamesave)

ConditionsSelection = [1 1 1 1 2 2 2 2 3 3 3 3; ... %Plate
                       1 2 3 4 1 2 3 4 1 2 3 4];    %Well     
titleplottosave='AllData_Clean';

%Optional options
raworclean = 1; %0 if RAW data, 1 if using CLEAN data (0 default)
blackBG = 0; %0 if white background, 1 if black background (0 default)
channelnums = [2,3,4]; %choose channels in analysisParam.MapChannels.DifferentChannelsPresent, (analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)} default)
stdmean = 1; %1 if plotting std of the mean, 0 if plotting std of data;
angleticks = 45; %angle for xticks in barplots
title = 'AllData_Clean';
[sidx,ordercolors]=sort(channelnums);
uniformlimits = 0;

options = {'raworclean',raworclean,'blackbg',blackBG,'channels',channelnums,'stdmean',stdmean,'angleticks',angleticks,'title',title,'uniformlimits',uniformlimits,'ordercolors',ordercolors};

DA_BarPlotsData_FixedData_ConditionsSelection(ConditionsSelection,titleplottosave,options)

%% Data Analysis: Bar plot
cd(analysisParam.pathnamesave)

ConditionsSelection = [1 1 1 1  2 2  3 3; ... %Plate
                       1 2 3 4  3 4  3 4];    %Well     
titleplottosave='AllData_Clean_Subset';

%Optional options
raworclean = 1; %0 if RAW data, 1 if using CLEAN data (0 default)
blackBG = 0; %0 if white background, 1 if black background (0 default)
channelnums = [2,3,4]; %choose channels in analysisParam.MapChannels.DifferentChannelsPresent, (analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)} default)
stdmean = 1; %1 if plotting std of the mean, 0 if plotting std of data;
angleticks = 45; %angle for xticks in barplots
title = 'AllData_Clean';
[sidx,ordercolors]=sort(channelnums);
uniformlimits = 0;

options = {'raworclean',raworclean,'blackbg',blackBG,'channels',channelnums,'stdmean',stdmean,'angleticks',angleticks,'title',title,'uniformlimits',uniformlimits,'ordercolors',ordercolors};


DA_BarPlotsData_FixedData_ConditionsSelection(ConditionsSelection,titleplottosave,options)

%% Data Analysis: Bar plot
cd(analysisParam.pathnamesave)

ConditionsSelection = [1 1 1 1  2 2  3 3; ... %Plate
                       1 2 3 4  3 4  3 4];    %Well     
titleplottosave='AllData_Clean_Subset_DAPI';

%Optional options
raworclean = 1; %0 if RAW data, 1 if using CLEAN data (0 default)
blackBG = 0; %0 if white background, 1 if black background (0 default)
channelnums = [1,2,3,4]; %choose channels in analysisParam.MapChannels.DifferentChannelsPresent, (analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)} default)
stdmean = 1; %1 if plotting std of the mean, 0 if plotting std of data;
angleticks = 45; %angle for xticks in barplots
title = 'AllData_Clean';
[sidx,ordercolors]=sort(channelnums);
uniformlimits = 0;

options = {'raworclean',raworclean,'blackbg',blackBG,'channels',channelnums,'stdmean',stdmean,'angleticks',angleticks,'title',title,'uniformlimits',uniformlimits,'ordercolors',ordercolors};

DA_BarPlotsData_FixedData_ConditionsSelection_NoDAPINorm(ConditionsSelection,titleplottosave,options)

%%
analysisParam.pathnamesave = '/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/LabFiles/Elena/220429_KCNH6/Results';
analysisParam.pathnamedata = [analysisParam.pathnamesave,'/MaxProj'];
analysisParam.savingpathforData = [analysisParam.pathnamesave,'/Matlab_Analysis_Segmentation'];
analysisParam.savingpathforImages = [analysisParam.pathnamesave,'/Visualize_Images_BGSubstracted'];

cd(analysisParam.pathnamesave)

ConditionsSelection = [1 1   2   3; ... %Plate
                       1 3   3   3];    %Well     
titleplottosave='AllData_Clean_Subset_DAPI';

%Optional options
raworclean = 1; %0 if RAW data, 1 if using CLEAN data (0 default)
blackBG = 0; %0 if white background, 1 if black background (0 default)
channelnums = [2,3,4]; %choose channels in analysisParam.MapChannels.DifferentChannelsPresent, (analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)} default)
stdmean = 1; %1 if plotting std of the mean, 0 if plotting std of data;
angleticks = 45; %angle for xticks in barplots
title = 'AllData_Clean';
[sidx,ordercolors]=sort(channelnums);
uniformlimits = 0;

options = {'raworclean',raworclean,'blackbg',blackBG,'channels',channelnums,'stdmean',stdmean,'angleticks',angleticks,'title',title,'uniformlimits',uniformlimits,'ordercolors',ordercolors};

DA_ScatterPlurip_Ncells(ConditionsSelection,titleplottosave,options)
