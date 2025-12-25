# Powerlevel10k Configuration Reference

Comprehensive hierarchical breakdown of P10K.zsh configuration using MECE (Mutually Exclusive, Collectively Exhaustive) principles.

---

## **1. Global Configuration**

### 1.1 File Metadata
- **Generated**: 2025-07-22 00:21 JST
- **Base Template**: `p10k-lean.zsh`
- **Style**: Lean prompt with single line
- **Features**: nerdfont-v3, powerline, large icons, unicode, 24h time, compact layout

### 1.2 Prompt Layout

#### Left Prompt Elements (Line 32-37)
```zsh
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon                 # OS identifier
  dir                     # Current directory
  vcs                     # Git status
  prompt_char             # Prompt symbol
)
```

#### Right Prompt Elements (Line 43-111)
```zsh
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status                  # Exit code
  command_execution_time  # Command duration
  background_jobs         # Background job indicator
  direnv                  # direnv status
  # ... Development environments (asdf, virtualenv, pyenv, etc.)
  # ... Cloud services (kubecontext, terraform, aws, azure, gcloud)
  # ... Shell indicators (ranger, yazi, vim_shell, nix_shell)
  # ... System info (todo, timewarrior, taskwarrior)
  context                 # user@hostname
  time                    # Current time
)
```

### 1.3 Visual Style (Line 113-181)

#### Typography & Icons
- **Mode**: `nerdfont-v3`
- **Icon Padding**: `moderate` (prevents overlap in non-monospace fonts)
- **Icon Position**: Before content (`ICON_BEFORE_CONTENT=true`)

#### Colors & Layout
- **Background**: Transparent
- **Segment Separator**: Space character
- **Line Separators**: None (empty)
- **Newline Before Prompt**: Disabled (`PROMPT_ADD_NEWLINE=false`)
- **Ruler**: Disabled (`SHOW_RULER=false`)

---

## **2. Left Prompt Segments**

### 2.1 OS Icon (Line 183-187)
```zsh
POWERLEVEL9K_OS_ICON_FOREGROUND=
# Custom icon: POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='⭐'
```
- **Purpose**: Visual OS identifier (Arch, Ubuntu, macOS, etc.)
- **Color**: Default (inherits terminal theme)

### 2.2 Prompt Character (Line 189-206)

#### Color States
| State | Foreground Color | Hex/Code |
|-------|-----------------|----------|
| Success (OK) | Green | 76 |
| Error | Red | 196 |

#### Vi Mode Symbols
| Mode | Symbol | Variable |
|------|--------|----------|
| Insert (OK) | `❯` | `PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION` |
| Insert (Error) | `❯` | `PROMPT_CHAR_ERROR_VIINS_CONTENT_EXPANSION` |
| Command | `❮` | `PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION` |
| Visual | `V` | `PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION` |
| Overwrite | `▶` | `PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION` |

#### Configuration
```zsh
POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
```

### 2.3 Directory (Line 208-341)

#### Color Scheme
| Element | Color | Code | Purpose |
|---------|-------|------|---------|
| Current Directory | Cyan | 31 | Active path |
| Shortened Segments | Purple | 103 | Truncated parts |
| Anchor Segments | Bright Cyan | 39 | Project roots |

#### Shortening Strategy
```zsh
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
POWERLEVEL9K_SHORTEN_DELIMITER=
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_DIR_MAX_LENGTH=80
```
- **Method**: Shorten to unique prefix (tab-completable)
- **Anchor Length**: Last 1 segment always shown
- **Max Length**: 80 characters or 50% terminal width

#### Anchor Files (Line 224-248)
Directories containing these files won't be shortened:
```zsh
.bzr, .citc, .git, .hg, .svn, CVS
.node-version, .python-version, .go-version, .ruby-version
.lua-version, .java-version, .perl-version, .php-version
.tool-versions, .mise.toml, .shorten_folder_marker
.terraform, Cargo.toml, composer.json, go.mod, package.json, stack.yaml
```

#### Special Features
```zsh
POWERLEVEL9K_DIR_SHOW_WRITABLE=v3           # Show lock icon for non-writable
POWERLEVEL9K_DIR_ANCHOR_BOLD=true           # Bold anchor directories
POWERLEVEL9K_DIR_HYPERLINK=false            # No hyperlinks
POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40     # Reserve space for typing
```

### 2.4 VCS (Git Status) (Line 343-505)

#### Visual Elements
```zsh
POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '      # Git branch icon
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
POWERLEVEL9K_VCS_PREFIX='%fon '
```

#### Custom Git Formatter (`my_git_formatter()`, Line 359-462)

**Branch/Tag Display**
- Truncates names longer than 32 chars: `first 12 … last 12`
- Shows commit hash if no branch/tag: `@12345678`
- Displays tracking branch if different from local

**Status Indicators**
| Symbol | Meaning | Variable | Example |
|--------|---------|----------|---------|
| `wip` | Commit message contains "wip"/"WIP" | VCS_STATUS_COMMIT_SUMMARY | `main wip` |
| `⇣42` | Commits behind remote | VCS_STATUS_COMMITS_BEHIND | `⇣3` |
| `⇡42` | Commits ahead of remote | VCS_STATUS_COMMITS_AHEAD | `⇡5` |
| `⇠42` | Commits behind push remote | VCS_STATUS_PUSH_COMMITS_BEHIND | `⇠2` |
| `⇢42` | Commits ahead of push remote | VCS_STATUS_PUSH_COMMITS_AHEAD | `⇢1` |
| `*42` | Number of stashes | VCS_STATUS_STASHES | `*3` |
| `merge` | Repo in special state (merge/rebase) | VCS_STATUS_ACTION | `merge` |
| `~42` | Merge conflicts | VCS_STATUS_NUM_CONFLICTED | `~2` |
| `+42` | Staged changes | VCS_STATUS_NUM_STAGED | `+5` |
| `!42` | Unstaged changes | VCS_STATUS_NUM_UNSTAGED | `!3` |
| `?42` | Untracked files | VCS_STATUS_NUM_UNTRACKED | `?7` |
| `─` | Unknown dirty state | VCS_STATUS_HAS_UNSTAGED | `─` |

**Color Coding (Up-to-date state)**
| Element | Color | Code |
|---------|-------|------|
| Default/Meta | Default | `%f` |
| Clean | Green | 76 |
| Modified | Yellow | 178 |
| Untracked | Blue | 39 |
| Conflicted | Red | 196 |

**Color Coding (Incomplete/stale state)**
- All elements: Grey (244)

#### Performance Settings
```zsh
POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1              # No limit (infinity)
POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'         # Disable for home dir
POWERLEVEL9K_VCS_BACKENDS=(git)                       # Git only
```

#### Format Configuration
```zsh
POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
```

---

## **3. Right Prompt Segments**

### 3.1 Status & Execution (Line 506-563)

#### Exit Status (Line 506-540)
```zsh
POWERLEVEL9K_STATUS_EXTENDED_STATES=true
```

| State | Enabled | Color | Icon | When Shown |
|-------|---------|-------|------|------------|
| OK | `false` | 70 | ✔ | Success (hidden - prompt_char shows green) |
| OK_PIPE | `true` | 70 | ✔ | Pipe failure but overall success |
| ERROR | `false` | 160 | ✘ | Simple error code (hidden - prompt_char shows red) |
| ERROR_SIGNAL | `true` | 160 | ✘ | Terminated by signal |
| ERROR_PIPE | `true` | 160 | ✘ | Pipe failure with non-zero exit |

```zsh
POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false    # "INT" instead of "SIGINT(2)"
```

#### Command Execution Time (Line 542-554)
```zsh
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3      # Show if ≥3 seconds
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0      # Round to seconds
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=101
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='%ftook '
```

#### Background Jobs (Line 556-562)
```zsh
POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false           # Show icon only (not count)
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=70
```

### 3.2 Development Environment Tools

#### 3.2.1 direnv (Line 564-568)
```zsh
POWERLEVEL9K_DIRENV_FOREGROUND=178
```

#### 3.2.2 asdf (Universal Version Manager) (Line 570-709)

**Global Settings**
```zsh
POWERLEVEL9K_ASDF_FOREGROUND=66                      # Default color
POWERLEVEL9K_ASDF_SOURCES=(shell local global)       # Show all sources
POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=false           # Hide if matches global
POWERLEVEL9K_ASDF_SHOW_SYSTEM=true                   # Show "system" versions
POWERLEVEL9K_ASDF_SHOW_ON_UPGLOB=                    # No file pattern filter
```

**Language-Specific Colors**
| Language | Color | Code |
|----------|-------|------|
| Ruby | Red | 168 |
| Python | Cyan | 37 |
| Go | Cyan | 37 |
| Node.js | Green | 70 |
| Rust | Cyan | 37 |
| .NET Core | Orange | 134 |
| Flutter | Cyan | 38 |
| Lua | Green | 32 |
| Java | Green | 32 |
| Perl | Blue | 67 |
| Erlang | Magenta | 125 |
| Elixir | Purple | 129 |
| Postgres | Cyan | 31 |
| PHP | Purple | 99 |
| Haskell | Orange | 172 |
| Julia | Green | 70 |

#### 3.2.3 Language-Specific Version Managers

**Python Ecosystem** (Line 921-991)
```zsh
# virtualenv
POWERLEVEL9K_VIRTUALENV_FOREGROUND=37
POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false

# anaconda
POWERLEVEL9K_ANACONDA_FOREGROUND=37
POWERLEVEL9K_ANACONDA_CONTENT_EXPANSION='${${${${CONDA_PROMPT_MODIFIER#\(}% }%\)}:-${CONDA_PREFIX:t}}'

# pyenv
POWERLEVEL9K_PYENV_FOREGROUND=37
POWERLEVEL9K_PYENV_SOURCES=(shell local global)
POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
POWERLEVEL9K_PYENV_SHOW_SYSTEM=true
```

**Node.js Ecosystem** (Line 1006-1046)
```zsh
# nodenv
POWERLEVEL9K_NODENV_FOREGROUND=70
POWERLEVEL9K_NODENV_SOURCES=(shell local global)
POWERLEVEL9K_NODENV_PROMPT_ALWAYS_SHOW=false

# nvm
POWERLEVEL9K_NVM_FOREGROUND=70
POWERLEVEL9K_NVM_PROMPT_ALWAYS_SHOW=false
POWERLEVEL9K_NVM_SHOW_SYSTEM=true

# nodeenv
POWERLEVEL9K_NODEENV_FOREGROUND=70
POWERLEVEL9K_NODEENV_SHOW_NODE_VERSION=false

# node_version (direct)
POWERLEVEL9K_NODE_VERSION_FOREGROUND=70
POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true
```

**Ruby Ecosystem** (Line 1108-1129)
```zsh
# rbenv
POWERLEVEL9K_RBENV_FOREGROUND=168
POWERLEVEL9K_RBENV_SOURCES=(shell local global)
POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=false

# rvm
POWERLEVEL9K_RVM_FOREGROUND=168
POWERLEVEL9K_RVM_SHOW_GEMSET=false
POWERLEVEL9K_RVM_SHOW_PREFIX=false
```

**Other Version Managers**
| Tool | Language | Color | Project Only |
|------|----------|-------|--------------|
| goenv | Go | 37 | - |
| go_version | Go | 37 | Yes |
| rust_version | Rust | 37 | Yes |
| dotnet_version | .NET | 134 | Yes |
| php_version | PHP | 99 | Yes |
| java_version | Java | 32 | Yes |
| fvm | Flutter | 38 | - |
| luaenv | Lua | 32 | - |
| jenv | Java | 32 | - |
| plenv | Perl | 67 | - |
| perlbrew | Perl | 67 | Yes |
| phpenv | PHP | 99 | - |
| scalaenv | Scala | 160 | - |
| haskell_stack | Haskell | 172 | - |

### 3.3 Cloud & Infrastructure (Line 710-1540)

#### 3.3.1 NordVPN (Line 710-717)
```zsh
POWERLEVEL9K_NORDVPN_FOREGROUND=39
POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_CONTENT_EXPANSION=
```
- Only shows when connected

#### 3.3.2 Kubernetes (Line 1226-1311)
```zsh
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern|kubeseal|skaffold|kubent|kubecolor|cmctl|sparkctl'
POWERLEVEL9K_KUBECONTEXT_CLASSES=('*' DEFAULT)
POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=134
POWERLEVEL9K_KUBECONTEXT_PREFIX='%fat '
```

**Available Variables**
- `P9K_KUBECONTEXT_NAME` - Context name
- `P9K_KUBECONTEXT_CLUSTER` - Cluster name
- `P9K_KUBECONTEXT_NAMESPACE` - Namespace (default: "default")
- `P9K_KUBECONTEXT_USER` - Auth user
- `P9K_KUBECONTEXT_CLOUD_NAME` - "gke" or "eks"
- `P9K_KUBECONTEXT_CLOUD_ACCOUNT` - Account/project ID
- `P9K_KUBECONTEXT_CLOUD_ZONE` - Availability zone
- `P9K_KUBECONTEXT_CLOUD_CLUSTER` - Cluster name

**Content Expansion**
```zsh
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'
```

#### 3.3.3 Terraform (Line 1313-1350)
```zsh
POWERLEVEL9K_TERRAFORM_SHOW_DEFAULT=false            # Hide "default" workspace
POWERLEVEL9K_TERRAFORM_CLASSES=('*' OTHER)
POWERLEVEL9K_TERRAFORM_OTHER_FOREGROUND=38
POWERLEVEL9K_TERRAFORM_VERSION_FOREGROUND=38
```

#### 3.3.4 AWS (Line 1352-1397)
```zsh
POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|cdk|terraform|pulumi|terragrunt'
POWERLEVEL9K_AWS_CLASSES=('*' DEFAULT)
POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=208
POWERLEVEL9K_AWS_CONTENT_EXPANSION='${P9K_AWS_PROFILE//\%/%%}${P9K_AWS_REGION:+ ${P9K_AWS_REGION//\%/%%}}'
POWERLEVEL9K_AWS_EB_ENV_FOREGROUND=70
```

#### 3.3.5 Azure (Line 1399-1435)
```zsh
POWERLEVEL9K_AZURE_SHOW_ON_COMMAND='az|terraform|pulumi|terragrunt'
POWERLEVEL9K_AZURE_CLASSES=('*' OTHER)
POWERLEVEL9K_AZURE_OTHER_FOREGROUND=32
```

#### 3.3.6 Google Cloud (Line 1437-1476)
```zsh
POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcs|gsutil'
POWERLEVEL9K_GCLOUD_FOREGROUND=32
POWERLEVEL9K_GCLOUD_PARTIAL_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_ID//\%/%%}'
POWERLEVEL9K_GCLOUD_COMPLETE_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_NAME//\%/%%}'
POWERLEVEL9K_GCLOUD_REFRESH_PROJECT_NAME_SECONDS=60
```

**Available Variables**
- `P9K_GCLOUD_CONFIGURATION` - Config name
- `P9K_GCLOUD_ACCOUNT` - Account email
- `P9K_GCLOUD_PROJECT_ID` - Project ID
- `P9K_GCLOUD_PROJECT_NAME` - Project display name

#### 3.3.7 Google App Credentials (Line 1478-1530)
```zsh
POWERLEVEL9K_GOOGLE_APP_CRED_SHOW_ON_COMMAND='terraform|pulumi|terragrunt'
POWERLEVEL9K_GOOGLE_APP_CRED_CLASSES=('*' DEFAULT)
POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_FOREGROUND=32
POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_CONTENT_EXPANSION='${P9K_GOOGLE_APP_CRED_PROJECT_ID//\%/%%}'
```

#### 3.3.8 Toolbox (Line 1532-1540)
```zsh
POWERLEVEL9K_TOOLBOX_FOREGROUND=178
POWERLEVEL9K_TOOLBOX_CONTENT_EXPANSION='${P9K_TOOLBOX_NAME:#fedora-toolbox-*}'
POWERLEVEL9K_TOOLBOX_PREFIX='%fin '
```

### 3.4 Shell & File Manager Indicators (Line 719-778)

| Shell/Tool | Color | Code |
|------------|-------|------|
| ranger | Yellow | 178 |
| yazi | Yellow | 178 |
| nnn | Green | 72 |
| lf | Green | 72 |
| xplr | Green | 72 |
| vim_shell | Cyan | 34 |
| midnight_commander | Yellow | 178 |
| nix_shell | Green | 74 |
| chezmoi_shell | Cyan | 33 |

**nix_shell Special Settings**
```zsh
POWERLEVEL9K_NIX_SHELL_FOREGROUND=74
# POWERLEVEL9K_NIX_SHELL_INFER_FROM_PATH=false
# POWERLEVEL9K_NIX_SHELL_CONTENT_EXPANSION=    # Hide "pure"/"impure" text
```

### 3.5 System Information (Line 780-895)

#### Disk Usage (Line 780-791)
```zsh
POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND=35
POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND=220
POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND=160
POWERLEVEL9K_DISK_USAGE_WARNING_LEVEL=90
POWERLEVEL9K_DISK_USAGE_CRITICAL_LEVEL=95
POWERLEVEL9K_DISK_USAGE_ONLY_WARNING=false
```

#### RAM & Swap (Line 793-803)
```zsh
POWERLEVEL9K_RAM_FOREGROUND=66
POWERLEVEL9K_SWAP_FOREGROUND=96
```

#### CPU Load (Line 805-815)
```zsh
POWERLEVEL9K_LOAD_WHICH=5                    # 5-minute average
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=66       # <50%
POWERLEVEL9K_LOAD_WARNING_FOREGROUND=178     # 50-70%
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=166    # >70%
```

#### Task Management (Line 817-884)

**todo.txt** (Line 817-839)
```zsh
POWERLEVEL9K_TODO_FOREGROUND=110
POWERLEVEL9K_TODO_HIDE_ZERO_TOTAL=true
POWERLEVEL9K_TODO_HIDE_ZERO_FILTERED=false
# POWERLEVEL9K_TODO_CONTENT_EXPANSION='$P9K_TODO_FILTERED_TASK_COUNT'
```

**timewarrior** (Line 841-851)
```zsh
POWERLEVEL9K_TIMEWARRIOR_FOREGROUND=110
POWERLEVEL9K_TIMEWARRIOR_CONTENT_EXPANSION='${P9K_CONTENT:0:24}${${P9K_CONTENT:24}:+…}'
```

**taskwarrior** (Line 853-871)
```zsh
POWERLEVEL9K_TASKWARRIOR_FOREGROUND=74
# Default format: '${P9K_TASKWARRIOR_OVERDUE_COUNT:+"!$P9K_TASKWARRIOR_OVERDUE_COUNT/"}$P9K_TASKWARRIOR_PENDING_COUNT'
```

#### Per-Directory History (Line 873-884)
```zsh
POWERLEVEL9K_PER_DIRECTORY_HISTORY_LOCAL_FOREGROUND=135
POWERLEVEL9K_PER_DIRECTORY_HISTORY_GLOBAL_FOREGROUND=130
# POWERLEVEL9K_PER_DIRECTORY_HISTORY_LOCAL_CONTENT_EXPANSION=''   # Hide text, show icon only
```

#### CPU Architecture (Line 886-895)
```zsh
POWERLEVEL9K_CPU_ARCH_FOREGROUND=172
# POWERLEVEL9K_CPU_ARCH_X86_64_CONTENT_EXPANSION=                  # Hide for x86_64
```

### 3.6 Context & Network (Line 897-1643)

#### User Context (Line 897-919)
```zsh
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=178                 # Root user
POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=180 # SSH
POWERLEVEL9K_CONTEXT_FOREGROUND=180                      # Local

POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%B%n@%m'             # Bold user@host
POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'

POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=  # Hide unless SSH/root
POWERLEVEL9K_CONTEXT_PREFIX='%fwith '
```

#### Network Information

**Public IP** (Line 1542-1546)
```zsh
POWERLEVEL9K_PUBLIC_IP_FOREGROUND=94
```

**VPN IP** (Line 1548-1562)
```zsh
POWERLEVEL9K_VPN_IP_FOREGROUND=81
POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION=                   # Show icon only
POWERLEVEL9K_VPN_IP_INTERFACE='(gpd|wg|(.*tun)|tailscale)[0-9]*|(zt.*)'
POWERLEVEL9K_VPN_IP_SHOW_ALL=false                       # First match only
```

**IP Address** (Line 1564-1584)
```zsh
POWERLEVEL9K_IP_FOREGROUND=38
POWERLEVEL9K_IP_CONTENT_EXPANSION='$P9K_IP_IP${P9K_IP_RX_RATE:+ %70F⇣$P9K_IP_RX_RATE}${P9K_IP_TX_RATE:+ %215F⇡$P9K_IP_TX_RATE}'
POWERLEVEL9K_IP_INTERFACE='[ew].*'                       # Ethernet/WiFi
```

**Available Variables**
- `P9K_IP_IP` - IP address
- `P9K_IP_INTERFACE` - Network interface
- `P9K_IP_RX_BYTES` - Total received bytes
- `P9K_IP_TX_BYTES` - Total sent bytes
- `P9K_IP_RX_BYTES_DELTA` - Received since last prompt
- `P9K_IP_TX_BYTES_DELTA` - Sent since last prompt
- `P9K_IP_RX_RATE` - Receive rate
- `P9K_IP_TX_RATE` - Send rate

**Proxy** (Line 1586-1590)
```zsh
POWERLEVEL9K_PROXY_FOREGROUND=68
```

#### Battery (Line 1592-1603)
```zsh
POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
POWERLEVEL9K_BATTERY_LOW_FOREGROUND=160                  # Red
POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=70    # Green
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=178         # Yellow
POWERLEVEL9K_BATTERY_STAGES='\UF008E\UF007A\UF007B\UF007C\UF007D\UF007E\UF007F\UF0080\UF0081\UF0082\UF0079'
POWERLEVEL9K_BATTERY_VERBOSE=false                       # No time remaining
```

#### WiFi (Line 1605-1629)
```zsh
POWERLEVEL9K_WIFI_FOREGROUND=68
```

**Available Variables**
- `P9K_WIFI_SSID` - Network name
- `P9K_WIFI_LINK_AUTH` - Auth protocol (wpa2-psk, none, etc.)
- `P9K_WIFI_LAST_TX_RATE` - TX rate in Mbps
- `P9K_WIFI_RSSI` - Signal strength (-120 to 0 dBm)
- `P9K_WIFI_NOISE` - Noise level (-120 to 0 dBm)
- `P9K_WIFI_BARS` - Signal bars (0-4)

#### Time (Line 1631-1643)
```zsh
POWERLEVEL9K_TIME_FOREGROUND=66
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'                  # 24-hour format
POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false                # Show end time
POWERLEVEL9K_TIME_PREFIX='%fat '
```

---

## **4. Advanced Features**

### 4.1 Custom Segments (Line 1645-1675)

Example user-defined segment:
```zsh
function prompt_example() {
  p10k segment -f 208 -i '⭐' -t 'hello, %n'
}

function instant_prompt_example() {
  prompt_example
}

# Customization
# typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=208
# typeset -g POWERLEVEL9K_EXAMPLE_VISUAL_IDENTIFIER_EXPANSION='⭐'
```

### 4.2 System Behavior (Line 1677-1706)

#### Transient Prompt (Line 1677-1684)
```zsh
POWERLEVEL9K_TRANSIENT_PROMPT=off
```
- **off**: Keep full prompt after command
- **always**: Trim prompt after command
- **same-dir**: Trim unless first command in new directory

#### Instant Prompt (Line 1686-1696)
```zsh
POWERLEVEL9K_INSTANT_PROMPT=verbose
```
- **off**: Disable instant prompt
- **quiet**: Enable without warnings
- **verbose**: Enable with warnings

#### Hot Reload (Line 1698-1706)
```zsh
POWERLEVEL9K_DISABLE_HOT_RELOAD=true
```
- **true**: Disabled (better performance)
- **false**: Can change options on-the-fly

### 4.3 Configuration Management (Line 1704-1712)
```zsh
(( ! $+functions[p10k] )) || p10k reload
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}
(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
```

---

## **5. Color Reference**

### 5.1 Semantic Colors
| Color | Code | Usage |
|-------|------|-------|
| Green | 70, 76 | Success, clean state, charging |
| Red | 160, 196 | Error, conflicts, critical |
| Yellow | 178 | Warning, modified, discharging |
| Cyan | 31, 37, 38, 39 | Directories, info |
| Purple | 103, 129 | Shortened paths, Elixir |
| Orange | 134, 172, 208 | .NET, Haskell, warnings |
| Grey | 244 | Stale/incomplete state |

### 5.2 Language/Tool Colors
| Category | Color | Tools |
|----------|-------|-------|
| Python | 37 | pyenv, virtualenv, anaconda |
| Node.js | 70 | nvm, nodenv, nodeenv, node_version |
| Ruby | 168 | rbenv, rvm |
| Go | 37 | goenv, go_version |
| Rust | 37 | rust_version |
| Java | 32 | jenv, java_version |
| Shell Tools | 72 | nnn, lf, xplr |
| File Managers | 178 | ranger, yazi, mc |

---

## **6. Performance Optimization**

### 6.1 Instant Prompt
- **Enabled**: `POWERLEVEL9K_INSTANT_PROMPT=verbose`
- **Effect**: Shows cached prompt immediately while shell initializes

### 6.2 Disabled Features
```zsh
POWERLEVEL9K_DISABLE_HOT_RELOAD=true         # No runtime changes
POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1     # No index size limit
```

### 6.3 Conditional Display
Most segments use `SHOW_ON_COMMAND` to appear only when typing relevant commands:
- **kubectl** → Shows kubecontext
- **aws** → Shows AWS profile
- **gcloud** → Shows GCloud project
- **terraform** → Shows workspace

### 6.4 Project-Only Display
Version segments only show in relevant project directories:
```zsh
POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true
POWERLEVEL9K_GO_VERSION_PROJECT_ONLY=true
POWERLEVEL9K_RUST_VERSION_PROJECT_ONLY=true
```

---

## **7. Common Customizations**

### 7.1 Change Prompt Colors
```zsh
# Success prompt: green → blue
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=39

# Directory: cyan → purple
typeset -g POWERLEVEL9K_DIR_FOREGROUND=129
```

### 7.2 Add Custom Segment
```zsh
# 1. Define function
function prompt_mycustom() {
  p10k segment -f 196 -i '🔥' -t 'custom text'
}

# 2. Add to prompt elements
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # ... existing elements
  mycustom
)

# 3. Reload
p10k reload
```

### 7.3 Hide Specific Segments
```zsh
# Remove from PROMPT_ELEMENTS array
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status
  # command_execution_time   # <-- comment out or remove
  background_jobs
)
```

### 7.4 Always Show Context
```zsh
# Remove this line to always show user@hostname
# typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=
```

### 7.5 Shorten Git Status
```zsh
# Hide untracked files
# Comment out line 453
# (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
```

---

## **8. Troubleshooting**

### 8.1 Icons Not Displaying
**Problem**: Squares/boxes instead of icons
**Solution**: Install a Nerd Font
```bash
# Arch Linux
yay -S ttf-meslo-nerd-font-powerlevel10k

# Update terminal font to "MesloLGS NF"
```

### 8.2 Slow Prompt
**Problem**: Noticeable delay before prompt appears
**Solution**: Profile and optimize
```zsh
# 1. Check what's slow
p10k debug

# 2. Disable heavy segments
# Comment out in RIGHT_PROMPT_ELEMENTS:
# - kubecontext
# - gcloud
# - terraform
```

### 8.3 Git Status Not Showing
**Problem**: VCS segment empty in git repos
**Solution**: Check disabled patterns
```zsh
# Line 477 - Disabled for home directory
typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

# To show in home dir, change to empty pattern
typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN=''
```

### 8.4 Wrong Colors
**Problem**: Colors don't match documentation
**Solution**: Check terminal color support
```bash
# Verify 256 color support
echo $TERM  # Should be xterm-256color or similar

# Test colors
for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
```

---

## **9. Reconfiguration**

### 9.1 Run Configuration Wizard
```zsh
p10k configure
```
- Interactive wizard to regenerate config
- Safe: backs up existing config
- Recommended after major updates

### 9.2 Manual Reload
```zsh
source ~/.p10k.zsh
# or
p10k reload
```

### 9.3 Reset to Defaults
```bash
# Backup current config
cp ~/.p10k.zsh ~/.p10k.zsh.backup

# Delete config
rm ~/.p10k.zsh

# Restart shell - wizard will run automatically
exec zsh
```

---

## **10. Resources**

- **Official Docs**: https://github.com/romkatv/powerlevel10k
- **Configuration Wizard**: `p10k configure`
- **Show Config**: https://github.com/romkatv/powerlevel10k#show-on-command
- **Segment Reference**: `p10k help segment`
- **Icon Reference**: https://github.com/romkatv/powerlevel10k#fonts
- **Troubleshooting**: https://github.com/romkatv/powerlevel10k#troubleshooting

---

## **11. Quick Reference Card**

### Essential Commands
| Command | Purpose |
|---------|---------|
| `p10k configure` | Run configuration wizard |
| `p10k reload` | Reload configuration |
| `p10k segment -h` | Custom segment help |
| `p10k debug` | Performance debugging |

### Key Variables
| Variable | Purpose | Default |
|----------|---------|---------|
| `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` | Left segments | os_icon, dir, vcs, prompt_char |
| `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS` | Right segments | Many (see line 43) |
| `POWERLEVEL9K_INSTANT_PROMPT` | Instant prompt mode | verbose |
| `POWERLEVEL9K_TRANSIENT_PROMPT` | Trim after command | off |

### Common Patterns
```zsh
# Segment color
POWERLEVEL9K_<SEGMENT>_FOREGROUND=<color>

# Segment icon
POWERLEVEL9K_<SEGMENT>_VISUAL_IDENTIFIER_EXPANSION='icon'

# Segment content
POWERLEVEL9K_<SEGMENT>_CONTENT_EXPANSION='text'

# Show on command
POWERLEVEL9K_<SEGMENT>_SHOW_ON_COMMAND='cmd1|cmd2'

# Project only
POWERLEVEL9K_<SEGMENT>_PROJECT_ONLY=true
```
