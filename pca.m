clc;
clear;
close all;

% === 파일 읽기 ===
load simplecluster_dataset;
X = simpleclusterInputs';

% === PCA 수행 ===
[coeff, score, ~] = pca(X);

% === K Means 수행 ===
% 1. 군집 수 설정 (PCA에 의해 데이터의 차원 수 이하로만 설정 가능, simplecluster_dataset이 2차원 데이터를 사용하여 k도 2가 최대)
k = 2;

% 2. PCA 결과를 기반으로 초기 중심점 설정
center = coeff(:, 1:k)';

% 3. 데이터를 군집에 할당하고 중심점 재설정하기
iterations = 10;

for iter = 1:iterations
    labels = zeros(height(X), 1);

    % 데이터를 군집에 할당하기
    for j = 1:height(X)
        dist = vecnorm(center - X(j,:), 2, 2);
        [~, arg] = min(dist);
        labels(j) = arg;
    end

    % 중심점 재설정하기
    for i = 1:k
        center(i, :) = mean(X(labels == i, :));
    end

    % 실시간으로 군집 배정 결과 확인하기
    color_set = [".b", ".g", ".r", ".k"];
    cla;
    hold on;

    for i = 1:k
        scatter(X(labels == i, 1), X(labels == i, 2), color_set(i));
        scatter(center(:, 1), center(:, 2), '*r', 'LineWidth', 3);
    end

    pause(0.2);
end

