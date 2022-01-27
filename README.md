# fake_laser_measurement_MATLAB
Fake laser measurements from occupancy grid map

When you run the FakeLaserRead.m script
1) Reads map from a file with ".pgm" extension and its properties from a file with ".yaml" extension
2) Asks to select a suitable free point on the map
3) Generates fake laser measurements according to laser scanner range and resolution settings
4) Draws selected point (blue color), fake laser measurements on map (red color), and laser range circle (dashed-black color)

Example for mymap in maps folder

Asking point selection

!Select Point mymap(https://github.com/yilmazabdurrah/fake_laser_measurement_MATLAB/blob/main/figures/SelectPointMap.png?raw=true)

Drawn fake laser measurements for laserRange = 5 m, laserResolution = 0.25 degrees

!Fake laser measurements mymap(https://github.com/yilmazabdurrah/fake_laser_measurement_MATLAB/blob/main/figures/FakeLasersMap.png?raw=true)

Example for mymap2 in maps folder

Asking point selection

Drawn fake laser measurements for laserRange = 30 m, laserResolution = 0.25 degrees

