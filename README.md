# Bob — Portable AI Agent System for Kiro CLI

A git-hosted, symlink-deployed supervisor/worker agent system. Clone on any machine, run install, Bob is ready across all projects.

## Architecture

```
You (human)
  └── Bob (supervisor) — plans, verifies, gates to you on decisions
       └── Minion(s) (workers) — fresh context, write code, report back
```

Bob never writes application code. He plans tasks, dispatches minions via `subagent`, verifies their output by reading actual files, and manages git commits.

## Install

```powershell
git clone https://github.com/shalmanassar/Bob.git
cd Bob
.\install.ps1
```

This symlinks `agents/` and `prompts/` into `~/.kiro/`, making Bob available globally.

## Usage

```
/agent bob          # Switch to Bob
/agent minion       # Switch to Minion (usually Bob does this via subagent)
```

## Bob's Non-Negotiables

- **Git is sacred** — commit before changing, atomic commits, descriptive messages
- **No hardcoded values** — config in config files, not in code
- **No build logic in production** — schema/migration via scripts, never app startup
- **Search before writing** — never duplicate existing functionality
- **Clean code** — no dead functions, no orphaned imports, no commented-out blocks
- **Verify before commit** — build must pass, actual code must be read
- **Ask, don't guess** — design/UI/scope questions gate to the user

## Gates

Bob stops and asks you when encountering:
- Database schema or class design decisions
- UI/UX layout choices
- Scope questions ("should I include X?")
- Conflicting requirements
- New dependency additions
- Destructive operations

## Per-Project State (Optional)

Projects can include a `Bob/CURRENT.md` for continuity:

```
Bob/
└── CURRENT.md    # Last 3 actions, what's next, blockers
```

Bob reads this on activation if it exists. The knowledge base handles everything else.

## Updating

Pull the repo. Symlinks mean changes propagate immediately — no reinstall needed.

```powershell
cd path\to\Bob
git pull
```

## File Structure

```
Bob/
├── agents/
│   ├── bob.json          # Supervisor config
│   └── minion.json       # Worker config
├── prompts/
│   ├── bob-prompt.md     # Bob's personality, rules, gates, workflow
│   └── minion-prompt.md  # Minion behavior (minimal, focused)
├── install.ps1           # Symlinks into ~/.kiro/
└── README.md
```
