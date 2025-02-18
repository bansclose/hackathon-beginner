## Các bước thực hiện
### 1. Container hóa
---------------------------------------------------------------
- Clone repository **hackathon-starter**. 
    + git clone https://github.com/sahat/hackathon-starter myproject
- Viết các file Dockerfile cho dịch vụ frontend và backend.
    + Đã viết dockerfile cho backend: đặt tên là dockerfile-backend
      -> docker build -t dockerfile-backend -f dockerfile-backend . (trước tiên build image)
      -> docker run dockerfile-backend (chạy image)
      -> docker images (Kiểm tra)
      -> docker ps -a (Kiểm tra chạy ẩn và nếu muốn xóa thì phải xóa id trong này trước "docker rm id " rồi mới xóa được id images "docker rmi id")
      -> Trước đó cần cài mongo và khởi động mongod: sudo systemctl start mongod và dùng docker compose mongo chung với dockerfile-backend.
- Viết dockerfile cho frontend: 
    + TH1: Dự án đã tích hợp frontend vào backend, là Express.js sẽ render giao diện dựa trên các file EJS . Khi chạy container cho backend, nó đã bao gồm cả phần giao diện. Do đó, em nghĩ là chỉ cần viết dockerfile cho backend là được và không cần tạo thêm Dockerfile cho frontend.
    + TH2: Em tạo các thư mục và file giống như 1 dự án có frontend riêng, viết bằng react cơ bản. Thư mục myproject/frontend, và em đã viết dockerfile-frontend, docker build -t dockerfile-frontend -f dockerfile-frontend thành công.
      
- Viết script build (`build.sh`) thực hiện: 
  - Build các image Docker cho cả hai dịch vụ. 
    + Build thành công dockerfile-backend và frontend
  - Đẩy các image lên registry container có thể cấu hình. 
    + docker push scofieldtt/dockerfile-backend:latest
    + docker push scofieldtt/dockerfile-frontend:latest
    
### 2. Điều phối
- Tạo các file manifest Kubernetes (YAML) để triển khai dịch vụ frontend và backend: 
  - Bao gồm các tài nguyên **Deployment**, **Service**, và **Nginx Ingress** (Bonus). 
------------------------------------------------------------------------------------- 
    + Tạo các thư mục manifests và các file service và deployment 
  myproject/
├── manifests/
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   └── ingress.yaml
└── deploy.sh
    + Cài đặt Kubernetes: Sử dụng Minikube cho môi trường phát triển.
    + Cài đặt kubectl
    + Cài đặt Nginx Ingress Controller.
--
trungnt@trungnt-devops:~/Downloads/myproject$ minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

trungnt@trungnt-devops:~/Downloads/myproject$ kubectl version 
Client Version: v1.32.0
Kustomize Version: v5.5.0
Server Version: v1.31.0
trungnt@trungnt-devops:~/Downloads/myproject$ 

--
  **** Cú pháp cơ bản kubectl
        kubectl get: Lấy thông tin về các tài nguyên Kubernetes (ví dụ: kubectl get pods, kubectl get deployments, kubectl get services).
        kubectl describe: Mô tả chi tiết về một tài nguyên Kubernetes (ví dụ: kubectl describe pod <pod_name>).
        kubectl create: Tạo một tài nguyên Kubernetes từ file manifest (ví dụ: kubectl create -f <file.yaml>).
        kubectl apply: Áp dụng một file manifest để tạo hoặc cập nhật tài nguyên Kubernetes (ví dụ: kubectl apply -f <file.yaml>).
        kubectl delete: Xóa một tài nguyên Kubernetes (ví dụ: kubectl delete pod <pod_name>).
        kubectl exec: Chạy một lệnh bên trong một container (ví dụ: kubectl exec -it <pod_name> -- bash).
        kubectl logs: Xem log của một container (ví dụ: kubectl logs <pod_name>).
  **** Cú pháp cơ bản minikube:
        minikube start: Khởi động một cluster Minikube. Bạn có thể chỉ định các tùy chọn như --driver (ví dụ: docker, virtualbox), --memory, --cpus để cấu hình tài nguyên cho cluster.
        minikube stop: Dừng cluster Minikube.
        minikube status: Kiểm tra trạng thái của cluster Minikube.
        minikube delete: Xóa cluster Minikube.
        minikube config: Quản lý cấu hình của Minikube. Ví dụ: minikube config set driver docker để thay đổi driver.
        minikube addons: Quản lý các addon của Minikube (ví dụ: minikube addons enable ingress để bật Ingress controller).
        minikube ip: Lấy địa chỉ IP của Minikube.
        minikube service: Mở một service trong trình duyệt web.
- Viết script triển khai `deploy.sh`
     kubectl apply -f frontend-deployment.yaml
     kubectl apply -f frontend-service.yaml
     kubectl apply -f backend-deployment.yaml
     kubectl apply -f backend-service.yaml
     kubectl apply -f ingress.yaml
echo "Triển khai thành công!"
  
  ## Nộp bài
Nộp bài dưới dạng một repository Git chứa:  
1. Tất cả script và cấu hình đã đề cập ở trên.
    - Đẩy code lên git: + Tạo new repo, cd Download/myproject, do có sẵn git khi git clone nên cần phải xóa git hiện tại.
                        + git remote -v (kiểm tra), git remote remove origin (xóa), git init (khởi tạo)
                        + git remote add origin https://github.com/your-username/myproject.git
                        + git add .
                        + git commit -m "Initial commit"
                        + git branch -M main
                        + git push -u origin main

  
