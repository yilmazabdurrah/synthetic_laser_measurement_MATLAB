# fake_laser_measurement_MATLAB
Fake laser measurements from occupancy grid map

When you run the FakeLaserRead.m script
1) Reads map from a file with ".pgm" extension and its properties from a file with ".yaml" extension
2) Asks to select a suitable free point on the map
3) Generates fake laser measurements according to laser scanner range and resolution settings
4) Draws selected point (blue color), fake laser measurements on map (red color), and laser range circle (dashed-black color)

**Example for mymap in maps folder**

_1) Asking point selection for maps/mymap_

![](https://github.com/yilmazabdurrah/fake_laser_measurement_MATLAB/blob/main/figures/SelectPointMap.png?raw=true)

_2) Drawn fake laser measurements for maps/mymap, laserRange = 5 m, laserResolution = 0.25 degrees_

![](https://github.com/yilmazabdurrah/fake_laser_measurement_MATLAB/blob/main/figures/FakeLasersMap.PNG?raw=true)

**Example for mymap2 in maps folder**

_1) Asking point selection for maps/mymap2_

![](https://github.com/yilmazabdurrah/fake_laser_measurement_MATLAB/blob/main/figures/SelectPointMap2.png?raw=true)

_2) Drawn fake laser measurements for maps/mymap2, laserRange = 30 m, laserResolution = 0.25 degrees_

![](https://github.com/yilmazabdurrah/fake_laser_measurement_MATLAB/blob/main/figures/FakeLasersMap2.PNG?raw=true)

Please note that, the codes available at [^1] for reading YAML file and at [^2] for drawing Bresenham's Line for four quadrants are utilized.

[^1]: https://github.com/llerussell/ReadYAML
[^2]: https://github.com/ashiagarwal73/Bresenham-s-line-algorithm-for-all-quadrants
