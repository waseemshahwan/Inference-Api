# Inference API

## TODO

- [ ] Add autoscale configs
- [ ] Add Dockerfile in here
- [ ] Improve for crosswalks
- [ ] Add rest of CAPTCHA classifications

## Setup

* Run Dockerfile (not yet placed here as of 05/23)

## Usage

Make sure to send batches of images at once when you can. To send multiple images, use Multipart form. Key values of Multipart form doesn't matter, values are read and parsed as images. You can make an example request in Insomnia by setting method to POST, path to `/`, and Body to `Multipart`. Each row should be of type file (click the arrow to the right of the value box, and click file). Upload JPEGs only. Results will come in JSON array.
