# 🚀 How to Upgrade to Python 3.10 on macOS (No sudo, 42-friendly)

This guide shows how to install **Python 3.10.13** on macOS **without sudo**, even on **macOS 10.15 (Catalina)** and behind school / proxy networks.

---

## ✅ Prerequisites

* macOS (Intel or Apple Silicon)

Check brew:

```bash
brew --version
```

---

## 🧩 Step 1: Install pyenv (user-only)

```bash
curl https://pyenv.run | bash
```

Add pyenv to your shell (`~/.zshrc`):

```bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
```

Reload shell:

```bash
source ~/.zshrc
```

Verify:

```bash
pyenv --version
```

---

## 🛠 Step 2: Install required libraries (no sudo)

```bash
brew install readline openssl@1.1
```

---

## 🔥 Step 3: Install Python 3.10 (SSL-safe method)

```bash
env \
  PYTHON_BUILD_SKIP_OPENSSL=1 \
  PYTHON_BUILD_SKIP_READLINE=1 \
  pyenv install 3.10.13
```

⚠️ You may see a warning about `_lzma`.
This is **normal and safe to ignore**.

---

## 🎯 Step 4: Set Python 3.10 as default

```bash
pyenv global 3.10.13
pyenv rehash
```

---

## ✅ Step 5: Verify

```bash
which python
python --version
pip --version
```

Expected output:

```
Python 3.10.13
pip ... (python 3.10)
```

If `python` still shows **2.7**, restart your terminal or re-source `.zshrc`.

---

## 🧠 Notes

* No sudo required
* Works on macOS 10.15

---

## 🏁 Done!

