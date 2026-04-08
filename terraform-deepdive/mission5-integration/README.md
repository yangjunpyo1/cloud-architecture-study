# Mission 5 - 통합 & 모듈화 (dev/prod 환경 분리)

미션 1~4에서 구축한 인프라를 재사용 가능한 모듈로 리팩토링하고 dev/prod 환경을 분리합니다.

---

## 아키텍처 개요
modules/
├── networking/   → VPC, SG, IAM (Mission 1)
├── secrets/      → SSM, Secrets Manager (Mission 2)
├── messaging/    → SNS, SQS (Mission 3)
└── cache/        → ElastiCache Redis (Mission 4)
environments/
├── dev/          → 모듈 호출 + 작은 사양
└── prod/         → 모듈 호출 + 큰 사양

---

## Dev vs Prod 비교

| 항목 | Dev | Prod |
|---|---|---|
| VPC CIDR | 10.0.0.0/16 | 10.1.0.0/16 |
| NAT Gateway | 1개 | 2개 |
| Redis 노드 | cache.t3.micro | cache.t3.small |
| Redis 클러스터 | 1개 (Single) | 2개 (Multi-AZ) |
| Redis 백업 | 1일 | 7일 |
| Secret 복구기간 | 7일 | 30일 |
| apply_immediately | true | false |

---

## Terraform 파일 구조
mission5-integration/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── secrets/
│   ├── messaging/
│   └── cache/
└── environments/
├── dev/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
└── prod/
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars

---

## 배운 점

- 미션1~4 코드를 모듈로 변환하여 재사용 가능하게 만듦
- 같은 모듈로 dev/prod 환경을 변수값만 다르게 배포
- 모듈 Output 체이닝으로 모듈 간 의존성 연결
- `lifecycle prevent_destroy`로 prod 리소스 실수 삭제 방지
- 환경별 차등 설정으로 비용 최적화

---

## 실습 증빙

### Dev 환경 terraform output 확인

<img width="900" alt="output" src="https://github.com/user-attachments/assets/b6e1e738-85e2-477e-bd9c-f9a9ad852141" />

---

### VPC 확인

<img width="900" alt="vpc" src="https://github.com/user-attachments/assets/40e21de1-5bd2-41d3-8769-b8fc5821b2fa" />

---

### ElastiCache Redis 확인

<img width="900" alt="elasticache" src="https://github.com/user-attachments/assets/e096e323-5e7b-4267-a10c-9ca9ea8f4c5a" />

---

### SNS/SQS 확인

<img width="900" alt="sns" src="https://github.com/user-attachments/assets/37b9387e-68e3-4e5a-98d4-94c2cbb8f952" />

<img width="900" alt="sqs" src="https://github.com/user-attachments/assets/8cb87b72-471f-47cb-a404-f49e96a938e2" />
