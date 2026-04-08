# Mission 2 - 비밀 관리 (SSM Parameter Store + Secrets Manager)

민감 정보와 환경 설정값을 안전하게 저장하고 관리합니다.

---

## 구성 리소스

| 리소스 | 이름 | 설명 |
|---|---|---|
| SSM Parameter | /yjp-deepdive/app/port | 앱 포트 (8080) |
| SSM Parameter | /yjp-deepdive/app/log_level | 로그 레벨 (DEBUG/WARN) |
| SSM Parameter | /yjp-deepdive/redis/port | Redis 포트 (6379) |
| SSM Parameter | /yjp-deepdive/feature/cache_enabled | 캐시 Feature Flag |
| Secret | yjp-deepdive/redis-auth-token | Redis 인증 토큰 |
| Secret | yjp-deepdive/db-credentials | DB 접속 정보 (JSON) |
| Secret | yjp-deepdive/external-api-key | 외부 API 키 |

---

## Terraform 파일 구조
```
mission2-secrets/
├── main.tf           # 리소스 생성
├── variables.tf      # 변수 선언
├── outputs.tf        # 출력값
└── terraform.tfvars  # 실제 변수 값
```

---

## 배운 점

- SSM Parameter Store vs Secrets Manager 용도 구분
- `random_password`로 안전한 비밀번호 자동 생성
- `sensitive = true`로 민감 정보 Output 마스킹
- `terraform_remote_state`로 Mission 1 Output 참조
- `jsonencode()`로 DB 접속 정보 JSON 구조 생성

---

## 실습 증빙

### SSM Parameter Store 확인

<img width="900" alt="ssm" src="https://github.com/user-attachments/assets/f64cefb5-5996-4560-b676-49ebac356d91" />

---

### Secrets Manager 확인

<img width="900" alt="secrets" src="https://github.com/user-attachments/assets/c63d8338-628c-42e2-abb6-86bd9bbaad73" />
