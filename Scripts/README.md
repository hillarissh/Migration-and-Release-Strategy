# Generate a REGISTRATION TOKEN 
  curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer github_pat_REDACTED" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/OrgName/RepoName/actions/runners/registration-token	  
  
# Docker commands  
docker build -t rg_RepoName:latest .
docker tag rg_RepoName:latest ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/rg_RepoName:latest
aws ecr get-login-password --region REGION | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/rg_RepoName:latest
docker push ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/rg_RepoName:latest

docker-compose up -d
docker images
docker images 
