% Airline Passenger Satisfaction의 25가지 요소에 대해 PCA를 수행하고 히트맵으로 그리는 코드입니다

clc;
clear;
close all;

% === 파일 읽기 ===
% csvread, readmatrix 등을 사용하면 텍스트를 읽을 수 없어 readtable 함수를 사용함
train = readmatrix('./dataset/train.csv');
test = readmatrix('./dataset/test.csv');

% === 정규화 ===
% NOTE: 파이썬 정규화 과정에서는 변환만 수행하여, 별도로 불필요한 로직 제거 과정을 추가하는 과정
% : id열 제거 (정규화 과정에서 pandas에 의해 붙은 열 + 원래 있던 id 열)
% : 헤더 행 제거
train = train(2:length(train), 3:26);
test = test(2:length(test), 3:26);

% === PCA 수행 ===
[coeff,score,latent,tsquared,explained,mu] = pca(train);

h = heatmap(coeff);
title("계수별 기여도")