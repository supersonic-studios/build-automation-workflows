# build-automation-workflows

# 🚀 Unity Build Automation for RC Branches and Custom branches

This repository provides a **reusable GitHub Action workflow** for automating build processes for release candidate (RC) branches in Unity Cloud Build. The workflow is designed to create build targets and groups for iOS and Android platforms, and associated build groups for Unity Cloud Build environments (development and production).

The reusable workflow can be invoked from other repositories via the `uses` declaration in their own workflows.

---

## 📄 Features

- Automatically detects branch names or accepts custom branch names via manual dispatch inputs.
- Supports both Android and iOS Unity Cloud Build targets.
- Modular architecture for creating build targets for **development** and **production** environments.
- Handles error cases for missing credentials gracefully.
- Sanitizes branch names to ensure compatibility with Unity Cloud Build's naming requirements.
- Supports manual triggering to provide flexibility during development or QA testing cycles.

---

## 🚀 How to Use in Your Repository

You can use this reusable workflow in your repository by referencing it in your GitHub Actions configuration:

### Triggering Workflows Automatically
- **On branch creation**: Set this workflow to automatically trigger for `rc/*` branches.
- **Manually dispatchable**: Use GitHub Actions `workflow_dispatch` to run the workflow for a specific branch.

### Integration
- Configure your `.github/workflows` YAML file to invoke the reusable workflow by referencing:
```uses: supersonic-studios/build-automation-workflows/.github/workflows/RcBuildAutomation.yml@v<version-number>```

---

## 💼 Requirements

To use this workflow, you need:
- **Unity Cloud Build API token** for authentication.
- **Valid credentials** for Android and iOS signing (e.g., resource credential IDs).
- Pre-configured Unity project settings, including bundle IDs, project IDs, organization IDs, and SDK versions.

---

## 🛠️ Troubleshooting

- **Workflow Inputs**: Double-check the branch name or manually provide the correct branch with `workflow_dispatch`.
- **Unity API Permissions**: Ensure your Unity Cloud Build API token is valid and authorized to perform required actions.
- **Error Debugging**: Review logs that outline detailed curl responses and errors during execution.

---

This reusable workflow simplifies automating Unity Cloud Build processes for RC branches, making Unity project management and delivery streamlined and efficient. 🚀
