#!/bin/bash
# checking if home files drive and camera drive are attached
var=$(sudo blkid | grep -E "8E78-108C|58440497163AEEB1" | wc -l)
# need if statement to check if var greater than 2
