function [prc_50_duration, norm_amp, amp_diff, spark_length, t_diff_spark_trans] = LCR_calc(locs,pks,len_res,t_res,spark_cell)
%% Function description:
% This function returns the needed LCR calculations to later on appear in
% the analysis table. 
%% Inputs:
% locs: indices of peaks extracted from auto_transient_calc.
% pks: normalized 1D sparks values located in locs. Also extracted from 
%auto_transient_calc.
% len_res: length image resolution extracted from read_disp_img_first.
% t_res: time resolution extracted from read_disp_img_first.
% spark_cell: cell containing the 1D sparks extracted from spark_1D.
%% Outputs:
% All outputs are 1D array at the size of number of LCR.

% prc_50_duration: 50% duration of LCR in [ms].
% norm_amp: normalized amplitue of spark maxima.
% amp_diff: normalized amplitude difference between the closest peak (the
% one to the left of the LCR) and the LCR maxima.
% spark_length: LCR length in [um];
% t_diff_spark_trans: time difference between the closest peak and maxima
% of the LCR.
%%
% Notice that in the gui we flip ydata of the image
    N = length(spark_cell);
    prc_50_duration = zeros(1,N);
    norm_amp = zeros(1,N);
    amp_diff = zeros(1,N);
    spark_length = zeros(1,N);
    t_diff_spark_trans = zeros(1,N);
    for i = 1:N
        prc_50_duration(i) = 1e3*t_res*0.5*width;
        spark_1D = spark_cell{i};
        [norm_amp(i),spark_peak_idx] = max(spark_1D);
        spark_peak_idx = spark_peak_idx + xmin; % for aligning with transient locs
        [~,closest_transient_idx] = min(abs(locs-spark_peak_idx));
        if locs(closest_transient_idx) > spark_peak_idx
            t_diff_spark_trans(i) = NaN; % because the condition indicates that there is no transient before the LCR
        else
            closest_transient = locs(closest_transient_idx);
        end
        amp_diff(i) = pks(closest_transient) - norm_amp(i);
        spark_length(i) = 1e6*len_res*height;
        t_diff_spark_trans(i) = 1e3*t_res*(spark_peak_idx - closest_transient);
    end
end