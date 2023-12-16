clc;
clear;
close all;

% : NOTE :
% 단순히 simplecluster_dataset을 불러와 로드하는 코드입니다

load simplecluster_dataset;
X = simpleclusterInputs;

figure(1);
hold on;
color_set = [".b", ".g", ".m", ".k"];

for i = 1:length(X)
    color_idx = find(simpleclusterTargets(:, i) == 1);
    plot(X(1, i), X(2, i), color_set(color_idx));
end
