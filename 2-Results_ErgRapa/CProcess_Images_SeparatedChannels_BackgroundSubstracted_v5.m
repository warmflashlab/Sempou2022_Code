function CProcess_Images_SeparatedChannels_BackgroundSubstracted_v5(pathname,savingpathforImages,PlateMaxNum,Channelsnames,ChannelMaxNum,WellsWithData,ImagesperWell,Conditionsnames,OrderChannels,varargin)
%% Description
% help make image panel with 5 rows (ch1-4, merge) and columns are all the
% replicates in one condition
% all the images will be saved in plate/well/ folder with single image and
% panel image

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


%% finding how many channels used in each well

ChannelsPresent = {};
numchannelspresent = 0;
PlateCoordinates = {};
WellCoordinates = {};
ChannelCoordinates = {};

MaxWellWithData = 0;

for platenum = 1:PlateMaxNum
    aux=length(WellsWithData{platenum});
    MaxWellWithData = max(MaxWellWithData,aux);
end
    
ChannelsMatrix = cell(PlateMaxNum,18);


disp('Finding channels........')


for PlateNumber = 1:PlateMaxNum
    for WellNumber = WellsWithData{PlateNumber} 
        for ChannelNumber = 1:ChannelMaxNum
            Channelaux = Channelsnames{PlateNumber}{WellNumber}{ChannelNumber};
            if ~any(strcmp(ChannelsPresent,Channelaux))
                numchannelspresent = numchannelspresent+1;
                ChannelsPresent{numchannelspresent} = Channelaux;
                PlateCoordinates{numchannelspresent}=[PlateNumber];
                WellCoordinates{numchannelspresent}=[WellNumber];
                ChannelCoordinates{numchannelspresent}=[ChannelNumber];
                ChannelsMatrix{PlateNumber,WellNumber} = [ChannelsMatrix{PlateNumber,WellNumber},numchannelspresent];
                
            else
                coord = find(strcmp(ChannelsPresent,Channelaux)==1);
                PlateCoordinates{coord}=[PlateCoordinates{coord},PlateNumber];
                WellCoordinates{coord}=[WellCoordinates{coord},WellNumber];
                ChannelCoordinates{coord}=[ChannelCoordinates{coord},ChannelNumber];
                ChannelsMatrix{PlateNumber,WellNumber} = [ChannelsMatrix{PlateNumber,WellNumber},coord];

            end
            
        end
                  
    end
end


disp('Channels found')


%% generating limits for the panel (per condition)

disp('Generating limits......')

limitschannels = zeros(2,length(ChannelsPresent));

for ChannelNumber = 1:length(ChannelsPresent)
    
    
    image16bit = imread([pathname,'/w',num2str(WellCoordinates{ChannelNumber}(1)),'_1_MaxProj.tif'],ChannelCoordinates{ChannelNumber}(1));
    if bgimageaux
        bgimagebit = imread(bgimage,ChannelCoordinates{ChannelNumber}(1));
   
        if medfiltopt
        image16bit = medfilt2(presubBackground_provided_SaveImages(image16bit,1,ChannelNumber,bgimagebit));
        else
        image16bit = presubBackground_provided_SaveImages(image16bit,1,ChannelNumber,bgimagebit);
          
        end
    else
        if medfiltopt
        image16bit = medfilt2(presubBackground_provided_SaveImages(image16bit,0,ChannelNumber,image16bit));
        else
         image16bit = presubBackground_provided_SaveImages(image16bit,0,ChannelNumber,image16bit);   
        end
    end
        
    
    imaux = im2double(image16bit);
    
    limitsaux = stretchlim(imaux,[0.05 0.95]);
    
    for imageswithchannel = 1:length(PlateCoordinates{ChannelNumber})
        
        for positionnumber = 1:ImagesperWell
            
            image16bit = imread([pathname,'/w',num2str(WellCoordinates{ChannelNumber}(imageswithchannel)),'_',num2str(positionnumber),'_MaxProj.tif'],ChannelCoordinates{ChannelNumber}(imageswithchannel));
            if bgimageaux
                bgimagebit = imread(bgimage,ChannelCoordinates{ChannelNumber}(imageswithchannel));
                if medfiltopt
                image16bit = medfilt2(presubBackground_provided_SaveImages(image16bit,1,ChannelNumber,bgimagebit));
                else
                image16bit = presubBackground_provided_SaveImages(image16bit,1,ChannelNumber,bgimagebit);
                end
            else
                if medfiltopt
                image16bit = medfilt2(presubBackground_provided_SaveImages(image16bit,0,ChannelNumber,image16bit));
                else
                image16bit = presubBackground_provided_SaveImages(image16bit,0,ChannelNumber,image16bit);                    
                end
            end
            imaux = im2double(image16bit);
            
            limitsaux2 = stretchlim(imaux,[0.05 0.95]);
            
            if limitsaux(2)<limitsaux2(2)

                limitsaux(2) = limitsaux2(2);


            end
            
            if limitsaux(1)>limitsaux2(1)

                limitsaux(1) = limitsaux2(1);


            end
            
        end
           
            
    end
    limitschannels(:,ChannelNumber) = limitsaux;
     
        
end

%%

disp('Saving images.....')

for platenumber = 1:PlateMaxNum
cd(savingpathforImages)
mkdir(['Plate',num2str(platenumber)])
    
    
for wellnumber = WellsWithData{platenumber}
cd([savingpathforImages,'/Plate',num2str(platenumber)])
mkdir(['Well',num2str(wellnumber)]) 

        BigCellMontage={};
        
        
        for positionnumber = 1:ImagesperWell
            
            AdjustedImage = [];
            
            for channelnumber = 1:ChannelMaxNum
                
              image16bit = imread([pathname,'/w',num2str(wellnumber),'_',num2str(positionnumber),'_MaxProj.tif'],channelnumber);
              
              if bgimageaux
                bgimagebit = imread(bgimage,ChannelsMatrix{platenumber,wellnumber}(channelnumber));
                if medfiltopt
                image16bit = medfilt2(presubBackground_provided_SaveImages(image16bit,1,ChannelsMatrix{platenumber,wellnumber}(channelnumber),bgimagebit));
                else
                image16bit = presubBackground_provided_SaveImages(image16bit,1,ChannelsMatrix{platenumber,wellnumber}(channelnumber),bgimagebit);
                end
            else
                if medfiltopt
                image16bit = medfilt2(presubBackground_provided_SaveImages(image16bit,0,ChannelsMatrix{platenumber,wellnumber}(channelnumber),image16bit));
                else
                image16bit = presubBackground_provided_SaveImages(image16bit,0,ChannelsMatrix{platenumber,wellnumber}(channelnumber),image16bit);                    
                end
              end
            
              
             imaux = im2double(image16bit);  
                
              AdjustedImage(:,:,channelnumber) = imadjust(imaux,limitschannels(:,ChannelsMatrix{platenumber,wellnumber}(channelnumber)));

                
                
            end
            
            ChannelMaxaux = 0;
            for ii = 1:ChannelMaxNum
            if strcmp(Channelsnames{platenumber}{wellnumber}(ii),'0NA')~=1
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
    imwrite(imresize(img2showDAPI,0.3),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_DAPI','_channel.png'])
    
    if ChannelMaxaux>1 
    img2showChannel1 = cat(3,zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1}))),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}));  %CYAN
    imwrite(imresize(img2showChannel1,0.3),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},'channel.png'])
    img2showDAPIChannel1 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2)),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}));     % Cyan   
    imwrite(imresize(img2showDAPIChannel1,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},'channel_MergeDAPI.png'])
%     imwrite(img2showDAPIChannel1,[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},'channel_MergeDAPI.png'])
    end
    if ChannelMaxaux>2
    img2showChannel2 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}),zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}))),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}));  %MAGENTA
    imwrite(imresize(img2showChannel2,0.3),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(3)},'channel.png'])
    img2showDAPIChannel2 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2)),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2);     % Magenta
    imwrite(imresize(img2showDAPIChannel2,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(3)},'channel_MergeDAPI.png'])
    end
    if ChannelMaxaux>3
    img2showChannel3 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4}),zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4}))));        %YELLOW
    imwrite(imresize(img2showChannel3,0.3),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(4)},'channel.png'])
    img2showDAPIChannel3 = cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{1})/2+zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2)));     % Yellow
    imwrite(imresize(img2showDAPIChannel3,imresizelevel),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_',ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(4)},'channel_MergeDAPI.png'])

    end
    
    BigCellMontage{positionnumber} = imresize(img2showDAPI,0.3);
    if ChannelMaxaux == 2
        img2showMerge = cat(3,zeros(size(AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}))),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}));
        BigCellMontage{ImagesperWell+positionnumber} = imresize(img2showChannel1,0.3);
        BigCellMontage{2*ImagesperWell+positionnumber} = imresize(img2showMerge,0.3);
        namemontage = [ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)}];
    elseif ChannelMaxaux == 3
        img2showMerge =cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2);
        BigCellMontage{ImagesperWell+positionnumber} = imresize(img2showChannel1,0.3);
        BigCellMontage{2*ImagesperWell+positionnumber} = imresize(img2showChannel2,0.3);
        BigCellMontage{3*ImagesperWell+positionnumber} = imresize(img2showMerge,0.3);
        namemontage = [ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(3)}];

    elseif ChannelMaxaux == 4
%     A=imshow(img2showChannel1)
%         img2showMerge =cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})/2+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3})/2);
        img2showMerge =cat(3,AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{4})+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2}),AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{2})+AdjustedImage(:,:,OrderChannels{platenumber}{wellnumber}{3}));

        BigCellMontage{ImagesperWell+positionnumber} = imresize(img2showChannel1,0.3);
        BigCellMontage{2*ImagesperWell+positionnumber} = imresize(img2showChannel2,0.3);
        BigCellMontage{3*ImagesperWell+positionnumber} = imresize(img2showChannel3,0.3);
        BigCellMontage{4*ImagesperWell+positionnumber} = imresize(img2showMerge,0.3);
        namemontage = [ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(2)},ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(3)},ChannelsPresent{ChannelsMatrix{platenumber,wellnumber}(4)}];

    else
        img2showMerge =img2showDAPI;
        BigCellMontage{ImagesperWell+positionnumber} = imresize(img2showChannel1,0.3);
    end

    imwrite(imresize(img2showMerge,0.3),[savingpathforImages,'/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',num2str(positionnumber),'_Merge.png'])
    
    close all
        end
    %%
        
        



%IDSE
N = ImagesperWell;

n = ceil(N/4);
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


fig = montage(BigCellMontage,'BorderSize',[3,3],'BackgroundColor','white','Size',[5,ImagesperWell]);

filename = strcat('/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/MontageWhite_Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',namemontage);
saveas(fig, fullfile(savingpathforImages, filename), 'png');

fig = montage(BigCellMontage,'BorderSize',[3,3],'BackgroundColor','black','Size',[5,ImagesperWell]);

filename=strcat('/Plate',num2str(platenumber),'/Well',num2str(wellnumber),'/MontageBlack_Plate',num2str(platenumber),'_Well',num2str(wellnumber),'_',namemontage);
saveas(fig, fullfile(savingpathforImages, filename), 'png');

% pause()

close all

        
end
    
    
end

save([savingpathforImages,'/limitschannelsimages'],'limitschannels','ChannelsMatrix','ChannelsPresent');

disp('Saved data')


end