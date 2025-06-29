## 🐳 Docker Compose Deployment (Local Development)

### ✅ Purpose

- Rapid local development
- Hot-reload with mounted volumes
- Easy DB + Web container coordination

### 🔧 Steps to Run

1. Clone the project:
    
    git clone https://github.com/your-org/budget-app-deploy.git
    
    cd budget-app-deploy
    
2. Create a `.env` file:
    
    POSTGRES_USER=budget_user
    
    POSTGRES_PASSWORD=budget_password
    
    POSTGRES_DB=budget_app
    
    RAILS_ENV=development
    
3. Run the app:
    
    docker compose up --build
    

### 🛠️ Configuration Highlights

- **DB_HOST** is set to `db`, matching the service name in Compose
- Database credentials loaded from `.env`
- `command:` waits for DB, runs migrations, then starts Puma
- `volumes:` enable live reload and local file access

---

## ☸️ Kubernetes Deployment (Production-like Environment)

### ✅ Purpose

- Simulates cloud infrastructure
- Scales and orchestrates using native K8s primitives
- Ingress-enabled access via domain (`budget.local`)

### 🧱 Required Tools

- Kubernetes (e.g., Docker Desktop K8s)
- NGINX Ingress Controller

### 🔧 Steps to Deploy

1. Apply namespace and resources:
    
    kubectl apply -f k8s/
    
2. Add `budget.local` to `/etc/hosts`:
    
    127.0.0.1 budget.local
    
3. Visit http://budget.local

### 🛠️ Configuration Highlights

- Database is deployed as a **StatefulSet** with persistent volume claim
- Secrets and ConfigMap store Rails credentials and `master.key`
- `command:` in Deployment waits for Postgres, runs DB setup, then starts Puma
- Ingress exposes the app via `budget.local` using NGINX

---

## 🔄 Differences Between Docker Compose and Kubernetes

| Feature | Docker Compose | Kubernetes |
| --- | --- | --- |
| Environment Separation | `.env` file | Secrets + ConfigMaps |
| DB Initialization | `depends_on` + `pg_isready` | `pg_isready` in container `command` |
| Volume Management | Named volumes | PVC + PV (PersistentVolume) |
| Network Discovery | Service name (`db`) | K8s Service name (`postgres`) |
| App Exposure | Port mapping (`localhost:3000`) | Ingress + `budget.local` hostname |
| Secrets Handling | Plain `.env` | K8s Secrets (Base64-safe) |

---
