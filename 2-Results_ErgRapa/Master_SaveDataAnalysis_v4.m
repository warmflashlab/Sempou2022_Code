%% Master file for experiment 10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all

close all

%% Set up parameters

% To Change
pathnamedata = '/Users/elenacamachoaguilar/Dropbox (Warmflash Lab)/LabFiles/Elena/211014_ErgRapa_ESI/MaxProj'; %path to your max projection data
pathnamesave = '/Users/elenacamachoaguilar/Dropbox (Warmflash Lab)/LabFiles/Elena/211014_ErgRapa_ESI/MaxProj'; %path to where you want to save the data
addpath(pathnamesave)

NumofPlates = 1; %No need to change now

%Wells imaged
NumofWells = 4; 

%Which are the channels imaged in each well. 
Channelsnames = {{{'DAPI-405','Nanog-647','Oct4-488','Sox2-555'},{'DAPI-405','Nanog-647','Oct4-488','Sox2-555'},{'DAPI-405','Nanog-647','Oct4-488','Sox2-555'},{'DAPI-405','Nanog-647','Oct4-488','Sox2-555'}}};
ChannelMax = length(Channelsnames{1}{1});

%Conditions in each well
Conditionsnames = {{'Ctrl','Erg','Rapa','Erg+Rapa'}};              
WellsWithData = {1:NumofWells};

%How many images per well are
ImagesperWell = 3;

%Order channels for colors in the merged images. Here first channel will be
%white, second channel cyan, third channel yellow, fourth channel red. It's
%one order per well.
OrderChannels = {{{1,2,3,4},{1,2,3,4},{1,2,3,4},{1,2,3,4}}};

%% Data Visualization Background Substracted
cd(pathnamesave)
mkdir('Visualize_Images_BGSubstracted')
savingpathforImages = [pathnamesave,'/Visualize_Images_BGSubstracted'];
BackgroundImage = 'Background-mTeSR_MAXProj.tif';
% BackgroundImage = 'MaxProj/BACKGROUND_Exp38_MAXProj.tif';
cd(pathnamesave)

%If no Background image provided:
options = {'option2',0.3,'option3',0}; %option1 is to specify the background image, option2 is to specify the level of imresize, option3 is for medfilt option in background substraction (choose 0).

%If Background image provided:
% options = {'option1',BackgroundImage,'option2',0.3,'option3',0}; %option1 is to specify the background image, option2 is to specify the level of imresize, option3 is for medfilt option in background substraction (choose 0).

%Supposes there are 4 channels including DAPI
CProcess_Images_SeparatedChannels_BackgroundSubstracted_v5(pathnamedata,savingpathforImages,NumofPlates,Channelsnames,ChannelMax,WellsWithData,ImagesperWell,Conditionsnames,OrderChannels,options)

%% Data Visualization Background Substracted
cd(pathnamesave)
mkdir('Visualize_Images_BGSubstracted')
savingpathforImages = [pathnamesave,'/Visualize_Images_BGSubstracted'];
BackgroundImage = 'Background-mTeSR_MAXProj.tif';
% BackgroundImage = 'MaxProj/BACKGROUND_Exp38_MAXProj.tif';
cd(pathnamesave)

%If no Background image provided:
options = {'option2',0.9,'option3',0}; %option1 is to specify the background image, option2 is to specify the level of imresize, option3 is for medfilt option in background substraction (choose 0).

%If Background image provided:
% options = {'option1',BackgroundImage,'option2',0.3,'option3',0}; %option1 is to specify the background image, option2 is to specify the level of imresize, option3 is for medfilt option in background substraction (choose 0).

%Supposes there are 4 channels including DAPI
CProcess_Images_SeparatedChannels_BackgroundSubstracted_ChooseConditionsv5([1 1 1;1 3 4;1 1 1],'ImageAllConditions_Nanog_Oct4_Sox2', pathnamedata,savingpathforImages,NumofPlates,Channelsnames,ChannelMax,WellsWithData,ImagesperWell,Conditionsnames,OrderChannels,options)



%% Parameters Quantitative Analysis

% If you provide membrane and cytoplasmic masks change to 1
memandcytomask = 0; 


setUserParamForCecilia_ESI017_20x1024
global userParam;

cd(pathnamesave)
mkdir('Matlab_Analysis_Segmentation')
savingpathforData = [pathnamesave,'/Matlab_Analysis_Segmentation'];

%% Perform data analysis using the segmentation
% First, run this section without commenting line 324 of SaveDataAnalysis_imopenBackgroundComputation.mat. It will show you the
% how the program is improving the segmentation. You have to press Enter/Return every time you want to move to the next image. Maybe you will realise the
% segmentation needs to improve in Ilastik.

% If you see there is an image where the segmentation has gone crazy and
% there is a cell that takes all the image or a big cell that takes all the
% background, take note of which image it was and put it in the
% checkconstraintsfusedcandidates.m function.

% Once you are happy with the segmentations, and have changed
% checkconstraintsfusedcandidates accordingly, comment line 324 and run it
% again to save the correct data.

segmentCells_Cecilia_v4(pathnamedata,savingpathforData,NumofPlates,ImagesperWell,ChannelMax,WellsWithData,memandcytomask);
disp('SaveDataAnalysis done')


