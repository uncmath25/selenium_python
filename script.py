import argparse
# from base64 import b64decode
import os
from selenium import webdriver
import time


def build_firefox_browser(headless):
    FIREFOX_PATH = os.path.join(os.getcwd(), 'firefox', 'firefox')
    GECKO_PATH = os.path.join(os.getcwd(), 'geckodriver')
    OPTIONS = webdriver.FirefoxOptions()
    if headless:
        OPTIONS.set_headless()
    LOG_PATH = 'log.txt'

    browser = webdriver.Firefox(firefox_binary=FIREFOX_PATH,
                                executable_path=GECKO_PATH,
                                firefox_options=OPTIONS,
                                service_log_path=LOG_PATH)

    browser.implicitly_wait(10)
    browser.maximize_window()

    return browser


def download_google_image(headless):
    browser = build_firefox_browser(headless)

    browser.get('http://google.com/')
    print('Loaded Google main page...')

    # Submit query to google main page
    QUERY = 'Cute cat pics'
    search_field = browser.find_elements_by_class_name('gLFyf')[0]
    search_field.clear()
    search_field.send_keys(QUERY)
    time.sleep(2)
    search_field.submit()
    print(f'Submitted query for {QUERY}...')

    # Navigate to images
    search_tabs_parent = browser.find_element_by_id('hdtb-msb-vis')
    search_tabs = search_tabs_parent.find_elements_by_xpath('*')
    img_tab = search_tabs[1].find_elements_by_xpath('*')[0]
    time.sleep(2)
    img_tab.click()
    print('Going to image page...')

    # # Download first image
    # images = browser.find_element_by_id('search') \
    #     .find_elements_by_xpath('*')[0] \
    #     .find_elements_by_xpath('*')[1] \
    #     .find_elements_by_xpath('*')[0] \
    #     .find_elements_by_xpath('*')[0] \
    #     .find_elements_by_xpath('*')[1] \
    #     .find_elements_by_xpath('*')[0]
    # first_image = images.find_elements_by_
    # image_data = first_image.get_attribute('src').split(',')[1]
    # time.sleep(2)
    # print('Downloading image...')
    # with open(os.path.join(os.getcwd(), 'output', 'cute_kitty.jpg'), 'wb') as f:
    #     f.write(b64decode(image_data))

    browser.quit()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Selenium Python Example')
    parser.add_argument('--headless', action='store_true', help='Should the script run headless')
    args = parser.parse_args()

    try:
        download_google_image(bool(args.headless))
    except Exception as e:
        print(e)
