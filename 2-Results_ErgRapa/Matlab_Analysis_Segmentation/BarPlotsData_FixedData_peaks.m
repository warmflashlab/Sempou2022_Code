
function BarPlotsData_FixedData_peaks(blackBG)


% AnalysisParamScript_Plate1

global analysisParam;

load(analysisParam.dataSegmentation)


%% Save data at times in timesaux for different conditions

% times = [1,5.5/0.25,5.5/0.25+20/0.25,5.5/0.25+30/0.25,5.5/0.25+40/0.25,5.5/0.25+48/0.25];

times = 1:analysisParam.nCon;

AllDataConditions = {};


for condition = 1:analysisParam.nCon
 
        AllDataConditions{condition} = Allpeaks{1}{analysisParam.ConditionOrder(condition)}(:,5+analysisParam.ChannelOrder)./Allpeaks{1}{analysisParam.ConditionOrder(condition)}(:,5);
       
end

Conditionsname = analysisParam.conNamesPlot;

%%

maxquantile = 0.9;
minquantile = 0.1;
if analysisParam.ChannelsLimsFile
    load(analysisParam.ChannelsLimsFile);
    
    maxlim = maxlim(analysisParam.ChannelOrder);
    minlim = minlim(analysisParam.ChannelOrder);
else

    maxlim = quantile(AllDataConditions{1},maxquantile);
    minlim = quantile(AllDataConditions{1},minquantile);

    for conditionnum=2:analysisParam.nCon

            DataPlot = AllDataConditions{conditionnum};

            maxlim = max([maxlim;quantile(DataPlot,maxquantile)]);
            minlim = min([minlim;quantile(DataPlot,minquantile)]);

    end
end

%% Violin plot


if blackBG
    
    figure;
set(gcf,'Position',[10 10 1200 1000])
% colourclusters = {colorconvertorRGB([236,28,36]),colorconvertorRGB([249,236,49]),colorconvertorRGB([64,192,198])};
colourclusters = {'g','r','b'};
colors = distinguishable_colors(analysisParam.nCon,{'w','k'});

alinearrelation = 10;
blinearrelation = 5;

for channelnum = 1:analysisParam.nChannels

subplot(analysisParam.nChannels,1,channelnum)



celln = 0;
xticksnum = [];
daystickslabels = {};
plotshandle = [];
legendhandle = {};
% MatrixToPlot=[];
% grp1=[];
meanData = [];
stdData = [];
    
    for daynum = 1:analysisParam.nCon

    
%             MatrixToPlot = [MatrixToPlot,AllDataConditions{daynum}(:,channelnum)'];
%             grp1 = [grp1,daynum-1+zeros(1,length(AllDataConditions{daynum}(:,channelnum)))];
    meanData = [meanData,mean(AllDataConditions{daynum}(:,channelnum))];
    stdData = [stdData,std(AllDataConditions{daynum}(:,channelnum))];
        
        % Set appearance of plot:
%         xticksnum = [xticksnum, daytick];
        daystickslabels{daynum} = Conditionsname{daynum};
        
        
%             legendhandle{daynum} = ['(',num2str(ids(daynum)),') ',mutregimes{daynum},' D',num2str(days{daynum}),' ', CHIRcond, ' ',LGKcond];
%         if daynum >1
%            plot([daytickaux,daytick], [meanaux,mean(DataPlot)],'Color',colors(conditionnum,:),'LineWidth',1.5) 
%         end
        
%         meanaux = mean(DataPlot);
%         daytickaux = daytick;
        
        
        
    end
    
    hold on
    
    bar(1:analysisParam.nCon,meanData,colourclusters{channelnum});
    errorbar(1:analysisParam.nCon,meanData,stdData/2,'.','Color','w')
%     boxplot(MatrixToPlot,grp1);%,'Colors',colourclusters{channelnum});
%     boxplot(daynum,AllDataConditions{daynum}(:,channelnum),'Colors',colourclusters{channelnum})
    
    
%         xlabel('Hours post treatment')
        ylabel(analysisParam.Channels{analysisParam.ChannelOrder(channelnum)},'Color','w');

    
%     title([genesnames{1}{genenum},' dynamics'],'fontsize',10)

%     ylim(1.2*[minlim(channelnum),maxlim(channelnum)])

%     xlim([0,max(xticksnum)+blinearrelation])
%     [xticksordered,indicesxticks] = sort(xticksnum);
    xticks(1:analysisParam.nCon)
    if channelnum<analysisParam.nChannels
        xticklabels((cell(1,analysisParam.nCon)));
    else
    xticklabels((daystickslabels(analysisParam.ConditionOrder)));
    
    end
%     title(Conditionsname{conditionnum})
if channelnum==1
    title(analysisParam.Title,'Color','w')
end
xtickangle(analysisParam.angleticks)
    
    set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Arial')
    set(gca,'FontSize',18)
    set(gca,'Color','k')
    set(gca,'Color','k')
    set(gca,'XColor','w')
    set(gca,'YColor','w')  
    
end



fig = gcf;
fig.Color = 'k';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'BoxPlots-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'svg')
saveas(fig,[analysisParam.figDir filesep 'BoxPlots-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'BoxPlots-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4) '.pdf'],'pdf');




    
    
else
figure;
set(gcf,'Position',[10 10 1200 800])
% colourclusters = {colorconvertorRGB([236,28,36]),colorconvertorRGB([249,236,49]),colorconvertorRGB([64,192,198])};
colourclusters = {'g','r','b'};
colors = distinguishable_colors(analysisParam.nCon,{'w','k'});

alinearrelation = 10;
blinearrelation = 5;

for channelnum = 1:analysisParam.nChannels

subplot(analysisParam.nChannels,1,channelnum)
if channelnum==1
    title(analysisParam.Title)
end


celln = 0;
xticksnum = [];
daystickslabels = {};
plotshandle = [];
legendhandle = {};
% MatrixToPlot=[];
% grp1=[];
meanData = [];
stdData = [];
    
    for daynum = 1:analysisParam.nCon

    
%             MatrixToPlot = [MatrixToPlot,AllDataConditions{daynum}(:,channelnum)'];
%             grp1 = [grp1,daynum-1+zeros(1,length(AllDataConditions{daynum}(:,channelnum)))];
    meanData = [meanData,mean(AllDataConditions{daynum}(:,channelnum))];
    stdData = [stdData,std(AllDataConditions{daynum}(:,channelnum))];
        
        % Set appearance of plot:
%         xticksnum = [xticksnum, daytick];
        daystickslabels{daynum} = Conditionsname{daynum};
        
        
%             legendhandle{daynum} = ['(',num2str(ids(daynum)),') ',mutregimes{daynum},' D',num2str(days{daynum}),' ', CHIRcond, ' ',LGKcond];
%         if daynum >1
%            plot([daytickaux,daytick], [meanaux,mean(DataPlot)],'Color',colors(conditionnum,:),'LineWidth',1.5) 
%         end
        
%         meanaux = mean(DataPlot);
%         daytickaux = daytick;
        
        
        
    end
    
    hold on
    
    bar(1:analysisParam.nCon,meanData,colourclusters{channelnum});
    errorbar(1:analysisParam.nCon,meanData,stdData/2,'.','Color','k','LineWidth',2)
%     boxplot(MatrixToPlot,grp1);%,'Colors',colourclusters{channelnum});
%     boxplot(daynum,AllDataConditions{daynum}(:,channelnum),'Colors',colourclusters{channelnum})
    
    
%         xlabel('Hours post treatment')
        ylabel(analysisParam.Channels{analysisParam.ChannelOrder(channelnum)},'Color','k');

    
%     title([genesnames{1}{genenum},' dynamics'],'fontsize',10)

    ylim(1.2*[minlim(channelnum),maxlim(channelnum)])

%     xlim([0,max(xticksnum)+blinearrelation])
%     [xticksordered,indicesxticks] = sort(xticksnum);
    xticks(1:analysisParam.nCon)
    if channelnum<analysisParam.nChannels
        xticklabels((cell(1,analysisParam.nCon)));
    else
    xticklabels((daystickslabels(analysisParam.ConditionOrder)));
    
    end
    if channelnum<analysisParam.nChannels
        xticklabels((cell(1,analysisParam.nCon)));
    else
    xticklabels((daystickslabels(analysisParam.ConditionOrder)));
    
    end
%     title(Conditionsname{conditionnum})

xtickangle(analysisParam.angleticks)
       
    
end

fig = gcf;
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'BarPlots-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'svg')
saveas(fig,[analysisParam.figDir filesep 'BarPlots-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'BarPlots-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4) '.pdf'],'pdf');

end

