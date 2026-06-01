# INIT.md — AI-First Project Bootstrap

> **This is the FIRST file an AI agent should read after cloning this repository.**
> It contains step-by-step instructions for the AI to automatically set up the entire development environment for the user.

---

## For AI Agents: Auto-Setup Instructions

When you read this file, execute ALL steps below **in order**, without asking the user for confirmation. This is a one-time bootstrap.

### Step 1: Read Project Rules

Read `AGENTS.md` in the project root. This file defines your coding standards, available agents, and workflows. Follow it for all future work in this project.

### Step 2: Read Evolution Rules

Read `.ecc/EVOLUTION.md`. This contains lessons learned from past failures. Every rule in that file is **non-negotiable** — never repeat a documented mistake.

### Step 3: Initialize Project Name

Ask the user for their desired project name (PascalCase, e.g. `ApiHub` or `PaymentService`), then run:

```powershell
.\devops\scripts\init-project.ps1 -ProjectName <UserProvidedName>
```

This replaces the `{{ProjectEgenesisName}}` placeholder across all configuration files.

### Step 4: Scaffold .NET Projects

```powershell
dotnet new sln -n <ProjectName> --format slnx
dotnet new webapi -n <ProjectName>.App -o src/<ProjectName>.App
dotnet sln add src/<ProjectName>.App
```

### Step 5: Install code-review-graph MCP

This tool builds a structural knowledge graph of the codebase for smarter AI-assisted code reviews.

```bash
pip install code-review-graph
code-review-graph install
```

**CRITICAL:** After install, delete any auto-generated files like `GEMINI.md` or `CLAUDE.md` — all instructions are already consolidated in `AGENTS.md`.

Read `.ecc/GRAPHS.html` for detailed MCP usage documentation.

### Step 6: Build the Knowledge Graph

```bash
git add .
code-review-graph build
code-review-graph status
```

**VERIFY:** The `status` output must show non-zero Nodes, Edges, and Files. If it shows 0, the files were not git-tracked. Run `git add .` first. (See EVOLUTION.md RULE-001)

### Step 7: Initial Commit

```powershell
git add .
git commit -m "chore: initial project scaffold"
```

### Step 8: Confirm to User

Tell the user:
- Project name has been set
- .NET solution and web API project have been created
- code-review-graph MCP is installed and the knowledge graph is built
- Show the `code-review-graph status` output as proof
- This `INIT.md` file can now be deleted

---

## For Humans (Manual Setup)

If you prefer to set up manually without AI assistance:

1. **Set project name:**
   ```powershell
   .\devops\scripts\init-project.ps1 -ProjectName YourProjectName
   ```
   *(PascalCase, e.g., `ApiHub` or `PaymentService`)*

2. **Scaffold .NET projects:**
   ```powershell
   dotnet new sln -n YourProjectName --format slnx
   dotnet new webapi -n YourProjectName.App -o src/YourProjectName.App
   dotnet sln add src/YourProjectName.App
   ```

3. **(Optional) Install AI code review tools:**
   ```bash
   pip install code-review-graph
   code-review-graph install
   git add .
   code-review-graph build
   ```

4. **Initial commit:**
   ```powershell
   git add .
   git commit -m "chore: initial project scaffold"
   ```

5. Delete this `INIT.md` file and start coding.
