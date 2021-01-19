import docker 
client = docker.from_env() 

for container in client.containers.list(): 
    image = container.attrs['Config']['Image']
    if 'topograph-cicd' in image: 
        logs = container.logs(until=1800)
        if logs:
            container.restart()
            print("happy")
