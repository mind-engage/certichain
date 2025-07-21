# CertiChain – Developer Guide

> **Audience:** Engineers who wish to clone, build, test, and extend CertiChain.
> **Last updated:** <!-- KEEP THIS LINE FOR CI AUTO-STAMP -->

---

## 1  Prerequisites

| Tool / Service                        | Version               | Notes                             |
| ------------------------------------- | --------------------- | --------------------------------- |
| **Node.js**                           | ≥ 20.x                | Use `nvm install 20`              |
| **Yarn**                              | ≥ 1.22                | `npm i -g yarn`                   |
| **Hardhat**                           | auto‑installed        | via devDeps                       |
| **Foundry** (optional)                | latest                | Faster Solidity tests             |
| **Docker & Docker‑compose**           | latest                | For IPFS cluster & oracle         |
| **Polygon RPC**                       | Amoy testnet endpoint | Get free tier from Alchemy/Infura |
| **Metamask** or other EIP‑1193 wallet | —                     | For local & test interactions     |

Create a `.env` at repo root:

```bash
# RPC
AMOY_RPC="https://polygon-amoy.g.alchemy.com/v2/<key>"
PRIVATE_KEY="0x<your dev key>"
POLYGONSCAN_KEY="<polygonscan api>"
```

---

## 2  Project Bootstrap

1. **Clone & install**

   ```bash
   git clone https://github.com/your‑org/certichain.git && cd certichain
   yarn install       # installs root + front‑end workspaces
   ```

2. **Compile contracts**

   ```bash
   yarn hardhat compile
   ```

3. **Run tests**

   ```bash
   yarn hardhat test            # mocha + chai
   # OR use Foundry
   forge test -vv
   ```

4. **Spin up local stack** (Hardhat + IPFS + Oracle):

   ```bash
   docker compose up -d ipfs1 ipfs2 ipfs3
   yarn hardhat node &          # localhost:8545, chain‑id 31337
   yarn oracle                  # ts-node src/oracle.ts
   ```

   The `oracle` script watches `ExamTaken` events and writes results.

5. **Deploy to local**

   ```bash
   yarn deploy                  # runs scripts/deploy.ts to localhost
   ```

6. **Run front‑end**

   ```bash
   cd frontend
   yarn dev                     # http://localhost:3000
   ```

   Connect your wallet to `http://127.0.0.1:8545` network.

---

## 3  Deploying to Amoy Testnet

```bash
yarn deploy:amoy      # wrapper for `hardhat run --network amoy ...`
```

Outputs contract addresses; copy them to:

```env
NEXT_PUBLIC_REGISTRY=0x...
NEXT_PUBLIC_NFT=0x...
```

Front‑end will pick them up automatically.

Verify on Polygonscan:

```bash
yarn hardhat verify --network amoy <addr> "constructor args…"
```

---

## 4  Directory Conventions

| Path         | Purpose                                                 |
| ------------ | ------------------------------------------------------- |
| `contracts/` | Solidity sources (keep ≤ 500 SLoC per file)             |
| `scripts/`   | Hardhat deployment & admin scripts                      |
| `frontend/`  | Next.js 14 app (app router disabled for CSR simplicity) |
| `oracle/`    | Off‑chain TypeScript grading oracle                     |
| `docker/`    | Dockerfiles for oracle, verifier, IPFS cluster          |
| `documents/` | Design docs, guides, specs (Markdown)                   |

---

## 5  Coding Standards

* **Solidity**: v0.8.25, OZ Contracts v5, 4‑space indents, no tabs.
* **TypeScript**: Strict mode, ESLint AirBnB + Prettier.
* **Commits**: Conventional Commits (`feat:`, `fix:`, `docs:`…).
* **Branches**: `main` → protected; feature branches `feat/<ticket>`.
* **PR Checks**: Hardhat tests, `yarn lint`, 95 % coverage.

---

## 6  Adding a New Exam Flow (End‑to‑End)

1. **Write exam JSON** and upload encrypted ZIP to IPFS:

   ```bash
   yarn ipfs:add path/to/questions.zip  # returns CID
   ```
2. **Create exam** via Hardhat task or front‑end (educator wallet):

   ```bash
   yarn hardhat createExam --cid <CID> --pass 70 --fee 0
   ```
3. **Student registers** with Polygon ID ZK proof (front‑end does this automatically).
4. **Student submits answers**; oracle grades and calls `submitScore`.
5. **NFT Credential auto‑mints** to student wallet.

---

## 7  Running the Verifier API Locally

```bash
cd verifier
docker build -t certichain‑verifier .
docker run -p 8080:8080 certichain‑verifier
```

POST `{ "url": "ipfs://…" }` → `{ "valid": true }`.

---

## 8  Releasing to Production

1. Prepare release branch `release/vX.Y.Z`.
2. Bump versions in `package.json` (root & frontend) and `contracts/` tag.
3. Deploy contracts to Polygon PoS **AND** zkEVM; record addresses in `frontend/.env.production`.
4. `docker compose build --push` images → AWS EKS / GKE.
5. GitHub Release notes auto‑generated via `yarn release`.

---

## 9  Troubleshooting

| Symptom                                         | Fix                                                                |
| ----------------------------------------------- | ------------------------------------------------------------------ |
| `ProviderError: gas required exceeds allowance` | Fund deployer with more MATIC or lower gas limit in Hardhat config |
| ZK proof fails on‑chain                         | Confirm circuit hash matches registry; clear wallet cache          |
| NFT not visible in wallet                       | Make sure student wallet added Polygon testnet chain ID 80002      |

---

## 10  Useful Scripts

```bash
# List exams
yarn hardhat run scripts/listExams.ts --network amoy

# Grant oracle role to new address
yarn hardhat grantOracle --oracle 0x123...

# Re‑pin all credential JWTs locally
yarn pin:all
```

---

### Need help?

Open a discussion in **GitHub › Discussions** or ping `@dev‑rel` on the project Discord. Happy building! ⚡️
