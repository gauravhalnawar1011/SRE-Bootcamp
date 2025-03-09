# tests/test_cases.py

import pytest
from app import my_function  # Example import for testing

def test_addition():
    result = my_function(2, 3)
    assert result == 5

def test_subtraction():
    result = my_function(5, 3)
    assert result == 2
