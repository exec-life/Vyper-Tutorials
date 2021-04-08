# Vyper Development

## Getting Started

Vyper can be downloaded as a docker image from dockerhub:
```
docker pull vyperlang/vyper
```
To run the compiler use the docker run command:
```
docker run -v $(pwd):/code vyperlang/vyper /code/<contract_file.vy>
```
Alternatively you can log into the docker image and execute vyper on the prompt.
```
docker run -v $(pwd):/code/ -it --entrypoint /bin/bash vyperlang/vyper
root@d35252d1fb1b:/code# vyper <contract_file.vy>
```
The normal paramaters are also supported, for example:
```
docker run -v $(pwd):/code vyperlang/vyper -f abi /code/<contract_file.vy>
[{'name': 'test1', 'outputs': [], 'inputs': [{'type': 'uint256', 'name': 'a'}, {'type': 'bytes', 'name': 'b'}], 'constant': False, 'payable': False, 'type': 'function', 'gas': 441}, {'name': 'test2', 'outputs': [], 'inputs': [{'type': 'uint256', 'name': 'a'}], 'constant': False, 'payable': False, 'type': 'function', 'gas': 316}]
```