import logging
import docker

LOGGER = logging.getLogger(__name__)

def test_mxnet_version(container):
    """Basic Mxnet Test"""
    LOGGER.info("Test that Mxnet is correctly installed ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import mxnet as mx; \
        print(mx.__version__)"'
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
    assert '1.9.0' in logs
    #assert cmd.exit_code == 0, f"Command {command} failed {output}"


def test_mxnet_gpu(container):
    """Basic Mxnet GPU"""
    LOGGER.info("Test that Mxnet GPU is correctly installed ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import mxnet as mx; \
        print(mx.context.num_gpus())"'
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
    assert '2' in logs