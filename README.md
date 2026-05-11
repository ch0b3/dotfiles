# dotfiles

macOSの開発環境セットアップ用dotfiles。

## セットアップ

```bash
git clone git@github.com:ch0b3/dotfiles.git
cd dotfiles
./install.sh
```

## インストール後

ローカル設定ファイルを作成して編集:

```bash
cp .gitconfig.local.example ~/.gitconfig.local
cp .zshrc.local.example ~/.zshrc.local
```

- `~/.gitconfig.local` — Git のユーザー名・メール（アカウントごとに変更）
- `~/.zshrc.local` — 環境固有のPATH、トークン、ツール設定

## 構成

| ファイル | 用途 |
|---|---|
| `.zshrc` | シェル設定（alias, peco連携, PATH） |
| `.gitconfig` | Git alias（ユーザー情報は `.gitconfig.local` に分離） |
| `.vimrc` | Vim設定 |
| `config/starship.toml` | Starshipプロンプト設定 |
| `Brewfile` | Homebrewパッケージ一覧 |
| `install.sh` | セットアップスクリプト |

## キーバインド（peco）

| キー | 機能 |
|---|---|
| `Ctrl+R` | コマンド履歴検索 |
| `Ctrl+T` | 最近のディレクトリ移動 |
| `Ctrl+B` | Gitブランチ切り替え |
| `Ctrl+]` | ghqリポジトリ移動 |
