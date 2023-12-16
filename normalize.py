import pandas as pd
import numpy as np

"""_summary_
[Airline Passenger Satisfaction | Kaggle](https://www.kaggle.com/datasets/teejmahal20/airline-passenger-satisfaction/) 데이터셋은 문자열이 포함된 csv 파일입니다.

Matlab이 문자열 파일을 올바르게 식별하지 못해, Matlab 사용을 위해 정규화 하는 코드입니다.
"""

# === 데이터 로드 ===
train = pd.read_csv('./origin_dataset/train.csv') # 훈련 데이터셋
test = pd.read_csv('./origin_dataset/test.csv') # 검증 데이터셋

# === 데이터 변환 ===
# 훈련 데이터셋 변환
for col in train.columns:
    if train[col].dtype == 'object':  # 열의 데이터 타입이 object일 경우, 이는 열거형 변수를 의미합니다.
        train[col] = pd.Categorical(train[col]).codes  # 열거형 변수를 레이블 인코딩하여 숫자형으로 변환합니다.
    elif train[col].dtype == 'bool':  # 열의 데이터 타입이 boolean일 경우
        train[col] = train[col].astype(int)  # 참(True)과 거짓(False)을 1과 0으로 변환합니다.

# 검증 데이터셋 변환
for col in test.columns:
    if test[col].dtype == 'object':  # 열의 데이터 타입이 object일 경우, 이는 열거형 변수를 의미합니다.
        test[col] = pd.Categorical(test[col]).codes  # 열거형 변수를 레이블 인코딩하여 숫자형으로 변환합니다.
    elif test[col].dtype == 'bool':  # 열의 데이터 타입이 boolean일 경우
        test[col] = test[col].astype(int)  # 참(True)과 거짓(False)을 1과 0으로 변환합니다.


# === 데이터 저장 ===
train.to_csv('./dataset/train.csv')
test.to_csv('./dataset/test.csv')