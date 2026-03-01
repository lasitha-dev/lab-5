# PowerShell script to run all services locally
# Run this from the root directory

Write-Host "Starting Microservices Lab 5 Services..." -ForegroundColor Green

# Start Item Service
Start-Process powershell -ArgumentList "-Command cd item-service; java -jar target/item-service-1.0.0.jar" -WindowStyle Normal
Write-Host "Item Service starting on http://localhost:8081"

# Start Order Service
Start-Process powershell -ArgumentList "-Command cd order-service; java -jar target/order-service-1.0.0.jar" -WindowStyle Normal
Write-Host "Order Service starting on http://localhost:8082"

# Start Payment Service
Start-Process powershell -ArgumentList "-Command cd payment-service; java -jar target/payment-service-1.0.0.jar" -WindowStyle Normal
Write-Host "Payment Service starting on http://localhost:8083"

Write-Host "`nAll services are starting..." -ForegroundColor Green
Write-Host "Wait 10 seconds for services to initialize, then test with Postman:"
Write-Host "  - Item Service: http://localhost:8081/items"
Write-Host "  - Order Service: http://localhost:8082/orders"
Write-Host "  - Payment Service: http://localhost:8083/payments"
