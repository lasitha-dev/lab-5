# Microservices Lab 5 - Complete System

## Overview
This project implements a complete microservices system with 4 services:
- **Item Service** (Port 8081) - Manages items
- **Order Service** (Port 8082) - Manages orders
- **Payment Service** (Port 8083) - Processes payments
- **API Gateway** (Port 8080) - NGINX reverse proxy

## Project Structure
```
lab-5/
├── item-service/         # Spring Boot, Port 8081
│   ├── src/main/java/.../ItemController.java
│   ├── src/main/resources/application.properties
│   ├── pom.xml
│   └── Dockerfile
├── order-service/        # Spring Boot, Port 8082
│   ├── src/main/java/.../OrderController.java
│   ├── src/main/resources/application.properties
│   ├── pom.xml
│   └── Dockerfile
├── payment-service/      # Spring Boot, Port 8083
│   ├── src/main/java/.../PaymentController.java
│   ├── src/main/resources/application.properties
│   ├── pom.xml
│   └── Dockerfile
├── api-gateway/          # NGINX, Port 8080
│   ├── nginx.conf
│   └── Dockerfile
├── docker-compose.yml
└── README.md
```

## Prerequisites
- Docker and Docker Compose (for containerized deployment)
- Java 17 (for local deployment)
- Maven (for building)

**Note:** If Docker has network connectivity issues, use the local deployment option below.

## Build Instructions

### 1. Build JAR files
```bash
# Build each service (already done)
cd item-service && mvn clean package -DskipTests
cd ../order-service && mvn clean package -DskipTests
cd ../payment-service && mvn clean package -DskipTests
```

### Option A: Run Without Docker (If Docker has network issues)

Simply double-click `run-local.bat` or run in PowerShell:
```powershell
.\run-local.ps1
```

This will start all three services in separate windows:
- Item Service: http://localhost:8081
- Order Service: http://localhost:8082
- Payment Service: http://localhost:8083

**Note:** When running locally without Docker, test the services directly on their ports (8081, 8082, 8083) instead of through the API Gateway.

### Option B: Build and Run Docker Containers
```bash
# From the root directory
docker-compose build
docker-compose up

# Or run in detached mode
docker-compose up -d
```

**If Docker fails with "no such host" errors:**
1. Restart Docker Desktop
2. Check your internet connection
3. Temporarily disable firewall/antivirus
4. Use Option A (local deployment) instead

## API Endpoints

All endpoints are accessible through the API Gateway at `http://localhost:8080`

### Item Service
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/items` | List all items |
| POST | `/items` | Create a new item |
| GET | `/items/{id}` | Get item by ID |

### Order Service
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/orders` | List all orders |
| POST | `/orders` | Create a new order |
| GET | `/orders/{id}` | Get order by ID |

### Payment Service
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/payments` | List all payments |
| POST | `/payments/process` | Process a payment |
| GET | `/payments/{id}` | Get payment by ID |

## Sample Request Bodies

### POST /items
```json
{
  "name": "Headphones"
}
```

### POST /orders
```json
{
  "item": "Laptop",
  "quantity": 2,
  "customerId": "C001"
}
```

### POST /payments/process
```json
{
  "orderId": 1,
  "amount": 1299.99,
  "method": "CARD"
}
```

## Testing with Postman

1. Import the `microservices-lab.postman_collection.json` file
2. Start the Docker containers with `docker-compose up`
3. Run the requests in the collection

## Direct Service Access (for testing)
- Item Service: http://localhost:8081
- Order Service: http://localhost:8082
- Payment Service: http://localhost:8083

## Architecture
```
Client (Postman/Browser)
         |
         v
+------------------------+
|   API Gateway :8080    |
|  (NGINX)               |
+--------|-------|-------+
         |       |       |
         v       v       v
    :8081   :8082   :8083
   Item    Order   Payment
```

## Troubleshooting

### Docker Build Issues
If you encounter network timeouts during Docker build, try:
```bash
docker-compose build --no-cache
```

### Port Conflicts
If ports are already in use, modify the port mappings in `docker-compose.yml`:
```yaml
ports:
  - "9091:8081"  # Change host port
```

## Stopping the Services
```bash
docker-compose down
```
