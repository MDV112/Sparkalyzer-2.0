function [I2, t, t_res, len_res] = read_disp_img_first(fname,h_axes)
%% Function description:
% The function should be read only at the first time that a cell is picked.
% It reads an lsm file and displays it on the upper axes
% including time and length extracted from lsminfo. The colormap is the one
% extracted from the microscop.
%% Inputs:
% fname: lsm file name (consider add the pathe from the GUI)
% h_axes: axes handle of the upper image
%% Outputs:
% I2: the non-normalized image after minor filtering.
% t: time vector in [sec].
% t_res: time resolution in [sec].
% len_res: length resolution in [m].
%%
    [lsminf,~,~] = lsminfo(fname);
    [img,map] = imread(fname); % maybe should add path
    axes(h_axes); % axes of upper image
    img = imrotate(img,90);
    tmp = medfilt2(img, [3 3]);
    smooth_img = imgaussfilt(tmp);
    imshow(smooth_img,[],'InitialMagnification','fit','Parent',h_axes)
    colormap(map)
    s = size(smooth_img);
    I2 = im2double(smooth_img); % Notice it does not include the gain because the gain is used only for visualization
    cLow = min(I2(:));
    cHigh = max(I2(:));
    z = get(colorbar,'Ticks');
    z2 = length(z);
    TicColor = linspace(cLow,cHigh,z2); %color bar range
    TicColor = round(TicColor * 100) / 100; %double precision
    colorbar('Ticks',z,'TickLabels',TicColor); %sets the colorbar

    %% Define lables to X according to Slice time
    t = lsminf.TimeStamps.TimeStamps;
    t_res = mean(diff(t));
    xticklabels = linspace(0,t(end),20);
    xticklabels = round(xticklabels*10)/10; 
    xticks = linspace(1,s(2),numel(xticklabels));
    set(h_axes, 'XTick', xticks, 'XTickLabel', xticklabels);
    xlabel('Time [sec]');
    %% Define lables to Y according to LCR length
    len_res = lsminf.VOXELSIZES(1);
    len = len_res*lsminf.DimensionX;
    yticklabels = linspace(0,len*1e6,20);
    yticklabels = round(yticklabels*10)/10;
    yticks = linspace(1,s(1),numel(yticklabels));
    set(h_axes, 'YTick', yticks, 'YTickLabel', flipud(yticklabels(:)));
    ylabel('Length [\mum]');
    title('F')
end