"""Tests to ensure proper file type detection."""

import os
import unittest
import pytest

from analyze.detection import PatternFlags, PatternDetection

# from runner.cli import GitHubRunner

PAYLOAD_FILE_PATH = os.environ.get("PAYLOAD_PATH", "payload.json")
CATEGORY_FILE_PATH = os.environ.get("CATEGORY_PATH", "configs/categories.yml")
FLAGS_FILE_PATH = os.environ.get("FLAGS_PATH", "configs/flags.yml")

# my_cloudformation = """ VPC:
#     Description: Select VPC.
#     Type: AWS::EC2::VPC::Id """
