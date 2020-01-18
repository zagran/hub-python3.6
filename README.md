# python3.6

# Install project pip requirements
```dockerfile
ADD requirements/base.txt /app/
RUN cd /app \
  && pip install -U -r base.txt
```