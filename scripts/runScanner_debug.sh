#!/bin/sh
sudo pkill python
python /home/pi/scienceCentre/final/scanner/scanner.py --ip 127.0.0.1 --port 9000 --display
