import docker 
client = docker.from_env() 

for container in client.containers.list(): 
    image = container.attrs['Config']['Image']
    if 'topograph-crawler' in image: 
        logs = container.logs(until=1800)
        if not logs:
            print(image)
            container.restart()
