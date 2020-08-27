function [F0, flag] = calc_F0(I, F0_handles_Position)
%% This function calculates the background as the mean of the selected ROI.
% We might consider of not saving the handle as a whole but only it's
% position property.
%% Inputs:
% I: Original image after first preprocessing (called I2 in read_disp_img).
% F0_handles_Position: The propery posittion of drawrectangle handle.
%% Outputs:
% F0: the background value that would be used for normalization.
% flag: Once this function was applied the "sent" image for every function
% should be normalized
%%
    F0_handles_Position = round(F0_handles_Position);
    xmin = F0_handles_Position(1);
    ymin = F0_handles_Position(2);
    width = F0_handles_Position(3);
    height = F0_handles_Position(4);
    F0 = mean(mean(I(ymin-height:ymin,xmin:xmin+width)));
    flag = 1;
end