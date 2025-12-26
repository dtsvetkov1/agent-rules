# API Best Practices for Expo

## Authentication
- Use `expo-secure-store` to store JWT tokens.
- Implement an interceptor pattern or a wrapper function around `expo/fetch` to inject the `Authorization` header.

## Pagination
- Use `useInfiniteQuery` for lists.
- Optimize `FlatList` with `removeClippedSubviews` and `maxToRenderPerBatch`.

## Offline Support
- Consider `react-query`'s offline capabilities.
- Use `NetInfo` to check connectivity before making requests.

## Security
- Never store API keys in the source code; use environment variables via `app.config.js`.
- Ensure all endpoints use HTTPS.
