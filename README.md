# TFS-TASK
Various Task to be used with Team Foundation Server.

These task provide user gui for TFS task.


https://docs.microsoft.com/en-us/azure/devops/extend/develop/integrate-build-task?view=azure-devops

### Install tools

```
npm install -g tfx-cli
```
*restore VSCode to get tfx to work*

# Setup Typescript
```
tsc --init
```

# Build
```
cd .\setFolderPermissions-task\
tfx extension create --manifest-globs vss-extension.json
```
```
cd .\websiteBinding-task\
tfx extension create --manifest-globs vss-extension.json
```