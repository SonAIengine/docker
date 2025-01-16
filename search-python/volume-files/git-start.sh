#!/bin/sh
# 패키지 목록 업데이트
apt-get update
apt-get upgrade -y

# Git, GCC, G++ 설치
apt-get install -y git gcc g++ default-jdk

# 자바 설치 확인
java -version

# Git 설치 확인
git --version

# 인자로 전달된 값 할당
USERNAME=$1
PASSWORD=$2
BRANCH=$3

# USERNAME과 PASSWORD 출력 확인
echo "Username: $USERNAME"
echo "Password: $PASSWORD"

cd /home

# 디렉토리가 이미 존재하는지 확인
if [ -d "search-semantic-api" ]; then
  # 디렉토리가 존재하면 해당 디렉토리로 이동한 후 git pull 실행
  cd search-semantic-api
  git pull
else
  # 디렉토리가 없으면 git clone 실행
  git clone -b $BRANCH  https://$USERNAME:$PASSWORD@gitlab.x2bee.com/tech-team/ai-team/search/search-semantic-api.git
  cd search-semantic-api
fi