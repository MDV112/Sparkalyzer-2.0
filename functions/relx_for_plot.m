function [relx_50, relx_90, time2peak] = relx_for_plot(y,pks,locs)
%% Function description:
% This function calculates all needed from transients. It should only be 
% applied after "Approve" where the pks and locs were updated as needed.
% This is only for plotting because it returnes indices.
%% Inputs:
% y: filtered 1D of the whole normalized image extracted
% auto_transient_calc.
% t: time vector in [sec] extracted from read_disp_img_first.
% pks: values of peaks extracted from auto_transient_calc.
% locs: indices of peaks extracted from auto_transient_calc.
%% Outputs:
% All of the outputs are arrays at the size of number of peaks (N) except 
% cyc_length and HR that they are at the size of (N-1).
% NEEDS TO BE FIXED BECAUSE ONE IS SENT TO TABLE (IN SEC) AND ONE IS SENT
% TO PLOT (INDICES).
%%
    N = length(pks);
    time2peak = zeros(1,N);
    relx_50 = zeros(1,N);
    relx_90 = zeros(1,N);
    for idx = 1:length(locs)
        loc = locs(idx);
        tmp_pre = y(1:loc-1);
        tmp_post = y(loc:end);
%         time2peak(idx) = find(tmp_pre > 0.9*pks(loc), 1, 'last');
        if isempty(find(tmp_pre > 1, 1, 'last'))
            time2peak(idx) = nan;
        else
            time2peak(idx) = find(tmp_pre > 1, 1, 'last');
        end
            
        % or maybe find the first time where the amplitude is below i.e
        % below F0 though it's not really like that because of the sgolayfilt
        rel_50 = find(pks(loc) - tmp_post > 0.5*pks(loc), 1, 'first');
        relx_50(idx) = rel_50 + loc;
        rel_90 = find(pks(loc) - tmp_post > 0.9*pks(loc), 1, 'first');
        relx_90(idx) = rel_90 + loc;
    end
end