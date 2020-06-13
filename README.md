# K8s training

## Env

replace xxx with your trigram in lowercase, eg xhn 
`export ME=xxx`

## Publish your docker images

in `ui`

build:
```
docker build -t europe-west9-docker.pkg.dev/qsh-learning/qsh-learning-docker-registry/myapp-ui-$ME .
```

in `srv`

build:
```
./gradlew build
docker build -t europe-west9-docker.pkg.dev/qsh-learning/qsh-learning-docker-registry/myapp-srv-$ME .
```

push:
```
docker push europe-west9-docker.pkg.dev/qsh-learning/qsh-learning-docker-registry/myapp-ui-$ME
docker push europe-west9-docker.pkg.dev/qsh-learning/qsh-learning-docker-registry/myapp-srv-$ME
```

## define your kustomize config

copy env template:
```
cd k8s
cp -R environments/tpl environments/$ME 
```

modify by replacing all @ME by your own trigram

## apply the kubernetes config

in `k8s`:
```
kustomize build environments/$ME | k apply -f -
```

## check with logs

```
kubectl logs -f -l app=app-srv --all-containers=true
```
