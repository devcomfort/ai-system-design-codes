clc;
clear;
close all;

% === 파일 읽기 ===
train = textread('./train.csv', '%s %d %d', 'delimiter', ',', 1)
test = csvread('./test.csv');

train(1:5, :)
