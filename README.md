# Raspberry PI QL700 driver Docker Container

## Purpose
This project provides a suitable runtime environment for the Brother QL-700 label printer. Brother provide CUPS drivers for the printer however, I've not been able to get these to work successfully, even in a Raspian Jessie container.

I then found a project by [DesignSpark](https://www.rs-online.com/designspark/building-a-pi-powered-wireless-label-printer) that uses a Python API to drive the label maker so I built up an environment suitable for running that.

## Build
In this repo, the CUPS solution is provided for reference but, as mentioned, it is not actually functional. The drivers just don't appear to work properly. 

To build the Python version:
```
cd ql700-python-works
docker build --rm -t pits/ql700:0.0.1 -f Dockerfile .
```

## Run
You can run the container using Docker-Compose with:
```
docker-compose -f ql700.compose up -d
```

## Print
### Command line
Enter the Docker container with:
```
docker exec -it ql700 /bin/bash
```
Convert your image to a PostScript file:
```
/ql700/venv/bin/brother_ql_create --model QL-700 <image filename> --label-size <label width in mm> > <postscript filename>
```
Once generated, you can then print it with:
```
/ql700/venv/bin/brother_ql_print <postscript filename> /dev/usb/lp0
```

### Web Form
You can access the web form and print from there on:
```
http://<Raspberry PI IP Address>/
```
