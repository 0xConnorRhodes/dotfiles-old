#!/bin/bash
cd /etc
read -p "commit message: " COMMIT
git add .

# these will get pushed with nightly autocommit
#git commit -m "$COMMIT"
#git push
