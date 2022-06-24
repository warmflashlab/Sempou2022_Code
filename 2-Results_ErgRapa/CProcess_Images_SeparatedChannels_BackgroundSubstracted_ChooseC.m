function CProcess_Images_SeparatedChannels_BackgroundSubstracted_ChooseConditionsv5(conditionschoice,filename,pathname,savingpathforImages,PlateMaxNum,Channelsnames,ChannelMaxNum,WellsWithData,ImagesperWell,Conditionsnames,OrderChannels,varargin)

if ( length(varargin) == 1 )
    varargin = varargin{:};
end
bgimage = [];
bgimageaux=0;
imresizelevel =0.3;
medfiltopt = 1;

while ~isempty(varargin)
    switch lower(varargin{1})
          case {'option1'}
              bgimage = varargin{2};
              bgimageaux=1
          case {'option2'}
              imresizelevel = varargin{2}
          case {'option3'}
              medfiltopt = varargin{2}

    otherwise
        error(['Unexpected option: ' varargin{1}])
    end
      varargin(1:2) = [];
      bgimageaux=0;
end

%%

imresizelevel=0.9
load([savingpathforImages,filesep,'limitschannelsimages.mat'])

disp('Saving images.....')
ImagesperWell = size(conditionschoice,2);

% for platenumber = conditionschoice(1,:)
% % cd(savingpathforImages)
% % mkdir(['Plate',num2str(platenumber)])
%     
%     
% for wellnumber = conditionschoice(2,:)
% % cd([savingpathforImages,'/Plate',num2str(platenumber)])
% % mkdir(['Well',num2str(wellnumber)]) 

        BigCellMontage={};
 
        
        
        for positionnumber = 1:ImagesperWell
            platenumber=1;
            wellnumber=conditionschoice(2,positionnumber);
            
            AdjustedImage = [];
            
            for channelnumber = 1:ChannelMaxNum
                
              image16bit = imread([pathname,'/w',num2str(conditionschoice(2,positionnumber)),'_',num2str(conditionschoice(3,positionnumber)),'_MaxProj.tif'],channelnumber);
              
              if bgimageaux
                bgimagebit = imread(bgimage,ChannelsMatrix{1,conditionschoice(2,positionnumber)}(channelnumber));
                if medfiltopt
                image16bit = medfilt2(presubBackground_provided_SaveImages(image16bit,1,ChannelsMatrix{1,conditionschoice(2,positionnumber)}(channelnumber),bgimagebit));
                else
                image16bit = presubBackground_provided_SaveImages(image16bit,1,ChannelsMatrix{1,conditionschoice(2,positionnumber)}(channelnumber),bgimagebit);
                end
            else
                if medfiltopt
                image16bit = medfilt2(presubBackground_provided_SaveImages(image16bit,0,ChannelsMatrix{1,conditionschoice(2,positionnumber)}(channelnumber),image16bit));
                else
                image16bit = presubBackground_provided_SaveImages(image16bit,0,ChannelsMatrix{1,conditionschoice(2,positionnumber)}(channelnumber),image16bit);                    
                end
              end
            
              
             imaux = im2double(image16bit);  
                
              AdjustedImage(:,:,channelnumber) = imadjust(imaux,limitschannels(:,ChannelsMatrix{1,conditionschoice(2,positionnumber)}(channelnumber)));

                
                
            end
            
            ChannelMaxaux = 0;
            for ii = 1:ChannelMaxNum
            if strcmp(Channelsnames{1}{conditionschoice(2,positionnumber)}(ii),'0NA')~=1
                ChannelMaxaux = ChannelMaxaux+1;
            end
            end
                
    
            ChannelMaxaux
%     img2showDAPI = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1}));        
%     img2showChannel1 = cat(3,zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1}))),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2);  %CYAN
%     img2showChannel2 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}),zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}))),zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}))));  %RED
%     img2showChannel3 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2,zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4}))));    %YELLOW
%     img2showMerge = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2);

    img2showDAPI = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1}));    %Gray
%     imwrite(imresize(img2showDAPI,0.3),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_DAPI','_channel.png'])
    
    if ChannelMaxaux>1 
        chnum = 2;
    img2showChannel1 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}));  %GRAY
%     imwrite(imresize(img2showChannel1,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},'channel.png'])
%     img2showDAPIChannel1 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2)),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}));     % Cyan   
%     imwrite(imresize(img2showDAPIChannel1,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},'channel_MergeDAPI.png'])
%     imwrite(img2showDAPIChannel1,[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},'channel_MergeDAPI.png'])
    end
    if ChannelMaxaux>2
    chnum = 3;
    img2showChannel2 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}));  %GRAY
%     imwrite(imresize(img2showChannel2,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(3)},'channel.png'])
    img2showDAPIChannel2 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2)),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2);     % Magenta
%     imwrite(imresize(img2showDAPIChannel2,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(3)},'channel_MergeDAPI.png'])
    end
    if ChannelMaxaux>3
    chnum = 4;
    img2showChannel3 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{chnum}));  %GRAY
%     imwrite(imresize(img2showChannel3,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(4)},'channel.png'])
    img2showDAPIChannel3 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2)));     % Yellow
%     imwrite(imresize(img2showDAPIChannel3,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(4)},'channel_MergeDAPI.png'])

    end
    
    BigCellMontage{positionnumber} = imresize(img2showDAPI,imresizelevel);
    if ChannelMaxaux == 2
        img2showMerge = cat(3,zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}))),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}));
        BigCellMontage{ImagesperWell+positionnumber} = imresize(img2showChannel1,imresizelevel);
%         BigCellMontage{2*ImagesperWell+positionnumber} = imresize(img2showMerge,0.3);
        namemontage = [ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)}];
    elseif ChannelMaxaux == 3
        img2showMerge =cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2);
        BigCellMontage{ImagesperWell+positionnumber} = imresize(img2showChannel1,imresizelevel);
        BigCellMontage{2*ImagesperWell+positionnumber} = imresize(img2showChannel2,imresizelevel);
%         BigCellMontage{3*ImagesperWell+positionnumber} = imresize(img2showMerge,0.3);
        namemontage = [ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(3)}];

    elseif ChannelMaxaux == 4
%     A=imshow(img2showChannel1)
%         img2showMerge =cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2);
        img2showMerge =cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}));
        ImagesperWell+positionnumber
        BigCellMontage{ImagesperWell+positionnumber} = imresize(img2showChannel1,imresizelevel);
        2*ImagesperWell+positionnumber
        BigCellMontage{2*ImagesperWell+positionnumber} = imresize(img2showChannel2,imresizelevel);
        3*ImagesperWell+positionnumber
        BigCellMontage{3*ImagesperWell+positionnumber} = imresize(img2showChannel3,imresizelevel);
%         BigCellMontage{4*ImagesperWell+positionnumber} = imresize(img2showMerge,0.3);
        namemontage = [ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(3)},ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(4)}];

    else
        img2showMerge =img2showDAPI;
        BigCellMontage{ImagesperWell+positionnumber} = imresize(img2showChannel1,imresizelevel);
    end

%     imwrite(imresize(img2showMerge,0.3),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_Merge.png'])
    
%     close all
    end
        
%%


%IDSE
N = ImagesperWell;

n = ceil(N/ChannelMaxaux-1);
m = ceil(N/n);


%m = N/2;
screensize = get( 0, 'Screensize' );
margin = 50;
fs = 14;
w = screensize(3);
h = 5*(screensize(3)/m + margin/2);
%IDSE

merged = {};

% fig=figure('Position', [1, 1, w, h]);


fig = montage(BigCellMontage,'BorderSize',[3,3],'BackgroundColor','white','Size',[ChannelMaxaux,ImagesperWell]);

% filename = strcat('/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/MontageWhite_Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',namemontage);
saveas(fig, fullfile(savingpathforImages, [filename,'_White']), 'png');

fig = montage(BigCellMontage,'BorderSize',[3,3],'BackgroundColor','black','Size',[ChannelMaxaux,ImagesperWell]);

% filename=strcat('/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/MontageBlack_Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',namemontage);
saveas(fig, fullfile(savingpathforImages, [filename,'_Black']), 'png');

% pause()

close all

    


% save([savingpathforImages,'/limitschannelsimages'],'limitschannels','ChannelsMatrix');

disp('Saved data')


end