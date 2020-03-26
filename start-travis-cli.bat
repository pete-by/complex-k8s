@echo off
REM This batch file is used to run Travis CLI in a container and execute commands to encrypt private key for a service account of Google Cloud
REM Requires admin privileges
REM Then run:
REM gem install travis --no-document
REM travis login
REM copy secret file to current directory
REM travis encrypt-file service-account-key.json -r pete-by/complex-k8s
REM add the openssl line to .travis.yml
docker run -it -v "%cd%":/app ruby:2.3 sh