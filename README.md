# Inference API

## TODO

- [ ] Add threaded predictions
- [ ] Add autoscale configs

## Setup

* Locate and replace the updated model in `model/best.pt` if needed.
* Install `virtualenv`.
* Execute `virtualenv env` in the root folder.
* Activate your environment
    - For command prompt & powershell: execute `./env/Scripts/activate.bat` in the current shell session.
    - For git bash: execute `source ./env/Scripts/activate`.
    - You should see (env) in the beginning of your shell prompt.
* Install dependencies like so `pip3 install -r requirements.txt`
* Run the inference API with `python3 app.py`.
* Predict CAPTCHAs.

## Usage

Every request takes a minimum of `500ms` to solve. Every additional image packed in the same request takes only an extra `200ms`. Make sure to send batches of images at once when you can. To send multiple images, use Multipart form. Key values of Multipart form doesn't matter, values are read and parsed as images. You can make an example request in Insomnia by setting method to POST, path to `/`, and Body to `Multipart`. Each row should be of type file (click the arrow to the right of the value box, and click file). Upload JPEGs only. Results will come in JSON array.