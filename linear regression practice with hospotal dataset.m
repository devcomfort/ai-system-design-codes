clc;
close all;
clear;

load hospital;

x = hospital.Weight;  % 체중
y = hospital.Smoker;  % 흡연 여부
dataset = [x, y];

iteration = 10000;
alpha = 0.01;  % 학습률

% 데이터 정규화 1: 데이터 결측치 제거
dataset(logical(sum(isnan(dataset), 2)), :) = [];  % NaN값을 가진 행 제거
x = dataset(:, 1);
y = dataset(:, 2);

% 데이터 정규화 2: 데이터 범위 수정
x = (x - min(x)) / (max(x) - min(x));  % Min-Max 정규화

plot(x, y, '*')

m = length(x);
X = [ones(m, 1), x];  % 절편을 위한 1 벡터 추가
theta = zeros(2, 1);  % theta 초기화 (절편과 기울기)
hold on;
for i = 1:iteration
	h = X * theta;  % 가설 함수
	delta = (1/m) .* (X'*(h - y));  % 경사 하강법
	theta = theta - alpha * delta;  % theta 업데이트
    
    if mod(i, 1000) == 0
        x_ = linspace(0, 1);
        y_ = theta(1) + theta(2) * x_;
        plot(x_, y_);

        fprintf('cost(%5d): %f\n', i, 1 / (2*m) * sum((h-y).^2));  % 비용 함수 출력
    end
end

% === plot ===
x_ = linspace(0, 1);
y_ = theta(1) + theta(2) * x_;
plot(x_, y_);
