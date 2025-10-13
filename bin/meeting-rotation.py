#!/usr/bin/env python3
"""
Meeting rotation for priorities doc

./bin/meeting-rotation | pbcopy
"""
import random

names = [
    "Kim",
    "James",
    "Jennifer",
    "John",
    "Jover",
    "Thomas",
    "Trevor",
    "Victor",
]

random.shuffle(names)

for name in names:
    print(name)
