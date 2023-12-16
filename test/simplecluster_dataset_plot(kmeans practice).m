clc;
clear;
close all;

load simplecluster_dataset;
X = simpleclusterInputs;

color_set = [".b", ".g", ".m", ".k"];

hold on;

for i = 1:length(X)
    color_idx = find(simpleclusterTargets(:, i) == 1);
    plot(X(1, i), X(2, i), color_set(color_idx));
end

% Kmeans 군집화 수행
[idx, center] = kmeans(simpleclusterInputs', 4);

% 결과 그래프 나타내기
for i = 1:length(X)
    color_idx = idx(i);
    plot(X(i, 1), X(i, 2), color_set(color_idx));
    scatter(center(:, i), center(:, 2), '*r', 'LineWidth', 3);
end
