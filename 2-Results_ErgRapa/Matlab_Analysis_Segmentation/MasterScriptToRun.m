%% Script Analysis
AnalysisParamScript
% % Modify AnalysisParamScript.m to fit your data and run:
FindLimitsData


%% Choose plate

platenum=1;
analysisParam.NamesConditions =analysisParam.NamesConditions{platenum};
analysisParam.conNamesPlot =analysisParam.conNamesPlot{platenum};
analysisParam.Title = 'Plate 1';
analysisParam.ChannelsLimsFile = 'QuantileLimitsData.mat';
analysisParam.nCon = analysisParam.nCon{1};

BarPlotsData_FixedData_peaks_Grouped(0)

%% Bar plots of each plate

BarPlotsData_FixedData_peaks(0)

%% (If cytoplasmic levels were segmented and want nuclear/cyto)

channeltoanalyse = 2;

BarPlotsData_FixedData_NucCyto_peaks(channeltoanalyse,0)


