---

name: "AI Task Request"
description: "Request a coding or documentation task to be performed by an AI agent."
title: "[AI Task] <short description>"
labels: [ai, automation, help wanted]
assignees: []
body:

- type: markdown
  attributes:
  value: | ## AI Task Request
  Please fill out the details below to request an AI/agent-driven coding or documentation task.

- type: input
  id: prompt
  attributes:
  label: Prompt
  description: Describe the task you want the AI agent to perform (e.g., add a feature, fix a bug, refactor code, write tests, update docs).
  placeholder: "Add a new onboarding screen with a progress indicator."
  validations:
  required: true

- type: textarea
  id: context
  attributes:
  label: Context/Background
  description: Provide any relevant context, links to files, or related issues/PRs.
  placeholder: "This screen should match the design in Figma and connect to the existing navigation flow."
  validations:
  required: false

- type: textarea
  id: expected_output
  attributes:
  label: Expected Output
  description: What should the result look like? (e.g., new file, updated screen, passing tests)
  placeholder: "A new file in lib/screens/, updated navigation, and a passing widget test."
  validations:
  required: false

- type: checkboxes
  id: requirements
  attributes:
  label: Requirements
  options: - label: "Follows project style and guidelines (see .cursorrules, AGENTS.md)" - label: "Includes/updates relevant documentation" - label: "Includes/updates relevant tests" - label: "No new dependencies without approval"
