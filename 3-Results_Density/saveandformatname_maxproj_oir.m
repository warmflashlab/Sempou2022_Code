%% Plate 1

clear all
pathtodata = '/Users/elenacamachoaguilar/Downloads/220429_KCNH6/1k';
pathtosavedata = '/Users/elenacamachoaguilar/Downloads/220429_KCNH6';
mkdir([pathtosavedata, filesep, 'MaxProj'])
%%
allfiles = dir([pathtodata filesep '*.oir']);
platenumber = '1';

coordrow = strfind(allfiles(1).name,'_B0')+1;
nwellsinrow = 6;

NZstacks = 5;
NChannels = 4;
Npositions = 5;

sX = 1024;
sY = 1024;


for filenum = 1:length(allfiles)
            
            %File in
            fileIn = allfiles(filenum).name
            
            %For new name
            platenumber = platenumber;
            rownumber = double(fileIn(coordrow))-'A'+1;
            wellinrow = str2num(fileIn(coordrow+2));
            wellnumber = num2str((rownumber - 1)*nwellsinrow+wellinrow);
            posstr = strfind(fileIn,'_G0');
            positionnumber = str2num(fileIn(posstr+(2:4)));
            positionnumber = rem(positionnumber,Npositions);
            if positionnumber == 0
                positionnumber=num2str(Npositions);
            else
                positionnumber=num2str(positionnumber);
            end
            
            fileOut = [pathtosavedata filesep 'MaxProj/P',platenumber,'_W',wellnumber,'_',positionnumber,'_MAXProj.tif']
            
            img=bfopen([pathtodata filesep fileIn]);


            for channelnum = 1:NChannels
                z=1;
                idx = channelnum+(z-1)*NChannels;
                imaux = img{1}{idx,1};
                maxprojchan = imaux;
                
                for z = 2:NZstacks
                    idx = channelnum+(z-1)*NChannels;
                    imaux = img{1}{idx,1};
                    
                    maxprojchan = max(maxprojchan,imaux);
                    
                    
                    
                end
                
                if channelnum==1
                imwrite(maxprojchan,fileOut,'Compression','none');
                else
                    imwrite(maxprojchan,fileOut,'writemode','append','Compression','none');
                end
                    
                
            end
            


end

disp('Finished')

%% Plate 2

clear all
pathtodata = '/Volumes/Elena-2020/220404_ControlExp_Exp56_2/Plate2_Cycle';
pathtosavedata = '/Volumes/Elena-2020/220404_ControlExp_Exp56_2';
mkdir([pathtosavedata, filesep, 'MaxProj'])

allfiles = dir([pathtodata filesep '*.oir']);
platenumber = '2';
coordrow = 8;
nwellsinrow = 4;

NZstacks = 3;
NChannels = 4;
Npositions = 4;

sX = 1024;
sY = 1024;


for filenum = 1:length(allfiles)
            
            %File in
            fileIn = allfiles(filenum).name
            
            %For new name
            platenumber = platenumber;
            rownumber = double(fileIn(coordrow))-'A'+1;
            wellinrow = str2num(fileIn(coordrow+2));
            wellnumber = num2str((rownumber - 1)*nwellsinrow+wellinrow);
            
            if isempty(strfind(fileIn,'_B02'))&&isempty(strfind(fileIn,'_B03'))
            posstr = strfind(fileIn,'_G0');
            positionnumber = str2num(fileIn(posstr+(2:4)));
            positionnumber = num2str(positionnumber-(str2num(wellnumber)-1)*Npositions);
            else
                
                positionnumber = fileIn(end-4);
                
            end
                
            
            fileOut = [pathtosavedata filesep 'MaxProj/P',platenumber,'_W',wellnumber,'_',positionnumber,'_MAXProj.tif']
            
            img=bfopen([pathtodata filesep fileIn]);


            for channelnum = 1:NChannels
                z=1;
                idx = channelnum+(z-1)*NChannels;
                imaux = img{1}{idx,1};
                maxprojchan = imaux;
                
                for z = 2:NZstacks
                    idx = channelnum+(z-1)*NChannels;
                    imaux = img{1}{idx,1};
                    
                    maxprojchan = max(maxprojchan,imaux);
                    
                    
                    
                end
                
                if channelnum==1
                imwrite(maxprojchan,fileOut,'Compression','none');
                else
                    imwrite(maxprojchan,fileOut,'writemode','append','Compression','none');
                end
                    
                
            end
            


end

disp('Finished')

%% Plate 3

clear all
pathtodata = '/Volumes/Elena-2020/220404_ControlExp_Exp56_2/Plate3_Cycle_01';
pathtosavedata = '/Volumes/Elena-2020/220404_ControlExp_Exp56_2';
mkdir([pathtosavedata, filesep, 'MaxProj'])

allfiles = dir([pathtodata filesep '*.oir']);
platenumber = '3';
coordrow = 8;
nwellsinrow = 6;

NZstacks = 3;
NChannels = 4;
Npositions = 4;

sX = 1024;
sY = 1024;


for filenum = 1:length(allfiles)
            
            %File in
            fileIn = allfiles(filenum).name
            
            %For new name
            platenumber = platenumber;
            rownumber = double(fileIn(coordrow))-'A'+1;
            wellinrow = str2num(fileIn(coordrow+2));
            wellnumber = num2str((rownumber - 1)*nwellsinrow+wellinrow);
%             posstr = strfind(fileIn,'_G0');
%             positionnumber = str2num(fileIn(posstr+(2:4)));
%             positionnumber = num2str(positionnumber-(str2num(wellnumber)-1)*Npositions);
            positionnumber = fileIn(end-4);
            
            fileOut = [pathtosavedata filesep 'MaxProj/P',platenumber,'_W',wellnumber,'_',positionnumber,'_MAXProj.tif']
            
            img=bfopen([pathtodata filesep fileIn]);


            for channelnum = 1:NChannels
                z=1;
                idx = channelnum+(z-1)*NChannels;
                imaux = img{1}{idx,1};
                maxprojchan = imaux;
                
                for z = 2:NZstacks
                    idx = channelnum+(z-1)*NChannels;
                    imaux = img{1}{idx,1};
                    
                    maxprojchan = max(maxprojchan,imaux);
                    
                    
                    
                end
                
                if channelnum==1
                imwrite(maxprojchan,fileOut,'Compression','none');
                else
                    imwrite(maxprojchan,fileOut,'writemode','append','Compression','none');
                end
                    
                
            end
            


end

disp('Finished')
