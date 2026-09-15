#!/bin/bash

  # 1. 获取上游最新代码
  echo "Fetching latest changes from upstream..."
  git fetch upstream

  # 2. 合并上游代码到当前分支
  echo "Merging upstream/main..."
  git merge upstream/main --no-edit

  # 3. 【关键】强制还原你的自定义文件
  # 如果合并过程中产生了冲突，这里会强制用你的版本覆盖上游版本
  echo "Restoring customizations..."

  # 还原 Release 工作流 (保留你的版本)
  git checkout --ours .github/workflows/release.yml
  git add .github/workflows/release.yml

  # 还原 CLI 构建工作流
  # 这里使用你之前那个自定义版本的 Commit ID，确保逻辑永远是你想要的
  # 如果以后你更新了自定义逻辑，记得把这里的 ID 改成最新的
  git checkout 013502ae -- .github/workflows/build_cli_linux.yml
  mv .github/workflows/build_cli_linux.yml .github/workflows/build_linux_cli.yml
  git add .github/workflows/build_linux_cli.yml

  # 还原 README (如果你想完全保留自己的 README，取消下面一行的注释)
  # git checkout --ours README.md && git add README.md

  # 4. 提交并推送
  echo "Pushing changes to your GitHub..."
  git add .
  git commit -m "Auto-sync with upstream and preserve customizations" 2>/dev/null || echo "No changes to commit"
  git push origin main

  echo "✅ Sync Complete!"
