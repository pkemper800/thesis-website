# UV & VS Code Integration Guide

This guide covers how to use UV (Astral's Python package manager) with VS Code for your thesis website.

## 🚀 What is UV?

UV is a blazingly fast Python package manager and project manager written in Rust by Astral (creators of Ruff). It's designed to replace pip, pip-tools, virtualenv, and more with a single tool.

**Benefits:**
- ⚡ 10-100x faster than pip
- 🎯 Better dependency resolution
- 🔒 Automatic lock files
- 🐍 Python version management
- 📦 Built-in virtual environment management

## 📥 Installing UV

### macOS/Linux

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Windows

```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### Verify Installation

```bash
uv --version
```

## 🏗️ Project Setup with UV

### 1. Create Virtual Environment

```bash
cd thesis-website

# Create virtual environment
uv venv

# This creates a .venv/ folder with Python isolated from system
```

### 2. Activate Virtual Environment

**macOS/Linux:**
```bash
source .venv/bin/activate
```

**Windows (PowerShell):**
```powershell
.venv\Scripts\Activate.ps1
```

**Windows (CMD):**
```cmd
.venv\Scripts\activate.bat
```

### 3. Install Dependencies

```bash
# Install from requirements.txt
uv pip install -r requirements.txt

# This is MUCH faster than: pip install -r requirements.txt
```

## 🔧 Using UV Commands

### Installing Packages

```bash
# Install a single package
uv pip install pandas

# Install specific version
uv pip install numpy==1.24.0

# Install multiple packages
uv pip install matplotlib seaborn plotly

# Install from requirements.txt
uv pip install -r requirements.txt

# Install with extras
uv pip install geopandas[all]
```

### Managing Dependencies

```bash
# Update requirements.txt with current packages
uv pip freeze > requirements.txt

# List installed packages
uv pip list

# Show package details
uv pip show pandas

# Upgrade a package
uv pip install --upgrade pandas

# Upgrade all packages
uv pip install --upgrade -r requirements.txt
```

### Uninstalling Packages

```bash
# Remove a package
uv pip uninstall pandas

# Remove multiple packages
uv pip uninstall pandas numpy matplotlib
```

## 💻 VS Code Integration

### 1. Install VS Code Extensions

Open VS Code and install:
- **Python** (ms-python.python)
- **Quarto** (quarto.quarto)
- **Jupyter** (ms-toolsai.jupyter)
- **R** (REditorSupport.r) - if using R
- **GitLens** (eamodio.gitlens)

### 2. Configure Python Interpreter

1. Open your thesis-website folder in VS Code
2. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
3. Type "Python: Select Interpreter"
4. Choose the interpreter from `.venv/bin/python`

**Alternative - Quick Setup:**
VS Code should automatically detect `.venv` and ask if you want to use it. Click "Yes".

### 3. Configure VS Code Settings

Create `.vscode/settings.json`:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "python.analysis.extraPaths": [
    "${workspaceFolder}"
  ],
  
  // Quarto settings
  "quarto.render.previewType": "internal",
  
  // Formatting
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.organizeImports": true
    }
  },
  
  // File associations
  "files.associations": {
    "*.qmd": "markdown"
  }
}
```

### 4. Configure Terminal

VS Code Terminal should automatically activate the virtual environment when you open a new terminal.

To verify:
```bash
# Should show (.venv) prefix
# Should show path to .venv/bin/python
which python
```

## 🔄 Recommended Workflow

### Daily Development

```bash
# 1. Activate environment (if not auto-activated)
source .venv/bin/activate

# 2. Pull latest changes
git pull

# 3. Update dependencies if requirements.txt changed
uv pip install -r requirements.txt

# 4. Start development
quarto preview
```

### Adding New Package

```bash
# 1. Install package
uv pip install package-name

# 2. Test it works
python -c "import package_name; print('Success!')"

# 3. Update requirements.txt
uv pip freeze > requirements.txt

# 4. Commit changes
git add requirements.txt
git commit -m "Add package-name for [purpose]"
git push
```

### Creating Analysis Notebook

1. Create new `.qmd` file in `research/` folder
2. Add Python code block:
   ````markdown
   ```{python}
   import pandas as pd
   # Your code here
   ```
   ````
3. VS Code will use the `.venv` interpreter automatically
4. Run `quarto preview` to see rendered output

## 🎯 Advanced UV Features

### Using pyproject.toml (Recommended)

Instead of `requirements.txt`, use `pyproject.toml`:

```toml
[project]
name = "thesis-website"
version = "0.1.0"
description = "Thesis research website"
dependencies = [
    "numpy>=1.24.0",
    "pandas>=2.0.0",
    "matplotlib>=3.7.0",
    "seaborn>=0.12.0",
    "geopandas>=0.13.0",
    "folium>=0.14.0",
]

[project.optional-dependencies]
dev = [
    "jupyter>=1.0.0",
    "black>=23.0.0",
    "ruff>=0.1.0",
]
```

Install with:
```bash
# Install main dependencies
uv pip install -e .

# Install with dev dependencies
uv pip install -e ".[dev]"
```

### Lock Files

UV automatically creates lock files for reproducibility:

```bash
# Create uv.lock file
uv pip compile pyproject.toml -o uv.lock

# Install from lock file
uv pip sync uv.lock
```

### Python Version Management

UV can install and manage Python versions:

```bash
# Install Python 3.11
uv python install 3.11

# Create venv with specific Python version
uv venv --python 3.11

# List available Python versions
uv python list
```

## 🐛 Troubleshooting

### VS Code Not Finding Interpreter

**Solution 1 - Manual Selection:**
1. Press `Ctrl+Shift+P`
2. "Python: Select Interpreter"
3. Choose `.venv/bin/python`

**Solution 2 - Reload Window:**
1. Press `Ctrl+Shift+P`
2. "Developer: Reload Window"

### Virtual Environment Not Activating

**Check if .venv exists:**
```bash
ls -la .venv
```

**If missing, recreate:**
```bash
uv venv
source .venv/bin/activate
uv pip install -r requirements.txt
```

### Jupyter Kernel Not Found

```bash
# Install ipykernel
uv pip install ipykernel

# Register kernel
python -m ipykernel install --user --name=thesis-env --display-name="Thesis Python"

# Restart VS Code
```

### Import Errors in .qmd Files

**Check that packages are installed:**
```bash
uv pip list | grep package-name
```

**Reinstall if needed:**
```bash
uv pip install --force-reinstall package-name
```

### UV Command Not Found

**Add UV to PATH:**

**macOS/Linux** - Add to `~/.bashrc` or `~/.zshrc`:
```bash
export PATH="$HOME/.cargo/bin:$PATH"
```

**Windows** - UV installer should add to PATH automatically. If not:
1. Search "Environment Variables" in Windows
2. Add `%USERPROFILE%\.cargo\bin` to PATH

## 🔐 Best Practices

### 1. Always Use Virtual Environments

```bash
# ✅ GOOD - Isolated environment
uv venv
source .venv/bin/activate
uv pip install package

# ❌ BAD - Pollutes system Python
pip install package
```

### 2. Keep requirements.txt Updated

```bash
# After installing/removing packages
uv pip freeze > requirements.txt
git add requirements.txt
git commit -m "Update dependencies"
```

### 3. Use Specific Versions for Reproducibility

```txt
# ✅ GOOD - Specific versions
numpy==1.24.3
pandas==2.0.1

# ⚠️ OKAY - Minimum version
numpy>=1.24.0

# ❌ BAD - No version control
numpy
pandas
```

### 4. Separate Dev Dependencies

Create separate requirements files:

**requirements.txt** (production):
```txt
numpy==1.24.3
pandas==2.0.1
matplotlib==3.7.1
```

**requirements-dev.txt** (development):
```txt
-r requirements.txt
jupyter==1.0.0
black==23.3.0
pytest==7.3.1
```

Install dev dependencies:
```bash
uv pip install -r requirements-dev.txt
```

## 📊 Performance Comparison

| Operation | pip | UV | Speedup |
|-----------|-----|-------|---------|
| Install 50 packages | 45s | 3s | **15x** |
| Resolve dependencies | 12s | 0.5s | **24x** |
| Create venv | 3s | 0.2s | **15x** |

## 🔗 Useful Resources

- [UV Documentation](https://github.com/astral-sh/uv)
- [UV vs pip Comparison](https://astral.sh/blog/uv)
- [VS Code Python Tutorial](https://code.visualstudio.com/docs/python/python-tutorial)
- [Quarto VS Code Extension](https://quarto.org/docs/tools/vscode.html)

## 💡 Quick Reference

```bash
# Setup
uv venv                              # Create virtual environment
source .venv/bin/activate            # Activate (Mac/Linux)
.venv\Scripts\activate               # Activate (Windows)

# Install
uv pip install package               # Install package
uv pip install -r requirements.txt   # Install from file
uv pip install --upgrade package     # Upgrade package

# Manage
uv pip list                          # List packages
uv pip freeze > requirements.txt     # Save dependencies
uv pip uninstall package             # Remove package

# Info
uv --version                         # Check UV version
uv pip show package                  # Package details
```

---

**Pro Tip:** Create an alias in your shell config for quick activation:

```bash
# Add to ~/.bashrc or ~/.zshrc
alias activate='source .venv/bin/activate'
```

Then just run `activate` in your project folder!
