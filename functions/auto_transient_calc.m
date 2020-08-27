function [locs,pks,y] = auto_transient_calc(I,t)
%% Function description:
% This function calculate the peaks automatically once F0 is chosen. y
% should be plotted in the axis below with scattered pks at the indices
% locs. Final peaks would be approved by pushing "Approve" button. If
% maximas were changed manually by the user, it should be updated.
%% Inputs:
% I: normalized image.
% t: time vector in [sec].
%% Outputs:
% locs: indices of maximas along the time axis (integers).
% pks: values of y in locs.
% y: filtered 1D of the whole image.
%%
    y = mean(I);
    y = sgolayfilt(y,1,45);
%     y = y/F0; %normalization of Y
    %   Y(Y < 1) = 1./(Y(Y < 1));
    %Y = 1./Y;
    [~,locs] = findpeaks(y/prctile(y,90),t,'NPeaks',10,'SortStr',...
        'descend','MinPeakHeight',1,'MinPeakDistance',0.3); % minimum peak distance of 0.3 sec
    pks = y(locs); % it is not the same as replacing it with ~ above. These are the values of the normalized peaks by F0 and not by 90 prctile
end