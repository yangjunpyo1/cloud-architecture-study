# Mission 3 - 메시징 파이프라인 (SNS + SQS)

이벤트 기반 비동기 메시징 파이프라인을 Terraform으로 구축합니다.

---

## 아키텍처 개요
```
주문 발생
    ↓
SNS Topic (order-events)
    ↓
order-process 큐  → 결제 처리
order-notify 큐   → 고객 알림
order-analytics 큐 → 데이터 분석
```

---

## 구성 리소스

| 리소스 | 이름 | 설명 |
|---|---|---|
| SNS Topic | yjp-deepdive-order-events | 주문 이벤트 발행 채널 |
| SQS Queue | yjp-deepdive-order-process | 결제 처리 큐 (가시성 60초) |
| SQS Queue | yjp-deepdive-order-notify | 알림 발송 큐 (가시성 30초) |
| SQS Queue | yjp-deepdive-order-analytics | 데이터 분석 큐 (가시성 120초) |
| DLQ | yjp-deepdive-order-process-dlq | 결제 실패 메시지 보관 |
| DLQ | yjp-deepdive-order-notify-dlq | 알림 실패 메시지 보관 |
| DLQ | yjp-deepdive-order-analytics-dlq | 분석 실패 메시지 보관 |

---

## Terraform 파일 구조
```
mission3-messaging/
├── main.tf           # 리소스 생성
├── variables.tf      # 변수 선언
├── outputs.tf        # 출력값
└── terraform.tfvars  # 실제 변수 값
```

---

## 배운 점

- SNS Fan-out 패턴으로 1:n 메시지 동시 전달
- SQS DLQ로 실패 메시지 보관 및 재처리
- `for_each`로 큐 3개를 코드 한 번에 생성
- IAM Policy ArnEquals 조건으로 특정 SNS Topic만 허용
- `raw_message_delivery = true`로 원본 메시지 그대로 전달
- 비동기 처리로 서버 과부하 방지

---

## 실습 증빙

### SNS Topic 확인

<img width="900" alt="sns" src="https://github.com/user-attachments/assets/80256728-e68c-45a1-a744-dc5b9d7163d1" />

---

### SQS 대기열 확인

<img width="900" alt="sqs" src="https://github.com/user-attachments/assets/b4400c77-615f-44ae-8f0c-a18e3a394e78" />
