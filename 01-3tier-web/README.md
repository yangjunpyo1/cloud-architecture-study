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

### VPC 생성
![vpc](screenshots/vpc.png)

### ALB 타겟 그룹 Healthy 확인
![alb](screenshots/alb-healthy.png)

### RDS Multi-AZ 생성
![rds](screenshots/rds.png)

### S3 정적 웹사이트 호스팅
![s3](screenshots/s3.png)

### ALB 로드밸런싱 확인 (WEB1/WEB2)
![lb-test](screenshots/lb-test.png)
