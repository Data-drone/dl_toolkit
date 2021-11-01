import logging
import docker

LOGGER = logging.getLogger(__name__)


def test_pytorch_version(container):
    """Basic Pytorch Test"""
    LOGGER.info("Test that Pytorch is correctly installed ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import torch; \
        print(torch.__version__)"'
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
    assert '1.10' in logs
    #assert cmd.exit_code == 0, f"Command {command} failed {output}"


def test_pytorch_gpu(container):
    """Basic Pytorch GPU"""
    LOGGER.info("Test that Pytorch GPU is correctly installed ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import torch; \
        print(torch.cuda.is_available())"'
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
