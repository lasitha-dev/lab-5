@echo off
echo Starting Microservices Lab 5 Services...
echo.

start "Item Service" cmd /k "cd item-service && java -jar target/item-service-1.0.0.jar"
echo Item Service starting on http://localhost:8081

timeout /t 2 >nul

start "Order Service" cmd /k "cd order-service && java -jar target/order-service-1.0.0.jar"
echo Order Service starting on http://localhost:8082

timeout /t 2 >nul

start "Payment Service" cmd /k "cd payment-service && java -jar target/payment-service-1.0.0.jar"
echo Payment Service starting on http://localhost:8083

echo.
echo All services are starting...
echo Wait 10 seconds for services to initialize, then test with Postman:
echo   - Item Service: http://localhost:8081/items
echo   - Order Service: http://localhost:8082/orders
echo   - Payment Service: http://localhost:8083/payments
echo.
pause
