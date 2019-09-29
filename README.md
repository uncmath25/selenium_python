# Dockerized Selenium Python Environment

### Description:
This project provides a dockerized Selenium python environment

### Usage:
1. Update the sample **script.py** with your desired python script for Selenium
2. Execute `make run` to run the python script in the dockerized Selenium environment
3. *Download or export any desired resources to `./output`
4. *Check for browser errors in **log.txt**

### Details
This repo is quite primitive: atm it's simply a MVP for running Selenium with the python API in a dockerized environment.
Such functionality seems useful, as much of the consternation caused by Selenium stems from reconciling selenium, browser, driver and os version conflicts.
Currently the only supported drivers are Firefox, but additional drivers can be easily added if so desired, by updating the Dockerfile.
The main accomplishment so far was building a working a Dockerfile which possesses the appropriate gtk configurations to run a headless browser for Selenium.
Note that the entrypoint script **entrypoint.sh** can be easily augmented to facilitate any tesing or web interfacing needs.
I decided to comment out the image downloading logic in the example script because the google images search page DOM seemed inconsistent.
But that specific example is beside the point of the repo; the logic can also still be helpful for referencing how to download an image in python.

### Local Usage
In order to test your Selenium python interactively with the browser present in your GUI, the Makefile also has commands for setting up the browser resources for local native os usage.  Build the resource with `make installlocal` and then run your script interactively with `runlocal` for testing purposes.
