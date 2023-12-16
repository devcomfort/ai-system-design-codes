clc;
clear;
close all;

% === 파일 읽기 ===
load simplecluster_dataset;
X = simpleclusterInputs';

% === 데이터 시각화 ===
color_set = [".b", ".g", ".r", ".k"];

% === K Means 수행 ===
% 1. 군집 수 설정
max_k = 10; % 최대 군집 수
wss = zeros(max_k, 1); % 군집의 총 거리 제곱합

for k = 1:max_k
    % 2. 초기 중심점 설정
    rand_idx = randperm(height(X), k);
    center = X(rand_idx, :);

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
    end

    % 실시간으로 군집 배정 결과 확인하기
    figure(2);
    cla;
    hold on;

    for i = 1:k
        try
            scatter(X(labels == i, 1), X(labels == i, 2), color_set(i));
            scatter(center(:, 1), center(:, 2), '*r', 'LineWidth', 3);
        end
    end

    pause(0.2);

    % 군집의 총 거리 제곱합 계산
    for i = 1:k
        wss(k) = wss(k) + sum(vecnorm(X(labels == i, :) - center(i, :), 2, 2).^2);
    end
end

% Elbow plot 그리기
figure(3);
plot(1:max_k, wss, '-o');
xlabel('Number of clusters (k)');
ylabel('Within-cluster sum of square');
title('Elbow Method For Optimal k');
grid on;
