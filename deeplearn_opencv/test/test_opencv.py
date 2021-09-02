import logging
import docker
import os

LOGGER = logging.getLogger(__name__)


def test_opencv(container):
    """Basic opencv test"""
    LOGGER.info("Test that opencv is correctly installed ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import cv2; \
        print(cv2.__version__)"'
    #curr_path = os.getcwd()
    #full_path = os.path.join(curr_path, "deeplearn_opencv/test")
    #mount_path = docker.types.Mount(source=full_path, target="/opt/test")
    c = container.run(
        tty=True,
        command=["start.sh", "bash", "-c", command],
        volumes = {os.getcwd(): {'bind': '/tmp/', 'mode': 'rw'}}
    )
    rv = c.wait(timeout=30)
    logs = c.logs(stdout=True).decode("utf-8")
    LOGGER.info(logs)
    assert '4.5' in logs
    #assert cmd.exit_code == 0, f"Command {command} failed {output}"


def test_opencv_gpu(container):
    """Basic opencv gpu integration test"""
    LOGGER.info("Test that opencv is integrated with gpu ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import cv2; \
        count = cv2.cuda.getCudaEnabledDeviceCount(); \
        print(\'yes\' if count > 0 else \'no\')"'
    #curr_path = os.getcwd()
    #full_path = os.path.join(curr_path, "deeplearn_opencv/test")
    #mount_path = docker.types.Mount(source=full_path, target="/opt/test")
    c = container.run(
        tty=True,
        command=["start.sh", "bash", "-c", command],
        volumes = {os.getcwd(): {'bind': '/tmp/', 'mode': 'rw'}},
        device_requests=[
            docker.types.DeviceRequest(count=-1, capabilities=[['gpu']])
        ]
    )
    rv = c.wait(timeout=30)
    logs = c.logs(stdout=True).decode("utf-8")
    LOGGER.info(logs)
    assert 'yes' in logs 
    
