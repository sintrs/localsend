#!/bin/bash

  # 1. 获取上游最新代码
  echo "Fetching latest changes from upstream..."
  git fetch upstream

  # 2. 合并上游代码到当前分支
  echo "Merging upstream/main..."
  git merge upstream/main --no-edit

  # 3. 【关键】强制还原你的自定义文件
  echo "Restoring customizations..."

  # 还原 Release 工作流 (保留你的版本)
  git checkout --ours .github/workflows/release.yml 2>/dev/null || true
  git add .github/workflows/release.yml

  # 还原 CLI 构建工作流 (直接还原成最新的正确文件名)
  # 使用你的最新 ID: 013502ae
  git checkout 013502ae -- .github/workflows/build_linux_cli.yml
  git add .github/workflows/build_linux_cli.yml

  # 4. 提交并推送
  echo "Pushing changes to your GitHub..."
  git add .
  git commit -m "Auto-sync with upstream and preserve customizations" 2>/dev/null || echo "No changes to commit"
  git push origin main

  echo "✅ Sync Complete!"
