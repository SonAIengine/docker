#!/bin/sh

if ! command -v nvcc &> /dev/null; then
  echo "CUDA가 설치되어 있지 않습니다. 설치를 진행합니다."

  apt update && apt install -y wget gnupg software-properties-common

  CUDA_REPO_DEB="https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-debian12.pin"
  wget $CUDA_REPO_DEB
  mv cuda-debian12.pin /etc/apt/preferences.d/cuda-repository-pin-600
  apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub
  echo "deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /" > /etc/apt/sources.list.d/cuda.list
  apt update && apt install -y cuda

  export PATH=/usr/local/cuda/bin:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

  echo "CUDA 설치가 완료되었습니다."
else
  echo "CUDA가 이미 설치되어 있습니다."
fi

echo "현재 디렉토리 위치:"
pwd
PROJECT_DIR="/home/search-semantic-api"

if [ -d "$PROJECT_DIR" ]; then
  echo "프로젝트 디렉토리로 이동합니다: $PROJECT_DIR"
  cd "$PROJECT_DIR"
else
  echo "프로젝트 디렉토리를 찾을 수 없습니다: $PROJECT_DIR"
  exit 1
fi

echo "현재 디렉토리 위치:"
pwd

if [ -d "venv" ]; then
  echo "가상환경이 이미 존재합니다. 활성화합니다."
else
  echo "가상환경이 없습니다. 새로 생성합니다."
  python3 -m venv venv
fi

echo "가상환경을 활성화합니다."
. venv/bin/activate

if [ -f "requirements.txt" ]; then
  echo "requirements.txt 파일을 찾았습니다. 필요한 패키지를 설치합니다."
  pip install -r requirements.txt
fi