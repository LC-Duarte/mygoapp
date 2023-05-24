#!/bin/bash
# create swagger docs $swag init  --output internal/docs --generalInfo cmd/mygoapp/main.go


TAG="leocd123/mygoapp:v0.1"

#No options provided
if [ $# -eq 0 ]
then
    echo "Running docker build"
    docker build . --label sportStoreBackend -t $TAG
    exit 0
fi
LOCAL="true" #Set To true for convinece. #replace to false before pushing
while getopts "hlr" OPTION; do
        case $OPTION in
                #local build
                l)
                    echo "Runing local build"
                    LOCAL="true"
                    mkdir -p bin #Ensure bin dir exists
                    go build -o bin/mygoapp cmd/mygoapp/main.go
                    ;;

                h)
                    echo " `basename $0`     #Build docker image"
                    echo " `basename $0` -r  #Build and  docker image "
                    echo " `basename $0` -l  #copile with go without docker image"
                    echo " `basename $0` -lr #copile with go without docker image and run "
                    exit 0
                    ;;
                #run server    
                r)
                    if [ $LOCAL = "true" ];then
                        echo "Starting server locally at port 8080"
                        bin/mygoapp
                    elif [ $LOCAL = "false" ];then
                        echo "Running docker build"
                        docker build . --label sportStoreBackend -t $TAG
                        echo "Starting server on docker container using local port 8080"
                        docker run -p 8080:8080 $TAG
                    fi
                    ;;
        esac
done
  
