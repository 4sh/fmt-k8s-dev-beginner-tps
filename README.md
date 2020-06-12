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

## apply the kubernetes config

```
cat k8s/*.yaml | sed s/@ME/$ME/g | kubectl apply -f -
```

## check after a minute:

```
open https://4sh-formation-$ME.learning.quatre.app
```
