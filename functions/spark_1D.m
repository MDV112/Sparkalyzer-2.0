function [spark_cell] = spark_1D(I,spark_handles_Position)
%% Function description:
% This function calculates the 1D sparks of all of marked LCR and thus
% should only be applied after  pusing the button "analyze & save" and thus
% the spark_handles is an array of handles of marked LCR.
%% Inputs:
% I: normalized image.
% spark_handles_Position is assumed to be an array of position handles in
% the size of NX4.
%% Outputs:
% spark_cell: a cell with filtered 1D sparks,
%%
    N = size(spark_handles_Position,1);
    spark_cell = cell(1,N);
    spark_handles_Position = round(spark_handles_Position);
    for i = 1:N
        xmin = spark_handles_Position(i,1);
        ymin = spark_handles_Position(i,2);
        width = spark_handles_Position(i,3);
        height = spark_handles_Position(i,4);
        y = mean(I(ymin-height:ymin,xmin:xmin+width));
        spark_cell{i} = sgolayfilt(y,1,45);
    end
end