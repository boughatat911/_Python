#!/bin/bash

set -e

echo "🚀 Installing Python 3.10.13 (no sudo, pyenv-based)"
echo "-----------------------------------------------"

# 1. Check Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew not found. Please install Homebrew first."
  exit 1
fi

echo "✅ Homebrew found"

# 2. Install pyenv if missing
if ! command -v pyenv >/dev/null 2>&1; then
  echo "📦 Installing pyenv..."
  curl https://pyenv.run | bash
else
  echo "✅ pyenv already installed"
fi

# 3. Configure shell (zsh)
ZSHRC="$HOME/.zshrc"

if ! grep -q 'pyenv init' "$ZSHRC" 2>/dev/null; then
  echo "🔧 Configuring pyenv in ~/.zshrc"

  cat << 'EOF' >> "$ZSHRC"

# ---- pyenv configuration ----
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# -----------------------------
EOF
else
  echo "✅ pyenv already configured in ~/.zshrc"
fi

# Load pyenv for this script
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# 4. Install required libraries
echo "📦 Installing required libraries (readline, openssl@1.1)"
brew install readline openssl@1.1 || true

# 5. Install Python 3.10.13 (SSL-safe)
if pyenv versions | grep -q "3.10.13"; then
  echo "✅ Python 3.10.13 already installed"
else
  echo "🐍 Installing Python 3.10.13 (SSL-safe mode)"
  env \
    PYTHON_BUILD_SKIP_OPENSSL=1 \
    PYTHON_BUILD_SKIP_READLINE=1 \
    pyenv install 3.10.13
fi

# 6. Set global Python version
echo "🎯 Setting Python 3.10.13 as global default"
pyenv global 3.10.13
pyenv rehash

echo ""
echo "✅ Installation complete!"
echo "-----------------------------------------------"
echo "Run the following to verify:"
echo "  python --version"
echo "  pip --version"
echo ""
echo "⚠️ If python still shows 2.7, restart your terminal or run:"
echo "  source ~/.zshrc"
