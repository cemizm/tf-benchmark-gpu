FROM tensorflow/tensorflow:latest-gpu

RUN apt-get update && apt-get install -y --no-install-recommends \
	git

RUN git clone https://github.com/tensorflow/benchmarks.git

ENV TF_FORCE_GPU_ALLOW_GROWTH true
ENV TF_CPP_MIN_LOG_LEVEL 2
ENV PYTHONUNBUFFERED 1

WORKDIR /benchmarks/scripts/tf_cnn_benchmarks

ENTRYPOINT ["python", "tf_cnn_benchmarks.py"]
