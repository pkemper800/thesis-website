# Thesis Research Website

A Quarto-based website for documenting thesis research, including Python, R, and GIS analyses.

## 🚀 Quick Start

### Prerequisites

1. **Install Quarto**: Download from [quarto.org](https://quarto.org/docs/get-started/)
2. **Install Python**: Version 3.9 or higher
3. **Install R**: Version 4.2 or higher (optional if not using R)
4. **Install uv**: Astral's fast Python package manager
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```
5. **Install VS Code**: Download from [code.visualstudio.com](https://code.visualstudio.com/)

### VS Code Extensions (Recommended)

Install these extensions in VS Code:
- **Quarto** (quarto.quarto)
- **Python** (ms-python.python)
- **R** (REditorSupport.r)
- **GitLens** (eamodio.gitlens)

## 📦 Setup with UV

### 1. Clone or Create Project

```bash
# If starting fresh with this template
cd thesis-website

# Create Python virtual environment with uv
uv venv

# Activate the virtual environment
# On macOS/Linux:
source .venv/bin/activate
# On Windows:
.venv\Scripts\activate

# Install Python dependencies
uv pip install -r requirements.txt
```

### 2. Install R Packages (if using R)

Open R or RStudio and run:

```r
install.packages(c(
  "tidyverse",
  "ggplot2", 
  "broom",
  "knitr",
  "rmarkdown"
))
```

### 3. Preview Your Site

```bash
quarto preview
```

This will open your site in a browser at `http://localhost:4200/`

## 🔗 Connect to GitHub

### Option A: Using VS Code

1. **Initialize Git** (if not already done):
   - Open VS Code
   - Open the thesis-website folder
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Type "Git: Initialize Repository" and select it

2. **Create GitHub Repository**:
   - Go to [github.com](https://github.com) and create a new repository
   - Name it `thesis-website` (or your preferred name)
   - **Do NOT** initialize with README (you already have files)

3. **Connect to GitHub**:
   - In VS Code, click the Source Control icon (left sidebar)
   - Click "Publish to GitHub" button
   - Select your repository
   - Choose "Publish to GitHub public repository" or private

### Option B: Using Command Line

```bash
# Initialize git repository
git init

# Add all files
git add .

# First commit
git commit -m "Initial commit: Quarto thesis website"

# Add GitHub remote (replace with your username and repo name)
git remote add origin https://github.com/yourusername/thesis-website.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## 🌐 Deploy to GitHub Pages

### Step 1: Configure Quarto for GitHub Pages

The `_quarto.yml` is already configured with:
```yaml
project:
  output-dir: docs
```

This tells Quarto to build the site into the `docs/` folder.

### Step 2: Commit and Push

The repository includes a GitHub Actions workflow that renders the site and
deploys `docs/` automatically.

```bash
git add .
git commit -m "Update thesis website"
git push origin main
```

### Step 3: Enable GitHub Pages (one-time)

1. Go to your repository on GitHub (`thesis-website`)
2. Click "Settings" → "Pages"
3. Under "Build and deployment", set:
   - **Source**: `GitHub Actions`
4. Save

Your site will be live at: `https://pkemper800.github.io/thesis-website/`

## 🎨 Customization

### Change Colors and Fonts

Edit `custom.scss`:

```scss
$primary: #2c3e50;    // Main color
$secondary: #3498db;  // Accent color
$font-family-sans-serif: "Your Font", sans-serif;
```

### Update Navigation

Edit `_quarto.yml` under the `website` → `navbar` section:

```yaml
navbar:
  left:
    - href: index.qmd
      text: Home
    - href: your-new-page.qmd
      text: New Page
```

### Add New Analysis Pages

1. Create a new `.qmd` file in the `research/` folder
2. Add it to the sidebar in `_quarto.yml`:

```yaml
sidebar:
  contents:
    - research/your-new-analysis.qmd
```

### Change Theme

Quarto includes many built-in themes. In `_quarto.yml`:

```yaml
format:
  html:
    theme: 
      light: flatly  # Try: cosmo, flatly, journal, lumen, etc.
      dark: darkly   # Try: darkly, slate, superhero, etc.
```

## 📝 Working with Code

### Python Code Blocks

```python
# This code will execute when you render
import pandas as pd
data = pd.read_csv("mydata.csv")
```

### R Code Blocks

```r
# This code will execute when you render
library(ggplot2)
ggplot(data, aes(x, y)) + geom_point()
```

### Code Options

Control code visibility with YAML options:

```yaml
#| echo: true      # Show code
#| eval: true      # Run code
#| warning: false  # Hide warnings
#| message: false  # Hide messages
#| code-fold: true # Make code collapsible
```

## 🔄 Workflow with UV

### Adding New Python Packages

```bash
# Install a new package
uv pip install package-name

# Update requirements.txt
uv pip freeze > requirements.txt

# Commit changes
git add requirements.txt
git commit -m "Add new package"
git push
```

### Keeping Packages Updated

```bash
# Update all packages
uv pip install --upgrade -r requirements.txt
```

## 📊 Working with Data

### Store Data Files

Create a `data/` folder:

```bash
mkdir data
```

Add to `.gitignore` if data is large or sensitive:

```
# In .gitignore
data/*.csv
data/*.xlsx
```

### Load Data in Analysis

Python:
```python
import pandas as pd
df = pd.read_csv("data/mydata.csv")
```

R:
```r
library(readr)
df <- read_csv("data/mydata.csv")
```

## 🐛 Troubleshooting

### Python Kernel Not Found

```bash
# Install ipykernel in your virtual environment
uv pip install ipykernel
python -m ipykernel install --user --name thesis-env
```

### R Not Rendering

Make sure R is in your PATH and packages are installed:

```r
install.packages("rmarkdown")
```

### Site Not Updating on GitHub Pages

1. Check that `docs/` folder is committed
2. Verify GitHub Pages settings point to `/docs`
3. Wait 1-2 minutes for deployment
4. Clear browser cache

## 📚 Additional Resources

- [Quarto Documentation](https://quarto.org/docs/guide/)
- [Quarto Gallery](https://quarto.org/docs/gallery/)
- [UV Documentation](https://github.com/astral-sh/uv)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)

## 🤝 Contributing to Your Site

As you work:

1. Make changes to `.qmd` files
2. Preview locally: `quarto preview`
3. When satisfied:
   ```bash
   quarto render
   git add .
   git commit -m "Update analysis"
   git push
   ```

## 📄 License

Add your preferred license here.

## ✉️ Contact

[Your Name] - your.email@university.edu
