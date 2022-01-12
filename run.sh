#!/bin/bash
 
collection=/newman/collection.postman_collection.json
env=/newman/environment.postman_environment.json
data=/newman/data.csv

newman run $collection -e $env -d $data