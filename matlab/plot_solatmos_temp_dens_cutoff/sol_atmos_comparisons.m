 
%% run these scripts first
%%loadcutfofdata
%%loadatmos 
%%computecutoff

f=figure;
  set(f, 'Units', 'centimeters');
  set(f, 'Position', [2 2 28 28]);
  hold on;
  
  t=tiledlayout(1,2);
  
  



nexttile;

%% plot density and temperature (VALIIIc)
% Create a plot with 2 y axes using the plotyy function
%figure
[ax, h1, h2] = plotyy(height/1000000, log10(temp), height/1000000, log10(dens), 'plot');

% Add title and x axis label
xlabel('Height (Mm)')
title('VALIIIc Solar Atmosphere Model')
% Use the axis handles to set the labels of the y axes
set(get(ax(1), 'YLabel'), 'String', 'Log T')
set(get(ax(2), 'YLabel'), 'String', 'Log Density')

nexttile

%% plot cutoof and soundspeed
% Create a plot with 2 y axes using the plotyy function
%figure
[ax, h1, h2] = plotyy(height./1e6,atc0,height/1000000, cs/1000, 'plot');

% Add title and x axis label
xlabel('Height (Mm)')
title('VALIIIc Solar Atmosphere Model')
% Use the axis handles to set the labels of the y axes
set(get(ax(1), 'YLabel'), 'String', 'Cut Off Period (s)')
set(get(ax(2), 'YLabel'), 'String', 'Sound Speed (km/s)')


