.PHONY: clean setup build run installlocal runlocal

SHELL := /bin/bash
IMAGE_NAME := uncmath25/selenium-python
IMAGE_HOME_DIR := /home/uncmath25

clean:
	@echo "*** Cleaning the repo ***"
	rm -rf log.txt
	rm -rf output

setup:
	@echo "*** Cleaning the repo ***"
	touch log.txt
	mkdir output

build: clean
	@echo "*** Building the docker images ***"
	docker build -t $(IMAGE_NAME) .

run: build setup
	@echo "*** Running Selenium python environment ***"
	docker run --rm \
		-v "$$(pwd)/script.py:$(IMAGE_HOME_DIR)/script.py" \
		-v "$$(pwd)/log.txt:$(IMAGE_HOME_DIR)/log.txt" \
		-v "$$(pwd)/output:$(IMAGE_HOME_DIR)/output" \
		$(IMAGE_NAME)

installlocal:
	@echo "*** Building local selenium environment ***"
	rm -f geckodriver
	rm -rf firefox
	wget https://github.com/mozilla/geckodriver/releases/download/v0.25.0/geckodriver-v0.25.0-linux64.tar.gz -O geckodriver.tar.gz \
		&& tar -xzvf geckodriver.tar.gz \
		&& rm geckodriver.tar.gz
	wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/69.0.1/linux-x86_64/en-US/firefox-69.0.1.tar.bz2 -O firefox.tar.bz2 \
		&& tar -xjvf firefox.tar.bz2 \
		&& rm firefox.tar.bz2
	pip3 install selenium==3.141.0

runlocal: clean setup
	@echo "*** Running Selenium python script interactively ***"
	python3 -i script.py
