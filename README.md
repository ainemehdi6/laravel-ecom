# Laravel E Commerce App

Features Provided
- Products
- Cart
- Checkout
- Categories
- Customers
- Orders
- Employees

# Simplified DOCKER setup
### In your teminal, issue these commands

- RUN `docker-compose up -d --build`
- RUN `docker exec -it app bash`
- Inside the container, run `composer install && chmod -R 777 storage/ bootstrap/cache/`
- Inside the container, run `php artisan migrate --seed`
- While inside the container, compile the assets with `npm i && npm run dev`
- While inside the container, link the images `php artisan storage:link`
- OPEN [http://localhost:8000](http://localhost:8000)
