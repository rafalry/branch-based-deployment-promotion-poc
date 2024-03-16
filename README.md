# Branch-based deployment promotion POC

Deployment promotion is a process which guards executing the deployments of a particular software version to subsequent environments (e.g. test -> staging -> production).

This example presents two-stage deployment process based on separate branches with the scheme as follows:

| branch name  | environment |
|--------------|-------------|
| `master`     | development |
| `production` | production  |

## Pros & cons

### Pros
- minimal work required to adapt to the current developer flow (discontinue `development` branch, introduce new step for production deployment)
- minimal work required to adapt to the current GitHub workflows (change trigger from `master` to `production` branch for production workflows)
- plays well with GitHub UI for deployment management
- possibility to define subset of users with production deployment permissions
- easy to extend with additional deployment logic (e.g. auto-deployment once per day)

### Cons
- no support for advanced release management (when someone is reviewing release notes and deciding whether to deploy to production)
- no support for release management based on artifact versioning (artifact versioning itself can still be applied)

## How it works

1. Developer merges a feature to the `master` branch
2. GitHub action deploys to development environment and offers to trigger production deployment
   ![step2.png](docs%2Fstep2.png)
3. Developer with proper permissions triggers production deployment
   ![step3.png](docs%2Fstep3.png)
4. GitHub action deploys to production environment
   ![step4.png](docs%2Fstep4.png)

## Try this out

1. Clone the repo
2. Run `./update.sh`
3. Go to [Actions page](https://github.com/swan-bitcoin/poc-release-branch-based/actions) and approve deployment for the new commit
4. Check out new [Production deployment workflow run](https://github.com/swan-bitcoin/poc-release-branch-based/actions/workflows/production.yaml)

## Implementation details

- `production` branch is protected in such a way that only GitHub action can push to it and linear history is required
- `production` branch is always linearly behind the `master` branch, commit histories do not diverge
![impl1.png](docs%2Fimpl1.png)