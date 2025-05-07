## Triển khai ứng dụng với Docker và Kubernetes

### Các bước thực hiện

#### 1. Container hóa

- Clone repository **hackathon-starter**.
    - `git clone https://github.com/sahat/hackathon-starter myproject`
- Viết các file Dockerfile cho dịch vụ frontend và backend.
    - Đã viết dockerfile cho backend: đặt tên là `dockerfile-backend`
        - `docker build -t dockerfile-backend -f dockerfile-backend .` (trước tiên build image)
        - `docker run dockerfile-backend` (chạy image)
        - `docker images` (Kiểm tra)
        - `docker ps -a` (Kiểm tra chạy ẩn...)
    - Viết dockerfile cho frontend:
        - TH1: Dự án đã tích hợp frontend vào backend...
        - TH2: Em tạo các thư mục và file giống như 1 dự án có frontend riêng...
- Viết script build (`build.sh`) thực hiện:
    - Build các image Docker cho cả hai dịch vụ.
        - Build thành công `dockerfile-backend` và `frontend`
    - Đẩy các image lên registry container có thể cấu hình.
        - `docker push scofieldtt/dockerfile-backend:latest`
        - `docker push scofieldtt/dockerfile-frontend:latest`

#### 2. Điều phối

- Tạo các file manifest Kubernetes (YAML) để triển khai dịch vụ frontend và backend:
    - Bao gồm các tài nguyên **Deployment**, **Service**, và **Nginx Ingress** (Bonus).
    - Tạo các thư mục `manifests` và các file `service` và `deployment`
        ```
        myproject/
        ├── manifests/
        │   ├── frontend-deployment.yaml
        │   ├── frontend-service.yaml
        │   ├── backend-deployment.yaml
        │   ├── backend-service.yaml
        │   └── ingress.yaml
        └── deploy.sh
        ```
    - Cài đặt Kubernetes: Sử dụng Minikube cho môi trường phát triển.
    - Cài đặt kubectl
    - Cài đặt Nginx Ingress Controller.
        ```bash
        minikube status
        kubectl version
        ```
    - **Cú pháp cơ bản kubectl**:
        | Lệnh kubectl | Mô tả |
        |---|---|
        | `kubectl get pods` | Lấy thông tin về pods |
        | `kubectl describe pod <pod_name>` | Mô tả chi tiết về pod |
        | ... | ... |
    - **Cú pháp cơ bản minikube**:
        | Lệnh minikube | Mô tả |
        |---|---|
        | `minikube start` | Khởi động một cluster Minikube |
        | `minikube stop` | Dừng cluster Minikube |
        | ... | ... |
- Viết script triển khai `deploy.sh`
    ```bash
    kubectl apply -f frontend-deployment.yaml
    kubectl apply -f frontend-service.yaml
    kubectl apply -f backend-deployment.yaml
    kubectl apply -f backend-service.yaml
    kubectl apply -f ingress.yaml
    echo "Triển khai thành công!"
    ```
- Tất cả script và cấu hình đã đề cập ở trên.
    - Đẩy code lên git:
        - Tạo new repo, `cd Download/myproject`, do có sẵn git khi git clone nên cần phải xóa git hiện tại.
            - `git remote -v` (kiểm tra)
            - `git remote remove origin` (xóa)
            - `git init` (khởi tạo)
            - `git remote add origin https://github.com/bansclose/myproject.git`
            - `git add .`
            - `git commit -m "Initial commit"`
            - `git branch -M main`
            - `git push -u origin main`
- Tôi vừa mới update
