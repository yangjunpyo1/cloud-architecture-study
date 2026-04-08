# Mission 1 - 기반 인프라 (VPC + SG + IAM)

AWS 애플리케이션 배포를 위한 기반 네트워크 인프라를 Terraform으로 구축합니다.

---

## 구성 리소스

| 리소스 | 이름 | 설명 |
|---|---|---|
| VPC | yjp-deepdive-vpc | 10.0.0.0/16 |
| Public Subnet | yjp-deepdive-public-1,2 | 10.0.1.0/24, 10.0.2.0/24 |
| Private Subnet | yjp-deepdive-private-1,2 | 10.0.11.0/24, 10.0.12.0/24 |
| Internet Gateway | yjp-deepdive-igw | VPC ↔ 인터넷 연결 |
| NAT Gateway | yjp-deepdive-nat | Private → 인터넷 아웃바운드 |
| Security Group | yjp-deepdive-sg-web | 0.0.0.0/0 포트 80, 443 |
| Security Group | yjp-deepdive-sg-app | sg-web에서 포트 8080 |
| Security Group | yjp-deepdive-sg-redis | sg-app에서 포트 6379 |
| Security Group | yjp-deepdive-sg-vpce | sg-app에서 포트 443 |
| IAM Role | yjp-deepdive-app-role | EC2용 IAM Role |

---

## Terraform 파일 구조
```
mission1-foundation/
├── main.tf           # 리소스 생성
├── variables.tf      # 변수 선언
├── outputs.tf        # 출력값
└── terraform.tfvars  # 실제 변수 값
```

---

## 배운 점

- VPC Public/Private Subnet 분리를 통한 보안 설계
- SG Chaining으로 계층적 접근 제어 (web → app → redis)
- IAM Role/Policy/Instance Profile 조합으로 EC2 권한 부여
- S3 Remote State Backend로 미션 간 state 공유

---

## 실습 증빙

### VPC 생성

<img width="900" alt="vpc" src="https://github.com/user-attachments/assets/e0c1e847-10ea-41e3-bfca-5ea45684592c" />

---

### Subnet 4개 확인

<img width="900" alt="subnet" src="https://github.com/user-attachments/assets/e76af3bf-14f4-4db9-b7cf-9233db20f2b8" />

---

### Security Group 4개 확인

<img width="900" alt="sg" src="https://github.com/user-attachments/assets/f9daa60b-5266-43fe-8cd3-1bec7ab43729" />

---

### IAM Role 확인

<img width="900" alt="iam" src="https://github.com/user-attachments/assets/f165340c-9e1f-49dc-8780-f65d630a80fe" />
