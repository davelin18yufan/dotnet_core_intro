---
theme: seriph
title: 用現代 .NET 建立可控的後端工程系統
titleTemplate: '%s'
info: |
  90 分鐘教育訓練簡報，對象為熟悉 ASP.NET MVC / WebForms 的 .NET Framework 開發者。
aspectRatio: 16/9
drawings:
  enabled: true
transition: slide-left
mdc: true
colorSchema: light
fonts:
  sans: '"Segoe UI", "Microsoft JhengHei", sans-serif'
  serif: '"Georgia", "Times New Roman", serif'
  mono: '"Cascadia Code", "Consolas", monospace'
themeConfig:
  primary: '#14532d'
  secondary: '#1d4ed8'
  accent: '#b45309'
  background: '#f6f6ef'
  codeBackground: '#111827'
---

<style>
:root {
  --slidev-theme-primary: #14532d;
  --slidev-theme-secondary: #1d4ed8;
  --slidev-theme-accent: #b45309;
  --slidev-code-background: #111827;
}

.slidev-layout {
  background:
    radial-gradient(circle at top right, rgba(29, 78, 216, 0.10), transparent 32%),
    radial-gradient(circle at left bottom, rgba(20, 83, 45, 0.12), transparent 28%),
    linear-gradient(180deg, #fbfbf7 0%, #f1f2ea 100%);
}

h1, h2, h3 {
  letter-spacing: 0.01em;
}

.eyebrow {
  display: inline-block;
  margin-bottom: 0.8rem;
  padding: 0.25rem 0.7rem;
  border-radius: 999px;
  background: rgba(20, 83, 45, 0.12);
  color: #14532d;
  font-size: 0.82rem;
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.panel {
  padding: 1rem 1.2rem;
  border: 1px solid rgba(15, 23, 42, 0.08);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.82);
  box-shadow: 0 16px 50px rgba(15, 23, 42, 0.06);
}

.metric {
  font-size: 2rem;
  font-weight: 800;
  color: #14532d;
}

.soft-grid {
  display: grid;
  gap: 0.9rem;
}

.soft-grid.two {
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.soft-grid.three {
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.small {
  font-size: 0.92rem;
}

.muted {
  color: #475569;
}

.danger {
  color: #991b1b;
}

.good {
  color: #166534;
}

.accent {
  color: #b45309;
}

table {
  font-size: 0.9rem;
}

thead tr {
  background: rgba(20, 83, 45, 0.10);
}

tbody tr:nth-child(odd) {
  background: rgba(255, 255, 255, 0.7);
}
</style>

---
layout: cover
background: https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=1600&q=80
class: text-white
---

<div class="eyebrow !bg-white/20 !text-white !border !border-white/30">Slidev 教育訓練</div>

# 用現代 .NET 建立可控的後端工程系統

從 ASP.NET MVC / WebForms 的網站思維  
切換到現代 ASP.NET Core 的後端工程思維

<div class="pt-8 text-lg opacity-90">
主案例：<span class="font-bold">企業內部 API / Infrastructure / Core</span> 架構，地端自行部署
</div>

---
layout: two-cols-header
---

# 今天要回答的不是 API 細節，而是工程模型

::left::

<div class="panel">

### 舊 ASP.NET 世界

- IIS / `web.config` / Global.asax 是主舞台
- 網站專案常同時裝 UI、流程、資料存取、設定
- 很多關鍵流程靠人工點選與機器記憶

</div>

::right::

<div class="panel">

### 現代 ASP.NET Core 世界

- Host、Middleware、DI、Configuration 可程式化
- API / Core / Infrastructure 讓責任分層
- 發佈、Migration、設定、部署可以納入工程流程

</div>

---
layout: two-cols
---

# 舊世界的主要痛點

<div class="panel">

| 常見現象 | 真正的工程問題 |
| --- | --- |
| Controller 直接 new service / repository | 依賴隱藏，難測、難換 |
| SQL、商業規則、設定混在一起 | 修改牽一髮動全身 |
| DB 變更靠手動 SQL 或口頭通知 | 程式版與資料庫版脫鉤 |
| publish 後再改設定檔 | 環境不可重建，不可追蹤 |
| IIS 站台靠手動點選設定 | 部署知識綁在人，不綁在流程 |

</div>

<div class="pt-5 soft-grid three">
  <div class="panel"><div class="metric">高耦合</div><div class="small muted">一改就連鎖反應</div></div>
  <div class="panel"><div class="metric">低可測</div><div class="small muted">只能整站驗證</div></div>
  <div class="panel"><div class="metric">低可控</div><div class="small muted">環境與版本狀態不透明</div></div>
</div>

---
layout: statement
---

# 現代 .NET 先解掉的是工程控制點

把 <span class="accent font-bold">啟動、依賴、設定、資料庫版本、部署流程</span>  
都變成可以組裝、測試、追蹤的工程資產。

---
layout: two-cols-header
---

# 從網站思維轉成後端系統思維

::left::

<div class="panel">

### 舊 ASP.NET

- IIS 啟動網站
- `Global.asax` 接事件
- `web.config` 承擔大量設定
- 平台生命週期常像黑盒

</div>

::right::

<div class="panel">

### ASP.NET Core

- `Program.cs` 明確建立 Host
- Configuration 分層載入設定
- DI 與 Middleware 在啟動時組裝
- 啟動流程是程式碼，不是背景魔法

</div>

---
layout: two-cols
---

# Host / Middleware / DI / Configuration 各自做什麼

::left::

```mermaid
flowchart TD
    A[Host 建立應用程式] --> B[Configuration 載入設定來源]
    B --> C[DI Container 註冊服務]
    C --> D[Middleware 組成 Request Pipeline]
    D --> E[Endpoints / Controllers]
```

::right::

<div class="panel small">

- **Host**：決定怎麼啟動、停止、掛 logging
- **Configuration**：整合檔案、祕密、環境變數
- **DI**：宣告依賴關係，避免自行到處找東西
- **Middleware**：把 HTTP 流程拆成可插拔的段落

</div>

---
layout: two-cols-header
---

# 最小範例：啟動流程長什麼樣

::left::

<<< @/snippets/program.cs {cs}{maxHeight:'400px'}

::right::

<div class="panel small">

<v-clicks>

- 新同事讀 `Program.cs` 就能理解系統怎麼組起來
- 驗證、授權、例外處理不再散在各角落
- 啟動流程越透明，維護與交接成本越低

</v-clicks>

</div>

---
layout: two-cols
---

# API / Infrastructure / Core：三層不是為了漂亮

::left::

```mermaid
flowchart LR
    Client[Client / Batch / Other System] --> API[API]
    API --> Core[Core]
    Core -->|透過介面| Infra[Infrastructure]
    Infra --> DB[(SQL Server)]
    Infra --> Ext[Mail / Queue / File / ERP]
```

::right::

<div class="panel small">

- **API**：HTTP 入口、DTO、授權、組裝
- **Core**：用例、商業規則、流程、抽象介面
- **Infrastructure**：EF Core、外部服務、資料庫、設定實作

</div>

---
layout: two-cols-header
---

# 舊 vs 新：功能到底寫在哪裡

::left::

<div class="panel small">

### 舊做法

- Controller 直接寫流程
- Controller 直接碰 EF / SQL
- 寄信、檔案、設定都在同一層呼叫
- 需求一變，整條 HTTP 端一起改

</div>

::right::

<div class="panel small">

### 新模型

- API 接住 HTTP 世界
- Core 定義用例與規則
- Infrastructure 提供技術細節
- 變的是實作，不是整個系統骨架

</div>

---
layout: two-cols
---

# 最小範例：DI 與用例註冊

::left::

<<< @/snippets/dependency-registration.cs {cs}{maxHeight:'390px'}

::right::

<div class="panel small">

### 為什麼這樣切比較能維護

- API 只依賴 Core 的能力
- Infrastructure 在啟動時被接上去
- 單元測試可以替換掉實作
- 改 DB 或外部服務，不必重寫 use case

</div>

---
layout: two-cols
---

# ORM / EF Core 先解的是哪些舊痛點

::left::

<div class="panel small">

### 傳統手寫 ADO.NET / SQL

- mapping 樣板碼很多
- connection / transaction 管理零散
- 查詢散在各層，重用差
- schema 改了，程式不一定同步

</div>

::right::

<div class="panel small">

### EF Core 的改善

- `DbContext` 集中資料存取
- query 與模型可以工程化治理
- migration 可描述 schema 版本
- 交易、攔截器、追蹤策略比較可控

</div>

---
layout: two-cols-header
---

# Migration 不是建表工具，而是版本治理工具

::left::

```mermaid
flowchart LR
    A[程式碼變更] --> B[新增 Migration]
    B --> C[提交到版本控制]
    C --> D[部署流程執行資料庫更新]
    D --> E[程式版本與 DB 版本對齊]
```

::right::

<div class="panel small">

- DB 變更有歷史可追
- 新環境可重建
- 環境差異比較容易被發現
- 部署流程能驗證程式對應的 schema

</div>

---
layout: two-cols
---

# 最小範例：DbContext 與 Migration 指令

::left::

<<< @/snippets/db-context.cs {cs}{maxHeight:'360px'}

::right::

<<< @/snippets/migration-commands.ps1 {powershell}{maxHeight:'360px'}

---
layout: two-cols-header
---

# 設定治理：設定不是值而已，是系統邊界

::left::

<<< @/snippets/appsettings.json {json}{maxHeight:'380px'}

::right::

<div class="panel small">

### 設定來源的基本順序

1. `appsettings.json`
2. `appsettings.{Environment}.json`
3. User Secrets（開發機）
4. Environment Variables
5. 命令列參數

</div>

---
layout: two-cols
---

# 哪些值該放檔案，哪些不該

::left::

<div class="panel small">

### 可以進 repo

- 非敏感預設值
- Feature flags 預設狀態
- Logging level
- Timeout、批次大小等運行參數

</div>

::right::

<div class="panel small">

### 不該直接進 repo

- 密碼、token、連線字串祕密段
- 憑證與私鑰
- 第三方 API secrets
- 長期固定的高權限共用帳密

</div>

---
layout: two-cols-header
---

# 最小範例：環境變數如何覆寫設定

::left::

<<< @/snippets/environment-override.ps1 {powershell}{maxHeight:'360px'}

::right::

<div class="panel small">

### 核心原則

- 階層式 key 用 `__`
- 同一套程式可在不同機器注入不同值
- publish 包不需要內建正式環境祕密
- 環境切換靠外部注入，不靠改程式碼

</div>

---
layout: two-cols
---

# 從開發到地端部署：設定鏈路要打通

::left::

```mermaid
flowchart TD
    A[本機開發] -->|User Secrets| B[測試機 / 驗證環境]
    B -->|環境變數或部署工具注入| C[地端正式機]
    C --> D[服務啟動時讀取設定]
```

::right::

<div class="panel small">

### 使用、儲存、保護要一起談

- 本機：每位開發者保有自己的敏感設定
- 部署：由機器、服務或流程注入
- 保護：最小暴露、分環境隔離、權限限制、可輪替

</div>

---
layout: statement
---

# 真正危險的不是「有沒有用環境變數」

而是 <span class="danger font-bold">裡面裝了什麼、誰能看、誰能改、怎麼輪替</span>。  
現代化不是把密碼從檔案搬家，而是建立治理方式。

---
layout: two-cols-header
---

# 地端自部署也可以很現代

::left::

<div class="panel small">

### 手動 IIS 點選式部署

- 站台設定散落在視窗
- 同一專案在不同機器做法不同
- 發生故障難以比對差異
- 人工步驟越多，錯誤率越高

</div>

::right::

<div class="panel small">

### 標準化部署模型

- 產物固定
- 設定外部化
- DB 更新是顯性步驟
- 啟動參數明確
- 可重複、可追蹤、可交接

</div>

---
layout: two-cols
---

# 地端自部署的基本流程

::left::

```mermaid
flowchart LR
    A[CI Build] --> B[產出 publish artifact]
    B --> C[複製到目標機]
    C --> D[注入環境設定]
    D --> E[執行 Migration / 檢查]
    E --> F[啟動或切換服務]
    F --> G[健康檢查與回報]
```

::right::

<div class="panel small">

- 一開始可以只是 PowerShell + 目錄慣例
- 關鍵不是工具名稱，而是流程標準化
- 地端部署也應該把設定、版本、啟動方式文件化

</div>

---
layout: two-cols-header
---

# 最小範例：部署腳本與外部化設定

::left::

<<< @/snippets/deploy.ps1 {powershell}{maxHeight:'365px'}

::right::

<div class="panel small">

- artifact 應與環境解耦
- 部署時才決定正式環境連線與祕密
- DB 更新要在流程中明確出現
- 啟動與回滾至少要有明確操作邊界

</div>

---
layout: two-cols
---

# 新專案一開始就該建立的工程基線

::left::

<div class="panel small">

### 專案骨架

- API / Core / Infrastructure 分層
- `Program.cs` 統一組裝
- Options / Configuration 綁定規則
- 統一 logging、例外處理、health checks

</div>

::right::

<div class="panel small">

### 工程流程

- Migration 進版控
- 本機敏感值不進 repo
- 發佈產物與環境設定分離
- 至少有 build、test、deploy 基本腳本
- 文件寫清楚啟動與部署方式

</div>

---
layout: two-cols
---

# 今天要帶走的核心訊息

::left::

<div class="panel">

1. 現代 .NET 的價值在工程控制點  
2. API / Core / Infrastructure 是責任分離  
3. EF Core + Migration 是資料庫版本治理  
4. 設定與祕密治理是系統邊界的一部分  
5. 地端自部署一樣可以流程化、可控化

</div>

::right::

<div class="panel">

### 下一步建議

- 下個新專案直接用三層骨架
- 先補齊設定與祕密管理規範
- 把 Migration 納入日常流程
- 用腳本取代手動部署知識

</div>

---
layout: end
---

# Q&A

從「網站能跑」走到「系統可控」  
就是現代後端工程的起點
