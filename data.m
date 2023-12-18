clc;
clear;
close all;

% 데이터 불러오기
data = readtable('./superstore_train.csv', 'VariableNamingRule', 'preserve');

% 데이터를 시간 순서대로 정렬
data = sortrows(data, "Order Date"); 

% 각 변수 추출
order_date = data{:, "Order Date"};
discount = data{:, "Discount"};

% timetable 생성
tt_discount = timetable(datetime(order_date, 'InputFormat', 'yyyy-MM-dd', 'Locale', 'en_US'), discount);

% timetable을 table로 변환
table_discount = timetable2table(tt_discount);

% table에서 'Time' 변수 제외
table_discount.Time = [];

% table을 벡터로 변환
vec_discount = table_discount.discount;

% 벡터를 행렬로 묶음
input_data = vec_discount;
