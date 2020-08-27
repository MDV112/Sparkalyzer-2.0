function [t_50, t_90, t_2_peak, cyc_length, HR] = relx_HR_for_table(t,relx_50, relx_90, time2peak, locs)
%% Function description:
% This function simply returns the actual values of the calculated indices
% extracted in relx_for_plot. The added two values as well as the first
% ones will be added to the table later on.
%% Inputs:
% t: time vector in [sec]
% relx_50: indices of 50% relaxation time.
% relx_90: indices of 90% relaxation time.
% time2peak: indices of the closest minimas.
% locs: indices of peaks.
%% Outputs:
% t_50: duration of 50% relaxation time in [ms].
% t_90: duration of 90% relaxation time in [ms].
% t_2_peak: time to peak in [ms].
% cyc_length: cycle length in [ms].
% HR: heart rate in [bpm].
%%
    t_50 = 1e3*(t(relx_50) - t(locs));
    t_90 = 1e3*(t(relx_90) - t(locs));
    t_2_peak = 1e3*(t(locs)-t(time2peak));
    cyc_length = diff(t(locs));
    HR = 60./mean(cyc_length);
    cyc_length = 1e3*[nan cyc_length]; % first peak is not a cycle
end