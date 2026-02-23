#!/bin/bash

# Thesis Website Setup Script
# This script helps you get started with your Quarto thesis website

echo "🎓 Setting up Thesis Website..."
echo ""

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "❌ uv not found. Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "✅ uv installed. Please restart your terminal and run this script again."
    exit 1
fi

# Create virtual environment
echo "📦 Creating Python virtual environment..."
uv venv

# Activate virtual environment and install dependencies
echo "📚 Installing Python dependencies..."
source .venv/bin/activate
uv pip install -r requirements.txt

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Activate the virtual environment:"
echo "   source .venv/bin/activate"
echo ""
echo "2. Preview your site:"
echo "   quarto preview"
echo ""
echo "3. Customize _quarto.yml and .qmd files"
echo ""
echo "4. When ready to deploy:"
echo "   quarto render"
echo "   git add ."
echo "   git commit -m 'Initial site'"
echo "   git push"
echo ""
echo "📖 See README.md for detailed instructions"
