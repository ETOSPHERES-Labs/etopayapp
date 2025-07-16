# Contributing Guide

Thank you for considering contributing to this Flutter project!

## Getting Started

- Fork the repository and clone it locally.
- Run `flutter pub get` to install dependencies.
- See `.cursorrules` and `AGENTS.md` for style, structure, and workflow guidelines.

## How to Contribute

- Open an issue or discussion for major changes before submitting a PR.
- Use feature branches for your work.
- Ensure all code passes `flutter analyze` and `flutter test`.
- Follow the PR template and checklist.

## AI/Agent Contributors

- Clearly state the user prompt or context that led to your PR or issue.
- Reference relevant files, guidelines, or previous PRs/issues.
- If unsure about a decision, leave a comment for human reviewers to verify.
- Do not add new dependencies or modify CI without clear justification and approval.
- Escalate ambiguous or potentially breaking changes for human review.
- Use the `ai_task` issue template for new requests.

## Code Review & Escalation

- All code changes (especially from agents) require human review and approval.
- Use CODEOWNERS to ensure the right reviewers are assigned.
- For security, performance, or architectural changes, request a senior maintainer review.

## Best Practices

- Write clear, descriptive commit messages.
- Keep PRs focused and small when possible.
- Update documentation and tests as needed.
- Use the provided prompts in `PROMPTS.md` for common tasks.

## Resources

- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Style Guide](https://docs.flutter.dev/development/tools/analysis)
- [AGENTS.md](./AGENTS.md)
- [PROMPTS.md](./PROMPTS.md)
- [ai_tools.yaml](./ai_tools.yaml)
