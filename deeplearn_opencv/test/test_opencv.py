import logging

LOGGER = logging.getLogger(__name__)


def test_opencv(container):
    """Basic opencv test"""
    LOGGER.info("Test that opencv is correctly installed ...")
    command = '/opt/conda/envs/computer_vision/bin/python -c \
        "import cv2; \
        print(cv2.__version__)"'
    c = container.run(
        tty=True,
        command=["start.sh", "bash", "-c", command],
    )
    rv = c.wait(timeout=30)
    logs = c.logs(stdout=True).decode("utf-8")
    LOGGER.info(logs)
    assert '4.5' in logs
    #assert cmd.exit_code == 0, f"Command {command} failed {output}"
