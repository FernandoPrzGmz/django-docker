```bash
docker build . -t django-docker
```


```bash
docker run -t -i \
    --name django-docker \
    django-docker /bin/bash
```