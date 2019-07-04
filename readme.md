# Dockerized tensorflow benchmark tool with GPU support
This Docker image is based on the latest [tensorflow/tensorflow](https://hub.docker.com/r/tensorflow/tensorflow) image with python and gpu support. The [tensorflow/benchmarks](https://github.com/tensorflow/benchmarks) repository is cloned and used as an entrypoint for the container. This allows some image classification models to be executed within the container with GPUs by passing the corresponding arguments to the `docker run` command.

For further informations please refer to official [TensorFlow Guide](https://www.tensorflow.org/guide/performance/benchmarks).

## Run benchmarks
To run ResNet50 with synthetic data and a single GPU use:
```bash
docker run --runtime=nvidia --rm cemizm/tf-benchmark-gpu --model resnet50 --num_gpus=1
```

Frequently used flags:
* **model** to use for benchmarks. Examples: alexnet, resnet50, resnet152, inception3, vgg16. default: trivial
* **num_gpus** number of gpus to use. default: all available gpus
* **variable_update** method for managing variables: parameter_server, replicated, distributed_replicated, independent. default: parameter_server
* **batch_size** for each GPU. default: 32


For a list of all available flags use:
```bash
docker run --runtime=nvidia --rm cemizm/tf-benchmark-gpu --help
```

## Results
Official TensorFlow results for P100 and K80 can be found in the TensorFlow Guide linked above. Here are some results from consumer hardware for workstation environments.

### RTX 2070

| Setting     | Value                     |
|-------------|---------------------------|
| TensorFlow  | 1.14                      |
| Dataset     | imagenet (synthetic)      |
| Mode        | training                  |
| SingleSess  | False                     |
| Batch size  | 64 global / 64 per device |
| Num batches | 100                       |
| Num epochs  | 0.00                      |
| NUMA bind   | False                     |
| Data format | NCHW                      |
| Optimizer   | sgd                       |
| Variables   | parameter_server          |

| GPUs | InceptionV3 | ResNet-50 | ResNet-152 | AlexNet | VGG16 |
|------|-------------|-----------|------------|---------|-------|
| 1    | 122         | 196       | 76         | 2371    | 112   |
| 2    |             |           |            |         |       |
| 4    |             |           |            |         |       |
| 8    |             |           |            |         |       |
