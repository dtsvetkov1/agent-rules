# Mobile Security Checklist

## 1. Authentication
- [ ] Are tokens stored in `SecureStore`?
- [ ] Is biometrics used for sensitive actions?
- [ ] Does the app handle session expiration correctly?

## 2. Networking
- [ ] Are all connections HTTPS?
- [ ] Is certificate pinning implemented for critical endpoints?
- [ ] Are user-agent headers identifying the app properly?

## 3. Storage
- [ ] Is `AsyncStorage` used only for non-sensitive data?
- [ ] Are logs cleared of sensitive info (PII, tokens) in production?

## 4. Code & Build
- [ ] Is the app using ProGuard/R8 on Android?
- [ ] Are third-party SDKs audited for privacy and security?
- [ ] Are environment variables used for build-time secrets?
