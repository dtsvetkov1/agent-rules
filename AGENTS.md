# React Native Expo Project Guidelines

This AGENTS.md file provides comprehensive guidance for AI coding agents working on React Native Expo projects. Follow these principles and best practices for consistent, high-quality development.

## Project Overview

This is a React Native Expo project using modern development practices and the latest Expo SDK features. The project emphasizes TypeScript, performance optimization, and maintainable code architecture.

## Setup Commands

### Package Management

- **Always use Bun as the default package manager**
- Install dependencies: `bun install`
- Add new packages: `bun add <package>`
- Remove packages: `bun remove <package>`
- Run scripts: `bun run <script>`
- One-time commands: `bunx <command>`

### Development Server

- Start development server: `bun run start`
- Start with specific configuration: `bun run ios` or `bun run android`

### Common Development Commands

```bash
bun install                    # Install all dependencies
bun add react-native-reanimated # Add animation library
bun remove axios              # Remove unused HTTP library
bun run start                 # Start development server
bunx expo install             # Install Expo packages
```

## Project Structure

```
app/                          # Expo Router app directory
├── _layout.tsx              # Main app layout and navigation
├── index.tsx                # Home screen
└── api/                     # API routes (+api.ts files)

components/                  # Reusable components
├── ui/                      # UI components
└── [ComponentName].tsx      # Feature components

constants/                   # App constants and configuration
hooks/                       # Custom React hooks
stores/                      # Zustand state management
services/                    # API services and external integrations
```

## Core Technology Stack

### Required Technologies

- **React Native with Expo**: Use latest Expo SDK features and APIs
- **TypeScript**: All files must use TypeScript with proper typing
- **Expo Router**: File-based routing system for navigation
- **Bun**: Package manager for all dependency management

### State Management

- **Zustand**: Always use Zustand for state management
- Create stores in `stores/` directory
- Use TypeScript interfaces for all store state and actions
- Keep stores focused and single-purpose

### Animation Library

- **React Native Reanimated**: Always use instead of built-in Animated API
- Use latest Reanimated features (worklets, shared values, etc.)
- Prefer layout animations over manual animation setup

### HTTP Client

- **expo/fetch**: Always use for HTTP requests
- Never use built-in fetch, axios, or other HTTP libraries
- Move fetch calls to separate files using React Query hooks

## Code Style Guidelines

### File Naming Conventions

- Components: `PascalCase.tsx` (e.g., `MyComponent.tsx`)
- Utilities/hooks: `camelCase.ts` or `camelCase.tsx`
- Route files: `lowercase-with-hyphens.tsx` (when needed)
- API routes: `+api.ts` suffix

### Component Patterns

- Use functional components with hooks
- Leverage existing themed components for consistent UI
- Support both dark mode and light mode
- Use proper TypeScript interfaces for all component props
- **Component Structure**: Components must be organized in feature folders with `index.tsx`, `styles.ts` (if needed), and `types.ts` files
- **Component Declaration**: Use arrow function pattern with `FC<PropsWithChildren<T>>` typing

### Screen Implementation

- **Keyboard Handling**: Use keyboard avoiding scroll views for screens with input fields

### Styling

- Use tailwind-type styles for styling (uniwind CSS for React Native)
- Follow existing theming system in `constants/Colors.ts`
- Use color scheme hooks from `hooks/useColorScheme.ts`

## Development Guidelines

### Animation Best Practices

- **Always use React Native Reanimated** instead of built-in Animated API
- Use latest Reanimated options and APIs (worklets, shared values, etc.)
- Prefer layout animations, then use `useSharedValue`, `useAnimatedStyle`, `withTiming`, `withSpring`
- **CSS Transitions and Animations (Reanimated 4+)**: Use new CSS-like animation syntax for declarative animations

### State Management Patterns

- **Simple state**: Use Zustand stores within React components
- **Complex state logic**: Use class-based stores outside React tree for business logic requiring store manipulation independent of React lifecycle

### API Development

- Create Expo API routes as `+api.ts` files in `app/api/` directory
- Follow Expo Router API route conventions
- Example: `app/api/users/user-info+api.ts` for `/api/users/user-info` endpoint

### Data Fetching

- Always use `expo/fetch` for HTTP requests
- Move fetch calls to separate files using React Query hooks in `services/api`
- Handle loading and error states in all components

### Performance Optimization

- Optimize FlatLists with `removeClippedSubviews`, `maxToRenderPerBatch`, and `windowSize`
- Avoid anonymous functions in `renderItem` or event handlers
- Implement code splitting and lazy loading for non-critical components

### Error Handling and Validation

- Handle errors at the beginning of functions with early returns
- Use if-return pattern instead of deeply nested if statements
- Implement global error boundaries for unexpected errors
- Use Zod for runtime validation and error handling
- Prioritize edge case handling and user-friendly error messages

### Security Best Practices

- Sanitize user inputs to prevent XSS attacks
- Use secure storage for sensitive data (expo-secure-store)
- Ensure secure API communication with HTTPS and proper authentication
- Follow Expo's Security guidelines: https://docs.expo.dev/guides/security/

### Testing Guidelines

- Write unit tests using Vitest and React Native Testing Library if required
- Implement integration tests for critical user flows using Maestro
- Consider snapshot testing for UI consistency

### Safe Area Management

- Use SafeAreaProvider from react-native-safe-area-context globally
- Wrap components with SafeAreaView for proper screen insets
- Use SafeAreaScrollView for scrollable content
- Avoid hardcoding safe area padding/margins

## Best Practices

### Performance

- Follow React Native performance best practices
- Optimize animations and heavy computations
- Use proper memoization techniques
- Test on both iOS and Android when possible

### Security

- Keep secrets secure and avoid hardcoding sensitive data
- Use proper authentication patterns
- Validate all user inputs
- Follow security best practices for API communications

### Development Workflow

- Use Expo development tools and debugging features
- Handle loading and error states in all components
- Use proper TypeScript types and interfaces
- Avoid prop drilling by using Zustand stores for shared state

### Component Development

- Keep components focused and single-purpose
- Use proper error boundaries
- Implement proper accessibility features
- Support both portrait and landscape orientations

## Common Patterns

### Component Implementation

```tsx
// components/button/index.tsx
import React, { FC, PropsWithChildren } from "react";
import { TouchableOpacity } from "react-native";
import { MyButtonProps } from "./types";
import { styles } from "./styles";

const MyButton: FC<PropsWithChildren<MyButtonProps>> = ({
  onPress,
  children,
  variant = "primary",
  disabled = false,
}) => {
  return (
    <TouchableOpacity
      style={[styles.container, styles[variant], disabled && styles.disabled]}
      onPress={onPress}
      disabled={disabled}
    >
      {children}
    </TouchableOpacity>
  );
};

export default MyButton;
```

### API Implementation

```tsx
// services/apis/index.ts
import { axiosClient } from "./axios-client";

export const apis = {
  authenticateWithFirebaseToken: ({ idToken }: ApiTypes.Authenticate) =>
    axiosClient.post<ApiTypes.AuthResponse>("auth/authenticate", { idToken }),
};

// Usage in component:
const { data } = await apis.authenticateWithFirebaseToken({ idToken });
```

### Screen Implementation

```tsx
// app/search/index.tsx
import React, { FC, PropsWithChildren } from "react";
import { View, KeyboardAvoidingView, Platform } from "react-native";
import { Formik } from "formik";
import * as Yup from "yup";
import { styles } from "./styles";

const Search: FC<PropsWithChildren> = () => {
  return (
    <KeyboardAvoidingView
      style={styles.container}
      behavior={Platform.OS === "ios" ? "padding" : "height"}
    >
      <Formik
        initialValues={{ query: "" }}
        validationSchema={Yup.object({
          query: Yup.string().required("Required"),
        })}
        onSubmit={(values) => {
          // Handle search
        }}
      >
        {/* Form fields */}
      </Formik>
    </KeyboardAvoidingView>
  );
};

export default Search;
```

### Store Implementation

```tsx
// stores/useAuthStore.ts
import { create } from "zustand";

interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  login: (credentials: LoginCredentials) => Promise<void>;
  logout: () => void;
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  isAuthenticated: false,
  login: async (credentials) => {
    // Login logic
    set({ user: userData, isAuthenticated: true });
  },
  logout: () => {
    set({ user: null, isAuthenticated: false });
  },
}));
```

### Animation Implementation

```tsx
// Using Reanimated for animations
import {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
} from "react-native-reanimated";
import Animated from "react-native-reanimated";

const opacity = useSharedValue(0);
const animatedStyle = useAnimatedStyle(() => ({
  opacity: opacity.value,
}));
```

## Deployment

### Build Commands

- Build for production: `bun run build`
- Build for specific platforms: `bun run build:ios` or `bun run build:android`
- Submit to stores: `bunx expo submit`

### Environment Setup

- Configure environment variables in `.env` files
- Use different environments for development, staging, and production
- Never commit sensitive data to version control

## Troubleshooting

### Common Issues

- **Metro bundler issues**: Clear cache with `bunx expo start --clear`
- **Package resolution**: Use `bun install` to refresh dependencies
- **TypeScript errors**: Run `bun run type-check` to identify issues
- **Animation problems**: Ensure React Native Reanimated is properly configured

### Getting Help

- Check Expo documentation for latest features
- Review React Native Reanimated documentation for animation APIs
- Consult Zustand documentation for state management patterns
- Use Expo development tools for debugging
