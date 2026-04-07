# 3-Tier 웹 애플리케이션 아키텍처

NHN Cloud의 3-Tier 웹 애플리케이션 아키텍처를 AWS로 변환한 실습입니다.

## 아키텍처 다이어그램
<img width="481" height="449" alt="image" src="https://github.com/user-attachments/assets/a5978b23-fd2f-4052-a7c3-cacc02520e83" />


## NHN Cloud → AWS 서비스 매핑

| NHN Cloud | AWS |
|---|---|
| Internet Gateway | Internet Gateway |
| Load Balancer (Public) | ALB (Internet-facing) |
| Load Balancer (Private) | ALB (Internal) |
| Instance (Web) | EC2 |
| Instance (App) | EC2 |
| RDS (Active/Standby) | RDS Multi-AZ |
| Object Storage | S3 |
| NAS | EFS |

## 네트워크 구성

| 구분 | CIDR |
|---|---|
| VPC | 192.168.0.0/16 |
| Public Subnet A | 192.168.10.0/24 |
| Public Subnet B | 192.168.110.0/24 |
| Private Subnet A | 192.168.20.0/24 |
| Private Subnet B | 192.168.120.0/24 |
| DB Subnet A | 192.168.30.0/24 |
| DB Subnet B | 192.168.130.0/24 |

## 구현 내용

- VPC 및 서브넷 6개 구성 (Public 2, Private 2, DB 2)
- Internet Gateway 연결 및 라우팅 테이블 설정
- Public ALB → WEB EC2 2개 (AZ 이중화)
- Internal ALB → APP EC2 2개 (AZ 이중화)
- RDS Multi-AZ (Active/Standby 자동 Failover)
- S3 정적 웹사이트 호스팅
- EFS 생성

## 배운 점

- 클라우드 3-Tier 구조의 각 계층별 역할 이해
- Public/Private 서브넷 분리를 통한 보안 설계
- ALB를 통한 로드밸런싱 및 고가용성 구성
- RDS Multi-AZ를 통한 DB 자동 Failover 이해

## 실습 증빙

---

### VPC 생성
<img width="900" alt="vpc" src="https://github.com/user-attachments/assets/544e736a-f0d9-409e-9592-20f67e71e74d" />

---

### 서브넷 6개 확인
<img width="900" alt="subnet" src="https://github.com/user-attachments/assets/ceb2a620-5e07-4b08-9a36-4b0003bc0d11" />

---

### EC2 4개 확인
<img width="900" alt="ec2" src="https://github.com/user-attachments/assets/82843e7e-1dad-4ea0-832f-e7362127fbea" />

---

### ALB 타겟 그룹 Healthy 확인
<img width="900" alt="alb" src="https://github.com/user-attachments/assets/300c2a1b-6fbc-450b-a827-26aefea9c30d" />

---

### RDS Multi-AZ 생성
<img width="900" alt="rds" src="https://github.com/user-attachments/assets/dfaff1b0-9be7-4af8-9c67-30be452ab09e" />

---

### S3 버킷 확인
<img width="900" alt="s3" src="https://github.com/user-attachments/assets/9be54b19-13fa-427b-beb9-7061d1f4ed91" />

---

### EFS 확인
<img width="900" alt="efs" src="https://github.com/user-attachments/assets/05d457b7-ea7f-4ed8-b247-25a56924c6bc" />

---

### ALB 로드밸런싱 확인 (WEB1/WEB2)
<img width="500" alt="web1" src="https://github.com/user-attachments/assets/906965d6-5858-4ae0-ac19-743c9f63fb25" />
<img width="500" alt="web2" src="https://github.com/user-attachments/assets/9358b80c-6ec0-46c4-9202-408b6e3940c4" />
