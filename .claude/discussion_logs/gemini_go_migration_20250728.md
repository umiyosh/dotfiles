# Gemini Discussion: Shell Scripts to Go Migration
Date: 2025-07-28

## Discussion Summary

Conducted an in-depth architectural discussion with Gemini about migrating ~50 shell scripts from dotfiles to Go, covering:

1. **Project Structure**: Single binary with subcommands using Cobra
2. **Dependency Injection**: Interface-based design for testability
3. **Testing Strategy**: Golden file testing for compatibility
4. **Performance Optimization**: Single binary approach, lazy loading
5. **Best Practices**: Error handling, cross-platform support

## Key Architectural Decisions

### 1. Single Binary Architecture
- Create a single `dot` binary with subcommands
- Use symlinks for backward compatibility (e.g., `vimbench` → `dot`)
- Leverage Cobra for CLI framework

### 2. Project Structure
```
/dotfiles-go/
├── cmd/dot/main.go
├── internal/
│   ├── ai/         # AI tool wrappers
│   ├── command/    # Cobra commands
│   ├── exec/       # Process execution
│   ├── git/        # Git operations
│   └── notification/
├── testdata/       # Golden files
└── Makefile
```

### 3. Testing Approach
- **Unit Tests**: Mock external dependencies
- **Integration Tests**: Real git repos, temp directories
- **Golden File Tests**: Compare with original script output
- **Migration Tests**: Parallel execution comparison

### 4. Implementation Priority
1. Foundation (project structure, exec wrapper)
2. High-priority, low-dependency (notif, vimbench)
3. AI and Git tools (mkc, git-back)
4. Complex utilities

## Technical Recommendations

### Dependency Injection Pattern
```go
type Executor interface {
    Command(ctx context.Context, name string, arg ...string) *exec.Cmd
    Run(ctx context.Context, name string, arg ...string) ([]byte, error)
}

type App struct {
    Executor exec.Executor
    Notifier notification.Notifier
    AIClient ai.Client
}
```

### Cross-Platform Strategy
- Build tags for OS-specific code
- Interface abstraction for platform features
- Runtime detection for graceful degradation

### Error Handling Philosophy
- Improve upon shell script silent failures
- Provide clear, actionable error messages
- Use error wrapping for context

## Next Steps
1. Create initial project structure
2. Implement core libraries (exec, config)
3. Migrate first batch of simple tools
4. Establish testing patterns
5. Gradual rollout with symlink compatibility
