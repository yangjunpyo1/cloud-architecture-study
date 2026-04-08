# Mission 4 - 캐시 계층 (ElastiCache Redis)

고속 읽기가 필요한 데이터를 메모리에 캐시하는 Redis 서버를 Terraform으로 구축합니다.

---

## 아키텍처 개요
```
EC2 앱 서버
    ↓
Redis (ElastiCache)
    ↓
자주 읽는 데이터 → Redis에서 빠르게 응답 (1ms)
없는 데이터      → RDS에서 읽고 Redis에 저장
```

---

## 구성 리소스

| 리소스 | 이름 | 설명 |
|---|---|---|
| ElastiCache Subnet Group | yjp-deepdive-redis-subnet-group | Private Subnet 2개 묶음 |
| ElastiCache Replication Group | yjp-deepdive-redis | Redis 서버 |
| SSM Parameter | /yjp-deepdive/redis/host | Redis Primary Endpoint 저장 |

---

## Redis 설정

| 항목 | 값 | 설명 |
|---|---|---|
| 엔진 | Redis 7.1 | 최신 안정 버전 |
| 노드 타입 | cache.t3.micro | Dev 환경 최소 사양 |
| 포트 | 6379 | Redis 기본 포트 |
| TLS | 활성화 | 전송 중 암호화 |
| At-Rest 암호화 | 활성화 | 저장 데이터 암호화 |
| AUTH 토큰 | Secrets Manager 참조 | Mission 2에서 생성 |
| 스냅샷 보관 | 1일 | Dev 환경 |

---

## Terraform 파일 구조
```
mission4-cache/
├── main.tf           # 리소스 생성
├── variables.tf      # 변수 선언
├── outputs.tf        # 출력값
└── terraform.tfvars  # 실제 변수 값
```

---

## 미션 간 연결

| 미션 | 참조 내용 |
|---|---|
| Mission 1 | Private Subnet IDs, sg-redis ID |
| Mission 2 | Redis AUTH 토큰 (Secrets Manager) |

---

## 배운 점

- ElastiCache Replication Group (Primary + Replica) 개념
- Subnet Group으로 Private Subnet 내 Redis 배치
- Secrets Manager AUTH 토큰 동적 참조
- TLS + At-Rest 암호화로 보안 강화
- SSM Parameter에 Redis Endpoint 저장 (앱이 동적으로 참조)
- DB + Redis 조합으로 성능 최적화

---

## 실습 증빙

### ElastiCache Redis 확인

<img width="900" alt="elasticache" src="https://github.com/user-attachments/assets/4bc2991d-e13b-4f29-892d-fa7b91f0a9ba" />

---

### SSM Parameter (Redis Endpoint) 확인

<img width="900" alt="ssm-redis" src="https://github.com/user-attachments/assets/dfaeea0e-5419-423e-aad3-f7f62ee2d53f" />
