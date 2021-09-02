import logging
import docker

LOGGER = logging.getLogger(__name__)


def test_tf_version(container):
    """Basic Tensorflow Test"""
    LOGGER.info("Test that Tensorflow is correctly installed ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import tensorflow as tf; \
        print(tf.__version__)"'
    c = container.run(
        tty=True,
        command=["start.sh", "bash", "-c", command],
        device_requests=[
            docker.types.DeviceRequest(count=-1, capabilities=[['gpu']])
        ]
    )
    rv = c.wait(timeout=30)
    logs = c.logs(stdout=True).decode("utf-8")
    LOGGER.info(logs)
    assert '2.' in logs


def test_tf_gpu_version(container):
    """Basic Tensorflow GPU usage Test"""
    LOGGER.info("Test that Tensorflow GPU is correctly installed ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import tensorflow as tf; \
        gpu_available = tf.test.is_gpu_available(); \
        print(gpu_available)"'
    c = container.run(
        tty=True,
        command=["start.sh", "bash", "-c", command],
        device_requests=[
            docker.types.DeviceRequest(count=-1, capabilities=[['gpu']])
        ]
    )
    rv = c.wait(timeout=30)
    logs = c.logs(stdout=True).decode("utf-8")
    LOGGER.info(logs)
    assert 'True' in logs