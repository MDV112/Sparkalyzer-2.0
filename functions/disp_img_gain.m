function [] = disp_img_gain(I,map, h_axes, gain, flag)
%% Function description:
% This function displays the normalized gained image on the upper axes.
% This function should be synchronized with the toggle bar of amplification.
%% Inputs:
% I: image. Can be the normalized or not normalized.
% map: colormap extracted from read_disp_first.
% h_axes: axes handle of the upper image.
% gain: extracted from the toggle bar.
% flag: binary extracted from calc_F0 for indicating if the image is normalized (1) or not
% normalized (0).
%%
    imshow(gain*I,[],'InitialMagnification','fit','Parent',h_axes) % consider "refresh" the data
    colormap(map)
    % I don't know if we should change the bar or not but if so, we should do
    % the code in the comments below.

    %{
    I2 = im2double(gain*I);
    cLow = min(I2(:));
    cHigh = max(I2(:));
    z = get(colorbar,'Ticks');
    z2 = length(z);
    TicColor = linspace(cLow,cHigh,z2); %color bar range
    TicColor = round(TicColor * 100) / 100; %double precision
    colorbar('Ticks',z,'TickLabels',TicColor); %sets the colorbar
    %}

    if flag == 1
        title('F/F_0')
    else
        title('F')
    end
end