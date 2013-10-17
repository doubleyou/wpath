#!/bin/sh

grep '^.....$' $1 | tr -d '\n' > $2
