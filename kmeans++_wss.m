clc;
clear;
close all;

% === 파일 읽기 ===
load simplecluster_dataset;

iterations = 100;
wss_history = zeros(100, iterations);

for attempt = 1:100
  X = simpleclusterInputs';

  % === K-means++로 초기 중심점 설정 ===
  k = 4;
  center = zeros(k, size(X, 2));
  center(1, :) = X(randi(size(X, 1)), :);  % 첫번째 중심점에는 임의 중심점 설정
  for i = 2:k
      % 정규 분포 계산
      dist = min(pdist2(X, center(1:i-1, :)), [], 2);  
      probs = dist / sum(dist);
      center(i, :) = X(randsample(1:size(X, 1), 1, true, probs), :);  % 다음 중심점 지정
  end

  % === K Menas 수행 ===
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

      % WSS 계산하기
      wss = 0;

      for i = 1:k
          dist = vecnorm(X(labels == i, :) - center(i, :), 2, 2);
          wss = wss + sum(dist.^2);
      end

      wss_history(attempt, iter) = wss;

      % 실시간으로 군집 배정 결과 확인하기
      color_set = [".b", ".g", ".r", ".k"];
      figure(2);
      cla;
      hold on;

      for i = 1:k
          scatter(X(labels == i, 1), X(labels == i, 2), color_set(i));
          scatter(center(:, 1), center(:, 2), '*r', 'LineWidth', 3);
      end

      pause(0.2);
  end
end

figure(2);
plot(wss_history(:, :), 'DisplayName', 'wss_history(:,:)', YDataSource = 'wss_history(:,:)');
linkdata on;
title("K-Means++ WSS");
ylabel("wss_history(:,:)");
xlabel("학습 시행 횟수")
legend("show");
