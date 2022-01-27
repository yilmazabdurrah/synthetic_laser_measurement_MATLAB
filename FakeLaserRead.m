%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Fake Laser Measurements from Certain Point on the Map %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Date    : 25 January 2022
% Author  : Abdurrahman Yilmaz
% Version : v01
% Info    : Fake laser measurements from a certain point on an occupancy
% grid map used in ROS environment
% Code    : https://github.com/yilmazabdurrah
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all

%% Initial settings
mapImage = imread('maps\mymap.pgm');
MapSettings = ReadYamlFile('maps\mymap.yaml');

laserRange = 5; % m
laserRes = 0.25; % deg

%% Load map
imageNorm = double(mapImage)/255;
imageBW = 1 - imageNorm;
map = occupancyMap(imageBW,1/MapSettings.resolution);
map.GridLocationInWorld = MapSettings.origin(1,1:2); 
map.OccupiedThreshold = MapSettings.occupied_thresh;
map.FreeThreshold = MapSettings.free_thresh;

%% Select desired point on the map
figure
show(map)
set(gca,'FontSize',15)
while(1)
    [xc, yc] = ginput(1); % select desired point on map

    xyMap2World = map.GridLocationInWorld;

    yGrid = map.GridSize(1,1);
    xyPixel = round(([xc, yc] - xyMap2World)*map.Resolution);
    xyPixel(1,2) = yGrid - xyPixel(1,2) + 1;
    if imageBW(xyPixel(1,2),xyPixel(1,1)) < map.FreeThreshold
        disp('Selected point is acceptable, the cell is free!')
        break;
    else
        disp('Selected point is NOT acceptable, the cell is occupied or unknown!')
    end
end

%% Take measurements
pixelRange = ceil(laserRange*map.Resolution);

start_xy = fliplr(xyPixel); % flipped since map is (y,x)
FakeLaserMeas = [];
for ang = 0:laserRes:360-laserRes
    pixelyx = ceil([pixelRange*sind(ang), pixelRange*cosd(ang)]);
    end_xy = start_xy + pixelyx;
    if start_xy(1,1) <= end_xy(1,1)
        [LineElements] = BresenhamLineFourQuadrant(start_xy,end_xy);
    else
        [LineElements] = BresenhamLineFourQuadrant(end_xy,start_xy);
        LineElements = flipud(LineElements);
    end

    for i = 1:1:size(LineElements,1)
        if any(size(imageBW) - LineElements(i,:) < 0) || LineElements(i,1) <= 0 || LineElements(i,2) <= 0 
            gridMeas_xy = [NaN, NaN]; % m
            break;
        elseif imageBW(LineElements(i,1),LineElements(i,2)) >= map.OccupiedThreshold
            gridMeas_pixel_xy = fliplr(LineElements(i,:));
            gridMeas_pixel_xy(1,2) = yGrid - gridMeas_pixel_xy(1,2) + 1;
            gridMeas_xy = gridMeas_pixel_xy/map.Resolution + map.GridLocationInWorld;
            break;
        else
            gridMeas_xy = [NaN, NaN]; % m
        end
    end
    FakeLaserMeas = [FakeLaserMeas;gridMeas_xy];
end

hold on
plot(FakeLaserMeas(:,1),FakeLaserMeas(:,2),'r.') % Laser measurements
plot(xc, yc,'b.','MarkerSize',20) % Selected point
viscircles([xc, yc],laserRange,'Color', 'k','LineStyle','--', 'LineWidth',1) % Draw range circle

