# Decisions

## Weather API

For this project, I chose the [Open-Meteo](https://open-meteo.com/) API. The main advantage that led me to choose it is that it doesn't require any configuration to use. Simply providing a location is enough to access a wide range of weather data. Furthermore, it is free for limited daily usage, which is sufficient for this small project. The JSON response is also straightforward to consume, although I wish some of the data were grouped more effectively.

## Security authentication

For authentication, I chose to manage a token generated using a JWT package. This approach allows me to access all services while storing only the authentication token locally. Another advantage is that I can determine whether the user is still authenticated without calling the API by validating the token and checking its expiration time locally.

## Tradeoff

I decided to implement state management for authentication, geolocation, and weather forecasting using Cubits. With more time, and knowing that the project is likely to grow, I'd probably use a code generation package such as [Freezed](https://pub.dev/packages/freezed).

## Production environment

In a production environment, the first change would be to move all token generation logic to the backend so that the secret key can be kept in a secure location. Furthermore, I'd implement two tokens instead of just one to improve session management: a short-lived access token for accessing services and a long-lived refresh token for obtaining new access tokens. Finally, I'd remove the mocked users, which would likely require implementing a user registration system.