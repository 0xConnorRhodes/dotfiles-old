#!/bin/bash
cd /etc
read -p "commit message: " COMMIT
git add .
git commit -m "$COMMIT"
